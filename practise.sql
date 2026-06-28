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

insert into orders values
                       (101,1,'2026-01-10',500),
                       (102,2,'2026-1-11',1200),
                       (103,1,'2026-01-15',800),
                       (104,4,'2026-01-18',1500),
                       (105,2,'2026-01-20',700),
                       (106,3,'2026-01-22',900);

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

#display the customer who placed the most recent order
select c.customer_name,o.order_date
from customers c
left join orders o
on c.customer_id=o.customer_id
order by o.order_date desc
limit 1;

#