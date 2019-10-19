--create database bikesmodel

create schema sales
create schema production

create table sales.stores(
store_id	int identity(1,1) primary key,--identity for auto increment
store_name	varchar(20) not null,
phone		varchar(10),
email		varchar(100),
city		varchar(100),
state		varchar(50),
zip_code	varchar(5)
)


create table sales.quotations(
quotation_no	int identity(1,1) primary key,
valid_from		date not null,
valid_to		date not null
)


alter table sales.quotations
add description varchar(50) not null --add new column


alter table sales.quotations
alter column description varchar(30) not null --alter column


alter table sales.quotations
drop column description  --drop column


create table persons(
person_id	int identity primary key,
first_name	varchar(50) not null,
last_name	varchar(50) not null,
dob			date
)


insert into persons(first_name,last_name,dob)
 values('sachin','tendulkar','1978-04-24'),
 ('saurabh','ganguly','1974-02-14'),
 ('rahul','dravid','1972-01-10')


 select * from dbo.persons

alter table persons
add full_name as (first_name+' '+last_name)


exec sp_rename 'persons','person'

drop table #vipperson

create table #vipperson(
person_id	int primary key,
first_name	varchar(20) not null,
last_name	varchar(20) not null
)


insert into #vipperson
select person.person_id,person.first_name,person.last_name
from dbo.person


select * from #vipperson where person_id < 3

-- primary key and foreign key constraint

create table sales.staffs(
staff_id	int primary key,
first_name	varchar(50) not null,
last_name	varchar(50) not null,
email		varchar(100) not null,
store_id	int not null,
constraint fk_staff_stores foreign key (store_id)
references sales.stores(store_id)
)


-- check constraint

create table sales.ordered_items(
order_id	int not null,
item_id		int not null,
order_quantity int check(order_quantity > 0) not null,
unit_price	int check(unit_price > 0) not null
)


insert into sales.ordered_items values(1,1,5,100)
select * from sales.ordered_items

alter table sales.ordered_items
add order_amount as (order_quantity * unit_price)


-- unique constraint

create table sales.customers(
customer_id	int primary key identity,
first_name	varchar(50) not null,
last_name	varchar(50) not null,
email		varchar(50) unique
)


insert into sales.customers(first_name,last_name,email)
values('scott','smith','scott@gmail.com'),
('tiger','wong','tiger@gmail.com')


select * from sales.customers
