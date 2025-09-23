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
primary key (customer_id)
);
create table orders (
order_id int not null,
order_time DateTime,
customer_id int,
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


select * from order_pizza;


select orders.order_id, orders.customer_id,
sum(pizzas.pizza_price * order_pizza.quantity) as order_total
from orders
join order_pizza on orders.order_id = order_pizza.order_id
join pizzas on pizzas.pizza_id = order_pizza.pizza_id
group by orders.order_id, orders.customer_id;

-- Q4
select customers.customer_id,
sum(pizzas.pizza_price * order_pizza.quantity) as customer_total
from customers
join orders on orders.customer_id = customers.customer_id
join order_pizza on orders.order_id = order_pizza.order_id
join pizzas on pizzas.pizza_id = order_pizza.pizza_id
group by customers.customer_id;


-- Q5
select orders.customer_id, orders.order_time,
sum(pizzas.pizza_price * order_pizza.quantity) as customer_total
from orders
join order_pizza on orders.order_id = order_pizza.order_id
join pizzas on pizzas.pizza_id = order_pizza.pizza_id
group by orders.customer_id, orders.order_time;
