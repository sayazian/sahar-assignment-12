create database pizza_shop;

use pizza_shop;

create table pizzas (
pizza_id int not null,
pizza_name varchar(100),
pizza_price decimal(4,2),
primary key (pizza_id)
);
create table customers (
customer_id int not null,
first_name varchar(100),
last_name varchar(100),
phone_number varchar(12),
expenditure decimal(10,2),
primary key (customer_id)
);
create table orders (
order_id int not null,
order_time DateTime,
customer_id int,
total decimal(10,2),
primary key (order_id),
foreign key (customer_id) references customers (customer_id)
);
create table order_pizza (
order_pizza_id int not null,
order_id int,
pizza_id int,
quantity int,
amount decimal(10,2),
primary key (order_pizza_id),
foreign key (order_id) references orders (order_id),
foreign key (pizza_id) references pizzas (pizza_id)
);
insert into pizzas (pizza_id, pizza_name, pizza_price)
values 
(1,	'Pepperoni & Cheese', 7.99),
(2,	'Vegetarian', 9.99),
(3,	'Meat Lovers', 14.99),
(4,	'Hawaiian',	12.99);
insert into customers (customer_id, first_name, last_name, phone_number)
values
(1,	'Trevor', 'Page', '226-555-4982'),
(2,	'John',	'Doe', '555-555-9498');
insert into orders (order_id, order_time, customer_id)
values
(1,	'2023-10-9 9:47:00', 1),
(2,	'2023-10-9 13:20:00', 2),
(3,	'2023-10-9 9:47:00', 1),
(4,	'2023-10-10 10:37:00', 2);
insert into order_pizza (order_pizza_id, order_id, pizza_id, quantity)
values
(1, 1, 1, 1),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 2, 3, 2),
(5, 3, 3, 1),
(6, 3, 4, 1),
(7, 4, 2, 3),
(8, 4, 4, 1);

update order_pizza
join pizzas on pizzas.pizza_id = order_pizza.pizza_id
set order_pizza.amount = pizzas.pizza_price * order_pizza.quantity;

select * from order_pizza;

set sql_safe_updates = 0;

update orders
join (
select order_id, sum(amount) as order_total
from order_pizza
group by order_id
) t on orders.order_id = t.order_id
set orders.total = t.order_total;

select * from orders;

-- Q4
update customers
join (
select customer_id, sum(total) as customer_total
from orders
group by customer_id
) t on customers.customer_id = t.customer_id
set customers.expenditure = t.customer_total;
set sql_safe_updates = 1;

select * from customers;

-- Q5
select customer_id, order_time, sum(total) as customer_total
from orders
group by customer_id, order_time
order by customer_id, order_time;