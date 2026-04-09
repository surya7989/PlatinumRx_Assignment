-- Q1: for every user, get their last booked room
select
    b.user_id,
    b.room_no as last_booked_room
from bookings b
inner join (
    select user_id, max(booking_date) as latest_booking
    from bookings
    group by user_id
) latest on b.user_id = latest.user_id and b.booking_date = latest.latest_booking;


-- Q2: booking_id and total billing amount for bookings made in november 2021
select
    bc.booking_id,
    bc.bill_id,
    round(sum(bc.item_quantity * i.item_rate), 2) as total_bill_amount
from booking_commercials bc
join items i on bc.item_id = i.item_id
where EXTRACT(MONTH FROM bc.bill_date) = 11 and EXTRACT(YEAR FROM bc.bill_date) = 2021
group by bc.booking_id, bc.bill_id;


-- Q3: bill_id and bill amount for october 2021 bills where amount > 1000
select
    bill_id,
    round(sum(item_quantity * item_rate), 2) as bill_amount
from booking_commercials bc
join items i on bc.item_id = i.item_id
where EXTRACT(MONTH FROM bc.bill_date) = 10 and EXTRACT(YEAR FROM bc.bill_date) = 2021
group by bill_id
having round(sum(item_quantity * item_rate), 2) > 1000;


-- Q4: most and least ordered item per month in 2021
with monthly_item_totals as (
    select
        EXTRACT(MONTH FROM bc.bill_date) as month_num,
        i.item_name,
        sum(bc.item_quantity) as total_qty
    from booking_commercials bc
    join items i on bc.item_id = i.item_id
    where EXTRACT(YEAR FROM bc.bill_date) = 2021
    group by EXTRACT(MONTH FROM bc.bill_date), i.item_name
),
ranked as (
    select
        month_num,
        item_name,
        total_qty,
        rank() over (partition by month_num order by total_qty desc) as rnk_desc,
        rank() over (partition by month_num order by total_qty asc) as rnk_asc
    from monthly_item_totals
)
select
    month_num,
    max(case when rnk_desc = 1 then item_name end) as most_ordered,
    max(case when rnk_asc = 1 then item_name end) as least_ordered
from ranked
group by month_num
order by month_num;


-- Q5: customer with the 2nd highest bill value per month in 2021
with bill_totals as (
    select
        EXTRACT(MONTH FROM bc.bill_date) as month_num,
        b.user_id,
        bc.bill_id,
        round(sum(bc.item_quantity * i.item_rate), 2) as bill_amount
    from booking_commercials bc
    join items i on bc.item_id = i.item_id
    join bookings b on bc.booking_id = b.booking_id
    where EXTRACT(YEAR FROM bc.bill_date) = 2021
    group by EXTRACT(MONTH FROM bc.bill_date), b.user_id, bc.bill_id
),
ranked as (
    select
        month_num,
        user_id,
        bill_id,
        bill_amount,
        dense_rank() over (partition by month_num order by bill_amount desc) as rnk
    from bill_totals
)
select month_num, user_id, bill_id, bill_amount
from ranked
where rnk = 2
order by month_num;