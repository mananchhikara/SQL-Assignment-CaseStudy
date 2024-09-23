--step 1: create the database

create database techshop
use techshop

--1. customers table

create table customers (
customerid int identity(1,1) primary key,
firstname nvarchar(50) not null,
lastname nvarchar(50) not null,
email nvarchar(100) not null unique,
phone nvarchar(15) not null,
address nvarchar(255)
)

--2. products table

create table products (
productid int identity(1,1) primary key,
productname nvarchar(100) not null,
description nvarchar(max),
price decimal(10, 2) not null
)

--3. orders table

create table orders (
orderid int identity(1,1) primary key,
customerid int not null,
orderdate date not null,
totalamount decimal(10, 2) not null,
constraint fk_orders_customers foreign key (customerid) references customers(customerid)
)

--4. orderdetails table

create table orderdetails (
orderdetailid int identity(1,1) primary key,
orderid int not null,
productid int not null,
quantity int not null,
constraint fk_orderdetails_orders foreign key (orderid) references orders(orderid),
constraint fk_orderdetails_products foreign key (productid) references products(productid)
)

--5. inventory table

create table inventory (
inventoryid int identity(1,1) primary key,
productid int not null,
quantityinstock int not null,
laststockupdate date not null,
constraint fk_inventory_products foreign key (productid) references products(productid)
)

--1. inserting records into customers table

insert into customers (firstname, lastname, email, phone, address)
values 
('amit', 'sharma', 'amit.sharma@example.com', '9876543210', '12, mg road, mumbai, maharashtra'),
('sneha', 'patel', 'sneha.patel@example.com', '9123456789', '34, park street, ahmedabad, gujarat'),
('rahul', 'mehta', 'rahul.mehta@example.com', '9988776655', '78, nehru nagar, delhi'),
('priya', 'nair', 'priya.nair@example.com', '9876543211', '56, brigade road, bangalore, karnataka'),
('arjun', 'reddy', 'arjun.reddy@example.com', '9234567890', '89, jubilee hills, hyderabad, telangana'),
('neha', 'singh', 'neha.singh@example.com', '9112345678', '22, civil lines, jaipur, rajasthan'),
('vikram', 'kumar', 'vikram.kumar@example.com', '9321654987', '11, mg road, pune, maharashtra'),
('suman', 'das', 'suman.das@example.com', '9001234567', '90, salt lake, kolkata, west bengal'),
('ravi', 'verma', 'ravi.verma@example.com', '9432123456', '45, rajendra nagar, patna, bihar'),
('anjali', 'joshi', 'anjali.joshi@example.com', '9198765432', '67, connaught place, delhi')

--2. inserting records into products table

insert into products (productname, description, price)
values 
('smartphone', 'latest model with 5g connectivity and 128gb storage', 25000.00),
('laptop', '14-inch display, 8gb ram, 256gb ssd', 55000.00),
('smartwatch', 'water-resistant with heart rate monitor', 10000.00),
('headphones', 'noise-cancelling over-ear headphones', 5000.00),
('tablet', '10-inch display, 64gb storage, 4g connectivity', 20000.00),
('bluetooth speaker', 'portable with 12-hour battery life', 3000.00),
('gaming console', 'next-gen console with 1tb storage', 45000.00),
('external hard drive', '1tb storage, usb 3.0', 4000.00),
('wireless mouse', 'ergonomic design, rechargeable battery', 1500.00),
('fitness band', 'activity tracker with heart rate monitor', 2500.00)

--3. inserting records into orders table

insert into orders (customerid, orderdate, totalamount)
values 
(1, '2024-09-01', 45000.00),
(2, '2024-09-02', 25000.00),
(3, '2024-09-03', 3000.00),
(4, '2024-09-04', 10000.00),
(5, '2024-09-05', 55000.00),
(6, '2024-09-06', 4000.00),
(7, '2024-09-07', 5000.00),
(8, '2024-09-08', 2500.00),
(9, '2024-09-09', 1500.00),
(10, '2024-09-10', 20000.00)

--4. inserting records into orderdetails table

insert into orderdetails (orderid, productid, quantity)
values 
(1, 7, 1),
(2, 1, 1),
(3, 6, 1),
(4, 3, 1),
(5, 2, 1),
(6, 8, 1),
(7, 4, 1),
(8, 10, 1),
(9, 9, 1),
(10, 5, 1)

