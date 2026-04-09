create table users (
    user_id varchar(50) primary key,
    name varchar(100),
    phone_number varchar(15),
    mail_id varchar(100),
    billing_address text
);

create table bookings (
    booking_id varchar(50) primary key,
    booking_date timestamp,
    room_no varchar(50),
    user_id varchar(50),
    foreign key (user_id) references users(user_id)
);

create table items (
    item_id varchar(50) primary key,
    item_name varchar(100),
    item_rate decimal(10, 2)
);

create table booking_commercials (
    id varchar(50) primary key,
    booking_id varchar(50),
    bill_id varchar(50),
    bill_date timestamp,
    item_id varchar(50),
    item_quantity decimal(10, 2),
    foreign key (booking_id) references bookings(booking_id),
    foreign key (item_id) references items(item_id)
);

-- sample data
insert into users values
('21wrcxuy-67erfn', 'John Doe', '9700000001', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('21wrcxuy-67erfx', 'Jane Smith', '9700000002', 'jane.smith@example.com', 'YY, Street Z, DEF City');

insert into items values
('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg', 89),
('itm-w978-23u4', 'Dal Fry', 120),
('itm-b234-cde5', 'Paneer Butter Masala', 180),
('itm-f567-ghi8', 'Butter Naan', 40);

insert into bookings values
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o1',  '2021-10-05 10:00:00', 'rm-xyz1-abcde', '21wrcxuy-67erfx'),
('bk-q034-q4o2',  '2021-10-15 11:00:00', 'rm-xyz2-fghij', '21wrcxuy-67erfn'),
('bk-q034-q4o3',  '2021-11-01 09:00:00', 'rm-xyz3-klmno', '21wrcxuy-67erfx'),
('bk-q034-q4o4',  '2021-11-20 08:00:00', 'rm-xyz4-pqrst', '21wrcxuy-67erfn');

insert into booking_commercials values
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4','bk-q034-q4o1', 'bl-34qhd-r7h8', '2021-10-05 12:05:37', 'itm-w978-23u4', 2),
('134lr-oyfo8-3qk5','bk-q034-q4o1', 'bl-34qhd-r7h8', '2021-10-05 12:05:37', 'itm-b234-cde5', 1),
('134lr-oyfo8-3qk6','bk-q034-q4o2', 'bl-34qhd-r7h9', '2021-10-15 13:00:00', 'itm-f567-ghi8', 5),
('134lr-oyfo8-3qk7','bk-q034-q4o2', 'bl-34qhd-r7h9', '2021-10-15 13:00:00', 'itm-a9e8-q8fu', 10),
('134lr-oyfo8-3qk8','bk-q034-q4o3', 'bl-34qhd-r8h0', '2021-11-01 14:00:00', 'itm-a07vh-aer8', 3),
('134lr-oyfo8-3qk9','bk-q034-q4o4', 'bl-34qhd-r8h1', '2021-11-20 09:30:00', 'itm-b234-cde5', 2);