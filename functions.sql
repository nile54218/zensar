-----------UDF SCALAR FUNCTION------------

create function sales.udf_netsale(
@quantity int,
@list_price dec(10,2)
)
returns dec(10,2)
as
begin
	return @quantity * @list_price
end


select sales.udf_netsale(10,100) as 'net sale'

select order_id,(sales.udf_netsale(quantity,list_price)) as 'total bill' from sales.order_items



-------------TABLE VARIABLE---------------

declare @product_table table(
product_name varchar(max) not null,
brand_id int not null,
list_price dec(10,2) not null
)

insert into @product_table
select product_name,brand_id,list_price from production.products
where product_id=2

select * from @product_table


----------WINDOW FUNCTION----------------

select product_id,product_name,list_price,
rank() over(order by list_price desc) as 'rank'
from production.products	




  