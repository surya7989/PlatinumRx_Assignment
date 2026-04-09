create table clinics (
    cid varchar(50) primary key,
    clinic_name varchar(100),
    city varchar(100),
    state varchar(100),
    country varchar(100)
);

create table customer (
    uid varchar(50) primary key,
    name varchar(100),
    mobile varchar(15)
);

create table clinic_sales (
    oid varchar(50) primary key,
    uid varchar(50),
    cid varchar(50),
    amount decimal(10, 2),
    datetime timestamp,
    sales_channel varchar(50),
    foreign key (uid) references customer(uid),
    foreign key (cid) references clinics(cid)
);

create table expenses (
    eid varchar(50) primary key,
    cid varchar(50),
    description text,
    amount decimal(10, 2),
    datetime timestamp,
    foreign key (cid) references clinics(cid)
);

-- sample data
insert into clinics values
('cnc-0100001', 'XYZ Clinic', 'Mumbai', 'Maharashtra', 'India'),
('cnc-0100002', 'ABC Health', 'Pune', 'Maharashtra', 'India'),
('cnc-0100003', 'HealthFirst', 'Chennai', 'Tamil Nadu', 'India'),
('cnc-0100004', 'CarePoint', 'Coimbatore', 'Tamil Nadu', 'India');

insert into customer values
('cust-001', 'Jon Doe', '9700000001'),
('cust-002', 'Alice Brown', '9700000002'),
('cust-003', 'Bob Singh', '9700000003');

insert into clinic_sales values
('ord-00100-00100', 'cust-001', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'online'),
('ord-00100-00101', 'cust-002', 'cnc-0100001', 15000, '2021-10-10 09:00:00', 'walk-in'),
('ord-00100-00102', 'cust-003', 'cnc-0100002', 8000,  '2021-10-15 11:30:00', 'online'),
('ord-00100-00103', 'cust-001', 'cnc-0100002', 12000, '2021-11-05 14:00:00', 'walk-in'),
('ord-00100-00104', 'cust-002', 'cnc-0100003', 30000, '2021-11-20 10:00:00', 'online'),
('ord-00100-00105', 'cust-003', 'cnc-0100004', 5000,  '2021-12-01 08:00:00', 'referral'),
('ord-00100-00106', 'cust-001', 'cnc-0100003', 22000, '2021-12-15 16:00:00', 'walk-in');

insert into expenses values
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557,  '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100001', 'staff salary',       8000, '2021-10-31 00:00:00'),
('exp-0100-00102', 'cnc-0100002', 'rent',               5000, '2021-10-01 00:00:00'),
('exp-0100-00103', 'cnc-0100002', 'utilities',          1200, '2021-11-01 00:00:00'),
('exp-0100-00104', 'cnc-0100003', 'equipment',          10000,'2021-11-15 00:00:00'),
('exp-0100-00105', 'cnc-0100004', 'medicines',          3000, '2021-12-05 00:00:00');