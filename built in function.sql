---------FUNCTIONS-------------
select avg(list_price) as 'average price' from production.products

select count(*) as 'customer count' from sales.customers

select max(list_price) as 'max price' from production.products

select min(list_price) as 'min price' from production.products

select sum(quantity*list_price) as 'total sales' from sales.order_items

select sum(quantity) as 'total sold quantity' from sales.order_items where product_id=177


----------DATE TIME FUNCTIONS-------------
select getdate()

select sysdatetime()

select datename(day,getdate())

select day(getdate())

select month(getdate())

select order_id,customer_id,month(order_date) 'month',year(order_date) 'year'
from sales.orders

declare @d datetime='10-10-2000';
select datediff(year,@d,getdate())

select dateadd(day,10,getdate())

select eomonth(getdate(),0)

select isdate('03-19-2000')

select ascii('a')
select concat(first_name,' ',last_name) from sales.customers
select replace('i want to have a cup of coffee','coffee','tea')