--5. inserting records into inventory table

insert into inventory (productid, quantityinstock, laststockupdate)
values 
(1, 100, '2024-08-01'),
(2, 50, '2024-08-02'),
(3, 75, '2024-08-03'),
(4, 200, '2024-08-04'),
(5, 30, '2024-08-05'),
(6, 150, '2024-08-06'),
(7, 20, '2024-08-07'),
(8, 80, '2024-08-08'),
(9, 120, '2024-08-09'),
(10, 60, '2024-08-10')

--task 2
--1. retrieve the names and emails of all customers.

select firstname, lastname, email 
from customers

--2. list all orders with their order dates and corresponding customer names.

select orders.orderid, orders.orderdate, customers.firstname, customers.lastname 
from orders
inner join customers on orders.customerid = customers.customerid

--3. insert a new customer record into the "customers" table.

insert into customers (firstname, lastname, email, phone, address)
values ('ravi', 'kumar', 'ravi.kumar@example.com', '9998887776', '123, mg road, bangalore, karnataka')

--4. update the prices of all electronic gadgets in the "products" table by increasing them by 10%.

update products
set price = price * 1.10

--5. delete a specific order and its associated order details from the "orders" and "orderdetails" tables.

declare @orderid int
set @orderid = 3  
delete from orderdetails
where orderid = @orderid
delete from orders
where orderid = @orderid

--6. insert a new order into the "orders" table.

insert into orders (customerid, orderdate, totalamount)
values (1, '2024-09-15', 7500.00)  

--7. update the contact information (e.g., email and address) of a specific customer in the "customers" table.

declare @customerid int = 5  
declare @newemail nvarchar(100) = 'new.email@example.com'
declare @newaddress nvarchar(255) = '456, new avenue, pune, maharashtra'
update customers
set email = @newemail, address = @newaddress
where customerid = @customerid

--8. recalculate and update the total cost of each order in the "orders" table.

update orders
set totalamount = (select sum(orderdetails.quantity * products.price)
from orderdetails
inner join products on orderdetails.productid = products.productid
where orderdetails.orderid = orders.orderid);
select * from orders

--9. delete all orders and their associated order details for a specific customer.

declare @customeridtodelete int = 1 
delete from orderdetails
where orderid in (select orderid from orders where customerid = @customeridtodelete)
delete from orders
where customerid = @customeridtodelete

--10. insert a new electronic gadget product into the "products" table.

insert into products (productname, description, price)
values ('smart speaker', 'voice-controlled smart speaker with bluetooth and wi-fi connectivity', 15000.00)

--11. update the status of a specific order in the "orders" table.

declare @orderidtoupdate int = 5  
declare @neworderdate date = '2024-09-20'
update orders
set orderdate = @neworderdate
where orderid = @orderidtoupdate

--12. calculate and update the number of orders placed by each customer in the "customers" table.

alter table customers
add numorders int;
update customers
set numorders = (select count(*) from orders where orders.customerid = customers.customerid);
select * from customers

select * from orders

--task 3

--1. retrieve a list of all orders along with customer information 

select 
orders.orderid,
orders.orderdate,
customers.firstname,
customers.lastname,
customers.email,
customers.phone
from orders
join customers on orders.customerid = customers.customerid

--2. calculate and display the total sales revenue for each product.

select 
products.productname,
sum(orderdetails.quantity * products.price) as totalrevenue
from orderdetails
join products on orderdetails.productid = products.productid
group by products.productname

--3. list all customers who have made at least one purchase

select distinct customers.firstname, customers.lastname, customers.email, customers.phone
from customers
join orders on customers.customerid = orders.customerid

--4. find the most popular electronic gadget (highest total quantity ordered)

select products.productname, sum(orderdetails.quantity) as totalquantityordered
from orderdetails
join products on orderdetails.productid = products.productid
group by products.productname
order by totalquantityordered desc

--5. retrieve a list of electronic gadgets along with their corresponding categories

select * from products
create table categories (
categoryid int primary key identity(1,1),
categoryname varchar(100)
)
insert into categories (categoryname)
values ('electronics'),
('wearables'),
('audio'),
('computers'),
('home appliances')
create table productcategories (
productcategoryid int primary key identity(1,1),
productid int foreign key references products(productid),
categoryid int foreign key references categories(categoryid)
)

