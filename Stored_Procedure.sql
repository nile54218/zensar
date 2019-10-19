-----------STORED PROCEDURES------------

-----cration date: 18-oct-2019
---author: nilesh
---description: to display product list

create procedure usp_productlist
----declare parameters
as
begin
----body of stored procedures
	select * from production.products order by product_name
end


-------alter SP--------

alter procedure usp_productlist
----declare parameters
as
begin
----body of stored procedures
	select * from production.products order by product_name
end


---------CALLING SP---------

exec dbo.usp_productlist

--------DROP SP-----------
drop procedure dbo.usp_productlist


--------PARAMETERISED SP-------
------CREATION DATE: 18-OCT-2019
-----AUTHOR: NILESH
-----DESCRIPTION: DISPLAY PRODUCT BY LIST PRICE

create procedure usp_findproduct_by_listprice
@listprice decimal(10,2)
as
begin
	select * from production.products
	where list_price=@listprice
	order by list_price
end


---------CALLING SP----------
exec usp_findproduct_by_listprice @listprice=449.99

---------SP FOR INSERT---------
create procedure usp_save_brands
@brand_name varchar(255)
as
begin
	insert into production.brands (brand_name) values (@brand_name)
end


usp_save_brands @brand_name='steelbirds'

select * from production.brands


create procedure usp_insert_category
@category_name varchar(50)
as
begin
	insert into production.categories (category_name) values(@category_name)
	select * from production.categories
end

usp_insert_category @category_name='mobiles'


----------SP WITH OUTPUT PARAMETER-------------

alter procedure usp_insert_category
@category_name varchar(50),
@category_count int output
as
begin
	insert into production.categories (category_name) values(@category_name)
	select @category_count=count(*) from production.categories
end

declare @count int;
exec usp_insert_category
@category_name='laptops',
@category_count=@count output
select @count as 'category count'


create procedure usp_count_product
@product_name varchar(255),
@product_count int output
as
begin
	select products.product_name from production.products
	where product_name=@product_name
	select @product_count=count(product_id) from production.products where product_name=@product_name
end

select * from production.products

declare @prod_count int;
exec usp_count_product
@product_name='Haro Shredder 20 - 2017',
@product_count=@prod_count output
select @prod_count as 'product count'


select count(*) from production.products where product_name='Haro Shredder 20 - 2017'


create view production.show_all_brands
as
select * from production.brands


create procedure usp_insert_brand
@brand_name varchar(50)
as
begin
	insert into production.brands (brand_name) values(@brand_name)
	select * from production.show_all_brands
end


usp_insert_brand @brand_name='mybrand'


----------TRY CATCH---------------
create procedure usp_divide
@a decimal,
@b decimal,
@c decimal output
as
begin
	begin try
		set @c=@a/@b;
	end try
	begin catch
		select
		ERROR_NUMBER() as 'error number',
		ERROR_MESSAGE() as 'error message',
		ERROR_LINE() as 'line no',
		ERROR_PROCEDURE() as 'sp name'
	end catch
end


declare @r decimal
exec usp_divide 10,0,@r output
print @r


create procedure usp_test
@a decimal,
@b varchar(10),
@c decimal output
as
begin
	begin try
		set @c=@a/@b;
	end try
	begin catch
		select
		ERROR_NUMBER() as 'error number',
		ERROR_MESSAGE() as 'error message',
		ERROR_LINE() as 'line no',
		ERROR_PROCEDURE() as 'sp name'
	end catch
end

declare @s decimal
exec usp_test 10,'a',@s output
print @s
