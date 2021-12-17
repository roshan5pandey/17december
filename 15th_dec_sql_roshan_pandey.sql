create schema onlineshop
drop schema onlineshop
select * from sys.schemas
create schema onlineshop

create table onlineshop.product(
prod_id int primary key identity(1,1),
prod_name varchar(50) not null,
prod_price float not null,
prod_category varchar(50) not null,
prod_description varchar(50) not null
)
drop table onlineshop.product
insert into onlineshop.product values('roshan',5000,'sofa','good product')
insert into onlineshop.product values('sofa1',8000,'furniture','good product'),('chair',1000,'furniture','good product'),('sofa3',8000,'furniture','good product'),('desk',5000,'furniture','good product')
select * from onlineshop.product 

create table onlineshop.customer(
cust_id int primary key,
cust_name varchar(50),
cust_address varchar(50),
cust_phone varchar(50),
cust_email varchar(50),
)

create sequence newi
start with 1
increment by 1
maxvalue 10
cycle;
insert into onlineshop.customer values(next value for  newi,'roshan','allahabad','9009876754','roshan@gmail.com')
select * from onlineshop.customer
insert into onlineshop.customer values(next value for  newi,'bhusan','muradabad','9009876754','bhusan@gmail.com'),
(next value for  newi,'baba','naini','7007334632','baba@gmail.com'),
(next value for  newi,'sachi','localganj','7309876754','sachi@gmail.com'),
(next value for  newi,'mangal','delhi','7007334632','mangal@gmail.com')


create table onlineshop.customer_audit(
id int identity,
messagep text
)

-- trigger

create trigger customer_trigger
on onlineshop.customer
for insert,update,delete
as begin
   declare @id int
   select @id =cust_id from inserted
   insert into onlineshop.customer_audit values('new employee with id = '+cast(@id as varchar(30))+'is added at '+cast(getdate() as varchar(30))
   )
   end

   insert into onlineshop.customer values(next value for  newi,'roshan','allahabad','9009876754','roshan@gmail.com')

   select * from onlineshop.customer_audit



--purchase table
create table onlineshop.purchase(
purchase_id int primary key identity(1,1),
purchase_date datetime not null,
product_id int not null,
product_price float not null,
product_quantity int not null,
cust_id int references onlineshop.customer(cust_id)
)

select * from onlineshop.purchase
insert into onlineshop.purchase values('3/3/2021',2,1000,2,2),
('4/4/2021',3,5000,3,3) ,
('5/5/2021',4,3000,2,4) ,
('6/6/2021',5,4000,2,5) 



create table onlineshop.ordertable(
order_id int primary key  identity,
order_date datetime,
product_id int ,
cust_id int,
order_price float 
)
drop table onlineshop.ordertable

create trigger purchase_trigger
on onlineshop.purchase
for insert,update,delete
as begin
   declare @id int,@cust_id int,@proprice int,@proquan int,@price int
   select @id =product_id , @cust_id = cust_id,@proquan = product_quantity,@proprice = product_price,@price = (@proquan*@proprice) from inserted
   insert into onlineshop.ordertable values( cast(getdate() as varchar(30)),cast(@id as int),cast(@cust_id as int),cast(@price as float))
   
   end


   truncate table onlineshop.purchase

   insert into onlineshop.purchase values('3/3/2021',2,5000,3,3)
   select * from onlineshop.ordertable

   create table registretion(
   employee_id int primary key,
   employee_name varchar(50),
   employee_address varchar(20),
   employee_username varchar(20),
   employee_password varchar(50),
   employee_dob int ,
   employee_age int
   )
   
   create function age(@yob int)
   returns int
   begin
        declare @result int
        set @result = (SELECT DATEPART(year, CURRENT_TIMESTAMP))-@yob
	   return @result
  end
  drop function age

select dbo.age(1999)

insert into registretion values(2,'baba','naini','babapandey','baba@123',1995,(select dbo.age(1995))),
(3,'yogesh','hydrabad','yogeshyadav','yogesh@123',2005,(select dbo.age(2005))),
(4,'bhola','bholam','bholamguru','bholay@123',2007,(select dbo.age(2007))),
(5,'rastogi','basantpur','basantpandey','basant@123',2006,(select dbo.age(2006)))

truncate table registretion

select * from registretion
create table logininfo(
id int primary key identity(1,1),
employee_name varchar(20),
employee_username varchar(20),
employee_password varchar(20),
)

   create trigger login_trigger
on registretion
for insert,update,delete
as begin
   declare @empname varchar(20),@empusername varchar(20),@emppass varchar(20) 
   select @empname =employee_name , @empusername = employee_username,@emppass = employee_password from inserted
   insert into logininfo values( cast(@empname  as varchar(20)),cast(@empusername as varchar(20)),cast(@emppass as varchar(20)))
   
   end


   select * from logininfo













