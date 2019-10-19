
insert into sales.customers(first_name,last_name,email)
values('john','smith','john@gmail.com'),
('merry','merry','merry@gmail.com'),
('adam','adam','adam@gmail.com')


select * from sales.customers

-- update record
update sales.customers set first_name='scott123', last_name='scott123',
email='scott123@gmail.com' where customer_id=3


-- delete

delete from sales.customers where customer_id=4
select * from sales.customers

delete top(1) from sales.customers

truncate table sales.customers

insert into sales.customers(first_name,last_name,email)
values('mark','mark','mark@gmail.com'),
('bill','bill','bill@gmail.com'),
('jay','jay','jay@gmail.com')



select * from person
delete top(1) from person

insert into person(person_id,first_name,last_name,dob)
values(1,'virat','kohli','1990-05-12')