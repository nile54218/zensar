--------------VIEWS-----------------

---------creating view-----------
create view sales.product_info
as
select p.product_name,b.brand_name,p.list_price from production.products p inner join
production.brands b on p.brand_id=b.brand_id

--------calling view--------------
select * from sales.product_info where brand_name='trek'


---------alter view--------------
-----for example---------
alter view sales.product_info
as
select p.product_name,b.brand_name,p.list_price from production.products p inner join
production.brands b on p.brand_id=b.brand_id

-------droping view-----------
drop view sales.product_info


select * from sys.all_views


