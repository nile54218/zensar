-------------INDEXES----------------

create table production.parts(
part_id int not null,
part_name varchar(100)
)

insert into production.parts values
(1,'frame'),(2,'head tube'),(3,'handle bar grip'),(4,'shock absorber'),(5,'fork')

select * from production.parts where part_id=5

create clustered index ix_parts_id
on production.parts(part_id)

insert into production.parts values
(9,'abc')

select * from production.parts

create nonclustered index ix_customer_city
on sales.customers(city)

select customer_id,city from sales.customers
