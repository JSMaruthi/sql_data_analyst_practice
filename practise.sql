create database joins;
use joins;
.
create table customers(
    customer_id int primary key,
    customer_name varchar(50),
    city varchar(50)
);

create table orders(
    order_id int primary key,
    customer_id int,
    order_date date,
    amount int,
foreign key (customer_id) references customers(customer_id)
);

insert into customers values
                          (1,'Rahul','Banglore'),
                          (2,'priya','Mysore'),
                          (3,'Amit','Chennai'),
                          (4,'Neha','Banglore'),
                          (5,'Kiran','Banglore');
INSERT INTO customers (customer_id, customer_name, city)
VALUES
                            (6,'Rohan','Hyderabad'),
                            (7,'Sneha','Pune'),
                            (8,'Arjun','Delhi'),
                            (9,'Meera','Mumbai'),
                            (10,'Vikram','Kolkata'),
                            (11,'Anjali','Mysore'),
                            (12,'Suresh','Chennai'),
                            (13,'Divya','Hyderabad'),
                            (14,'Nitin','Pune'),
                            (15,'Pooja','Mumbai');

insert into orders values
                       (101,1,'2026-01-10',500),
                       (102,2,'2026-1-11',1200),
                       (103,1,'2026-01-15',800),
                       (104,4,'2026-01-18',1500),
                       (105,2,'2026-01-20',700),
                       (106,3,'2026-01-22',900);

INSERT INTO orders (order_id, customer_id, order_date, amount)
VALUES
                        (107,6,'2026-01-24',650),
                        (108,7,'2026-01-25',2100),
                        (109,8,'2026-01-26',1800),
                        (110,9,'2026-01-27',950),
                        (111,10,'2026-01-28',1100),
                        (112,6,'2026-01-29',400),
                        (113,7,'2026-02-01',750),
                        (114,8,'2026-02-02',1300),
                        (115,9,'2026-02-03',2200),
                        (116,10,'2026-02-04',600),
                        (117,11,'2026-02-05',900),
                        (118,12,'2026-02-06',1400),
                        (119,13,'2026-02-07',1700),
                        (120,14,'2026-02-08',800),
                        (121,15,'2026-02-09',1250),
                        (122,1,'2026-02-10',2000),
                        (123,2,'2026-02-11',300),
                        (124,3,'2026-02-12',1000),
                        (125,4,'2026-02-13',700),
                        (126,5,'2026-02-14',1600),
                        (127,6,'2026-02-15',900),
                        (128,7,'2026-02-16',1200),
                        (129,8,'2026-02-17',1500),
                        (130,9,'2026-02-18',400);

#customer name and their order amount
select c.customer_name,
       o.amount
from customers c
inner join orders o
on c.customer_id=o.customer_id
order by o.amount;

#display the customer name,city and order date
select c.customer_name,c.city,o.order_date
from customers c
left join orders o
on c.customer_id=o.customer_id;

#display all customers along with their orders
select c.customer_name,c.customer_id,o.order_id
from customers c
left join orders o
on c.customer_id =o.customer_id;
group by c.customer_id;

#find the names of customers who have not placed any orders
select c.customer_name
from customers c
left join orders o
on c.customer_id=o.customer_id
where o.customer_id is null;

#display the customer name and total amount they have spent
select c.customer_name,
       sum(o.amount) as total_amount from customers c
inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id;

#display all customers who spent more than 1000 in total.
select c.customer_id,c.customer_name,
       sum(o.amount) as total_amount
    from customers c
inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
having sum(o.amount)>1000;

#find the highest spending customer
select c.customer_id,c.customer_name,
       sum(o.amount) as total_amount
from customers c
inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id, c.customer_name
order by total_amount desc
limit 1;

#display customers from Bangalore along with their total order amounts.
select c.customer_name,c.city,
       sum(o.amount) as total_order_amount
from customers c
inner join orders o
on c.customer_id=o.customer_id
where c.city='Banglore'
group by o.customer_id,c.customer_name,c.city;

#find the average order amount for each customer
select c.customer_name,
       round(avg(o.amount),2)as avg_amount
from customers c
inner join orders o
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id;

#display the customer who placed the most recent_order
select c.customer_name,o.order_date
from customers c
left join orders o
on c.customer_id=o.customer_id
order by o.order_date desc
limit 1;

#show each customers number of orders
select c.customer_id,c.customer_name,
    count(o.order_id) as Num_of_orders
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.customer_id,
         c.customer_name;

#find customers who have placed more than one order.
select c.customer_id,c.customer_name,
    count(o.order_id) as no_of_orders
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
having no_of_orders>1;

#display the highest order amount for each customer
select c.customer_id,c.customer_name,
       max(o.amount) as highest_amount
 from customers c
inner join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name;

