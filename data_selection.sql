---select---

select * from production.products
select product_id as 'ID',product_name as 'NAME',list_price as 'PRICE' from production.products

---order by clause---
select * from sales.customers order by first_name
select * from sales.customers order by first_name desc
select * from sales.customers order by city desc,first_name asc

---select top ---
select top (10) customer_id,first_name,city from sales.customers
select top (10) * from sales.customers where state='CA' order by first_name

-----distinct------
select distinct (city) from sales.customers
select distinct state,city from sales.customers


------where clause-------
select * from sales.customers where state='CA' and city='encino'
select * from sales.customers where state<>'CA'

------IN operator-------
select * from production.products where list_price in(269.99,999.99,429) order by list_price

-----IS NULL operator-------
select * from sales.customers where phone is null

-----NULL-------
select * from sales.customers where phone is not null


-----LIKE -------
select * from sales.customers where last_name like 'Z%'
select * from sales.customers where last_name like '%ER'
select * from sales.customers where last_name like 'T%S'
select * from sales.customers where last_name like '_U%'
select * from sales.customers where city like 'S%'
select * from sales.customers where last_name like 'S%O'
select * from sales.customers where last_name like '_A%'
select * from sales.customers where last_name like '[YZ]%'
select * from sales.customers where last_name not like '[YZ]%'
select * from sales.customers where city like '[OS]%'


--------JOINS----------

------INNER JOIN-------

select br.brand_id,br.brand_name,pr.product_name,pr.list_price from production.brands as br inner join production.products as pr
on br.brand_id=pr.brand_id
where br.brand_id=9


select ord.order_id,ord.customer_id,ord.order_date,orit.product_id,orit.quantity,orit.list_price from sales.orders as ord inner join sales.order_items as orit
on ord.order_id=orit.order_id


-------LEFT JOIN----------

select * from production.products pr left join sales.order_items oi
on pr.product_id=oi.product_id


select * from production.categories cat left join production.products pro
on cat.category_id=pro.category_id


--------RIGHT JOIN----------

select * from sales.orders ord right join sales.customers cust
on ord.customer_id=cust.customer_id


--------FULL JOIN------------

create table projects(
project_id int primary key,
title varchar(20) not null
)

create table members(
member_id int primary key,
name varchar(20) not null,
project_id int,
foreign key(project_id) references projects(project_id)
)

insert into projects values
(1,'crm'),(2,'erp'),(3,'cms'),(4,'pm')


insert into members values
(100,'john',1),(101,'lily',1),(102,'jane',2),(103,'jack',null)


select * from projects pr full join members m
on pr.project_id = m.project_id


create table myproduct(
product_id int,
product_name varchar(20)
)

create table myorder(
order_id int,
customer_name varchar(20),
product_id int
)


insert into myproduct values
(1,'bike'),(2,'monitor'),(3,'mobile'),(4,'tv')

insert into myorder values
(1,'bill',2),(2,'mark',3)

select * from myproduct pr full join myorder ord
on pr.product_id=ord.product_id

create table mystaff(
staff_id int,
staff_name varchar(20)
)

create table mystore(
store_id int,
store_name varchar(20),
staff_id int
)

insert into mystaff values
(1,'bill'),(2,'mark'),(3,'merry')

insert into mystore values
(1,'abc',1),(2,'xyz',3),(3,'yzf',null)

select * from mystaff full join mystore
on mystaff.staff_id=mystore.staff_id

---------GROUP BY-----------

-------display customer id with respective no of orders
select sales.orders.customer_id,count(order_id) as 'order count' from sales.orders where customer_id in(1,2)
group by customer_id


-----display city with respective no of customers
select sales.customers.city, count(customer_id) as 'customer count' from sales.customers
group by city
order by city


select order_id,sum(quantity*list_price) as 'order value' from sales.order_items
group by order_id

select pr.brand_id,count(pr.product_id) from production.products pr
group by pr.brand_id

----to display brand ID and Name with total no of products
select br.brand_id,br.brand_name,count(pr.product_id) as 'no of products' from production.brands br inner join production.products pr
on br.brand_id=pr.brand_id
group by br.brand_id,br.brand_name


--------HAVING CLAUSE-----------

select customer_id,count(order_id) as 'order count' from sales.orders
group by customer_id
having count(order_id)>2


----------display orders having amount greater than 20000
select order_id,sum(quantity*list_price) as 'order value' from sales.order_items
group by order_id
having sum(quantity*list_price)>20000
order by 'order value'


----------SUB QUERIES--------------

select * from sales.orders
where customer_id in (
select customer_id from sales.customers where city='new york'
)

select order_id,customer_id from sales.orders
where order_id in(
select order_id from sales.order_items where product_id=20
)


select product_id,product_name from production.products
where category_id in(
select category_id from production.categories where category_name='mountain bikes'
)

select * from sales.orders
where customer_id not in (
select customer_id from sales.customers where city='new york')


---------ALL OPERATOR---------------


select * from production.products
where list_price >= all(select avg(list_price) from production.products group by brand_id)

--------UNION------------
select first_name,last_name from sales.staffs
union
select first_name,last_name from sales.customers

select state,city from sales.customers
intersect
select state,city from sales.stores


select product_id from production.products
except
select product_id from sales.order_items

--------CTE (COMMON TABLE EXPRESSION)-------------

with cte_sales as(
select staff_id, count(*) order_count
from sales.orders
where year(order_date)='2018'
group by staff_id
)
select avg(order_count) avg_orders_by_staff from cte_sales



