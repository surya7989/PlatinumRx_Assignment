-- Q1: revenue from each sales channel for a given year (change year as needed)
select
    sales_channel,
    round(sum(amount), 2) as total_revenue
from clinic_sales
where EXTRACT(YEAR FROM datetime) = 2021
group by sales_channel
order by total_revenue desc;


-- Q2: top 10 most valuable customers for a given year
select
    c.uid,
    c.name,
    round(sum(cs.amount), 2) as total_spent
from clinic_sales cs
join customer c on cs.uid = c.uid
where EXTRACT(YEAR FROM cs.datetime) = 2021
group by c.uid, c.name
order by total_spent desc
limit 10;


-- Q3: month-wise revenue, expense, profit and status for a given year
with monthly_revenue as (
    select
        EXTRACT(MONTH FROM datetime) as month_num,
        round(sum(amount), 2) as revenue
    from clinic_sales
    where EXTRACT(YEAR FROM datetime) = 2021
    group by EXTRACT(MONTH FROM datetime)
),
monthly_expense as (
    select
        EXTRACT(MONTH FROM datetime) as month_num,
        round(sum(amount), 2) as expense
    from expenses
    where EXTRACT(YEAR FROM datetime) = 2021
    group by EXTRACT(MONTH FROM datetime)
)
select
    r.month_num,
    r.revenue,
    coalesce(e.expense, 0) as expense,
    round(r.revenue - coalesce(e.expense, 0), 2) as profit,
    case
        when r.revenue - coalesce(e.expense, 0) >= 0 then 'profitable'
        else 'not-profitable'
    end as status
from monthly_revenue r
left join monthly_expense e on r.month_num = e.month_num
order by r.month_num;


-- Q4: most profitable clinic per city for a given month (change month/year as needed)
with clinic_profit as (
    select
        cl.cid,
        cl.clinic_name,
        cl.city,
        coalesce(rev.revenue, 0) - coalesce(exp.expense, 0) as profit
    from clinics cl
    left join (
        select cid, sum(amount) as revenue
        from clinic_sales
        where EXTRACT(MONTH FROM datetime) = 11 and EXTRACT(YEAR FROM datetime) = 2021
        group by cid
    ) rev on cl.cid = rev.cid
    left join (
        select cid, sum(amount) as expense
        from expenses
        where EXTRACT(MONTH FROM datetime) = 11 and EXTRACT(YEAR FROM datetime) = 2021
        group by cid
    ) exp on cl.cid = exp.cid
),
ranked as (
    select *,
        rank() over (partition by city order by profit desc) as rnk
    from clinic_profit
)
select city, cid, clinic_name, profit
from ranked
where rnk = 1;


-- Q5: second least profitable clinic per state for a given month
with clinic_profit as (
    select
        cl.cid,
        cl.clinic_name,
        cl.state,
        coalesce(rev.revenue, 0) - coalesce(exp.expense, 0) as profit
    from clinics cl
    left join (
        select cid, sum(amount) as revenue
        from clinic_sales
        where EXTRACT(MONTH FROM datetime) = 11 and EXTRACT(YEAR FROM datetime) = 2021
        group by cid
    ) rev on cl.cid = rev.cid
    left join (
        select cid, sum(amount) as expense
        from expenses
        where EXTRACT(MONTH FROM datetime) = 11 and EXTRACT(YEAR FROM datetime) = 2021
        group by cid
    ) exp on cl.cid = exp.cid
),
ranked as (
    select *,
        rank() over (partition by state order by profit asc) as rnk
    from clinic_profit
)
select state, cid, clinic_name, profit
from ranked
where rnk = 2;