insert into productcategories (productid, categoryid)
values (1, 1),
(2, 3), (3, 2), (4, 3), (5, 1), 
(6, 3), (7, 1), (8, 1), (9, 3), 
(10, 2), (11, 3) 

select 
products.productname,
categories.categoryname
from 
products
inner join 
productcategories on products.productid = productcategories.productid
inner join 
categories on productcategories.categoryid = categories.categoryid;

--6. calculate the average order value for each customer

select customers.firstname, customers.lastname, avg(orders.totalamount) as averageordervalue
from customers
join orders on customers.customerid = orders.customerid
group by customers.customerid, customers.firstname, customers.lastname

--7. find the order with the highest total revenue

select top 1 orders.orderid, customers.firstname, customers.lastname, orders.totalamount
from orders
join customers on orders.customerid = customers.customerid
order by orders.totalamount desc

--8. list electronic gadgets and the number of times each product has been ordered

select products.productname, sum(orderdetails.quantity) as timesordered
from orderdetails
join products on orderdetails.productid = products.productid
group by products.productname

--9. find customers who have purchased a specific electronic gadget product

declare @productname nvarchar(100) = 'laptop'
select distinct customers.firstname, customers.lastname, customers.email
from customers
join orders on customers.customerid = orders.customerid
join orderdetails on orders.orderid = orderdetails.orderid
join products on orderdetails.productid = products.productid
where products.productname = @productname

--10. calculate the total revenue generated by all orders placed within a specific time period

declare @startdate date = '2024-09-02'
declare @enddate date = '2024-09-06'
select sum(totalamount) as totalrevenue
from orders
where orderdate between @startdate and @enddate

--task 4

--1. find out which customers have not placed any orders

select customers.firstname, customers.lastname, customers.email
from customers
where customers.customerid not in (select customerid from orders)

--2. find the total number of products available for sale

select count(*) as totalproducts
from products

--3. calculate the total revenue generated by techshop

select sum(orderdetails.quantity * products.price) as totalrevenue
from orderdetails
join products on orderdetails.productid = products.productid

--4. calculate the average quantity ordered for products in a specific category

select 
categories.categoryname,
avg(orderdetails.quantity) as averagequantity
from 
products
inner join 
productcategories on products.productid = productcategories.productid
inner join 
categories on productcategories.categoryid = categories.categoryid
inner join 
orderdetails on products.productid = orderdetails.productid
where 
categories.categoryname = 'electronics' 
group by 
categories.categoryname

--5. calculate the total revenue generated by a specific customer

select 
customers.customerid,
sum(orders.totalamount) as totalrevenue
from 
customers
inner join 
orders on customers.customerid = orders.customerid
where 
customers.customerid = 4
group by 
customers.customerid

--6. find the customers who have placed the most orders

select customers.firstname, customers.lastname, count(orders.orderid) as ordercount
from customers
join orders on customers.customerid = orders.customerid
group by customers.customerid, customers.firstname, customers.lastname
order by ordercount desc

--7. find the most popular product category

select 
categories.categoryname,
count(*) as ordercount
from 
productcategories
inner join 
orderdetails on productcategories.productid = orderdetails.productid
inner join 
orders on orderdetails.orderid = orders.orderid
inner join 
categories on productcategories.categoryid = categories.categoryid
group by 
categories.categoryname
order by 
count(*) desc
offset 0 rows fetch next 1 rows only

--8. find the customer who has spent the most money on electronic gadgets

select top 1 customers.firstname, customers.lastname, sum(orderdetails.quantity * products.price) as totalspending
from orders
join orderdetails on orders.orderid = orderdetails.orderid
join products on orderdetails.productid = products.productid
join customers on orders.customerid = customers.customerid
group by customers.customerid, customers.firstname, customers.lastname
order by totalspending desc

--9. calculate the average order value for all customers

select avg(totalamount) as averageordervalue
from orders

--10. find the total number of orders placed by each customer

select customers.firstname, customers.lastname, count(orders.orderid) as ordercount
from customers
left join orders on customers.customerid = orders.customerid
group by customers.customerid, customers.firstname, customers.lastname

