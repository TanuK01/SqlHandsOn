create database SalesDb
use SalesDb

--Salesman Table
create table Salesman(Salesman_id int primary key, name varchar(50), city varchar(30),commision float)

insert into Salesman values(5001, 'James Hoog', 'New York', 0.15)
insert into Salesman values(5002, 'Nail Knite', 'Paris', 0.13)
insert into Salesman values(5005, 'Pit Alex', 'London', 0.11)
insert into Salesman values(5006, 'Mc Lyon', 'Paris', 0.14)
insert into Salesman values(5007, 'Paul Adam', 'Rome', 0.13)
insert into Salesman values(5003, 'Lauson Hen', 'San Jose', 0.12)

select * from Salesman



--Customer Table
create table Customer(customer_id int primary key, cust_name varchar(50), city varchar(30), grade int, salesman_id int )

insert into Customer values(3002, 'Nick Rimando', 'New York', 100, 5001)
insert into Customer values(3007, 'Brad Davis', 'New York', 200, 5001)
insert into Customer values(3005, 'Graham Zusi', 'California', 200, 5002)
insert into Customer values(3008, 'Julian Green', 'London', 300, 5002)
insert into Customer values(3004, 'Fabian Johnson', 'Paris', 300, 5006)
insert into Customer values(3009, 'Geoff Cameron', 'Berlin', 100, 5003)
insert into Customer values(3003, 'Jozy Altidor', 'Moscow', 200, 5007)
insert into Customer values(3001, 'Brad Guzan', 'London', NULL, 5005)

select * from Customer


--Orders Table
create table Orders(
	order_no numeric(5) primary key, purch_amt decimal(8,2), order_date date, 
	customer_id int references Customer(customer_id), salesman_id int references Salesman(Salesman_id))

insert into Orders values(70001, 150.5, '2012-10-05', 3005, 5002)
insert into Orders values(70009, 270.65, '2012-09-10', 3001, 5005)
insert into Orders values(70002, 65.26, '2012-10-05', 3002, 5001)
insert into Orders values(70004, 110.5, '2012-08-17', 3009, 5003)
insert into Orders values(70007, 948.5, '2012-09-10', 3005, 5002)
insert into Orders values(70005, 2400.6, '2012-07-27', 3007, 5001)
insert into Orders values(70008, 5760, '2012-09-10', 3002, 5001)
insert into Orders values(70010, 1983.43, '2012-10-10', 3004, 5006)
insert into Orders values(70003, 2480.4, '2012-10-10', 3009, 5003)
insert into Orders values(70012, 250.45, '2012-06-27', 3008, 5002)
insert into Orders values(70011, 75.29, '2012-08-17', 3003, 5007)
insert into Orders values(70013, 3045.6, '2012-04-25', 3002, 5001)

--1.	Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders
select order_date, salesman_id, order_no, purch_amt from Orders

--2.	write a SQL query to find the unique salespeople ID. Return salesman_id.
select distinct Salesman_id from Salesman

--3. Write a SQL query to find the salespeople who lives in the City of 'Paris'. Return salesperson's name, city.
select name,city from Salesman where city='Paris'

--4.	write a SQL query to find the orders, which are delivered by a salesperson of ID. 5001. Return ord_no, ord_date, purch_amt
select order_no, order_date, purch_amt from Orders where salesman_id = 5001

--5.	write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id.
select customer_id, cust_name,city, grade, salesman_id from Customer where city='New York' and grade>100

--6.	write a SQL query to find the details of those salespeople whose commissions range from 0.10 to 0.12. Return salesman_id, name, city, and commission
select * from Salesman where (commision>=0.10 AND commision<=0.12)

--7.	write a SQL query to calculate total purchase amount of all orders. Return total purchase amount.
select sum(purch_amt) from Orders

--8.	write a SQL query to calculate average purchase amount of all orders. Return average purchase amount.
select AVG(purch_amt) from Orders

--9.	write a SQL query to count the number of unique salespeople. Return number of salespeople.
select count(distinct Salesman_id) from Orders

--10.	write a SQL query to find the highest purchase amount ordered by each customer. Return customer ID, maximum purchase amount
select customer_id, MAX(purch_amt) from Orders group by customer_id

--11.	write a SQL query to find the highest purchase amount ordered by each customer on a particular date. Return, order date and highest purchase amoun
select customer_id order_date, MAX(purch_amt) from Orders group by customer_id, order_date

--12.	write a SQL query to find the highest purchase amount on '2012-08-17' by each salesperson. Return salesperson ID, purchase amount. 
select salesman_id, MAX(purch_amt) from Orders group by salesman_id,order_date having order_date='2012-08-17'

--OR
SELECT salesman_id,MAX(purch_amt) FROM orders 
WHERE order_date = '2012-08-17' GROUP BY salesman_id;

--13.	write a SQL query to find the salesperson and customer who belongs to same city. Return Salesman, cust_name and city.
select Salesman.name as "Salesman_name", Customer.cust_name, Customer.city from Salesman, Customer where salesman.city=customer.city;

--14.	write a SQL query to find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city
select order_no, purch_amt, cust_name, city from Orders full outer join Customer on Customer.customer_id = Orders.customer_id
where (purch_amt> 500 AND purch_amt < 2000)

--OR
select  a.order_no, a.purch_amt, b.cust_name, b.city from Orders a,Customer b 
where a.customer_id = b.customer_id 
AND a.purch_amt BETWEEN 500 AND 2000;

--15.	write a SQL query to find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission
select a.cust_name AS "Customer Name", a.city, b.name AS "Salesman", b.commision 
from customer a INNER JOIN salesman b 
on a.salesman_id=b.salesman_id where b.commision>.12;

--16.	write a SQL query to display the cust_name, customer city, grade, Salesman, salesman city. The result should be ordered by ascending on customer_id.
select a.cust_name, a.city, a.grade, b.name AS "Salesman_name",b.city 
from customer a LEFT JOIN Salesman b 
ON a.salesman_id = b.salesman_id  order by a.customer_id;
