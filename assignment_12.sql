create database pizza_shop;

use pizza_shop;

create table pizzas (
pizza_id int auto_increment not null primary key,
pizza_name varchar(100),
pizza_price decimal(4,2)
);
create table customers (
customer_id int auto_increment not null primary key,
first_name varchar(100),
last_name varchar(100),
phone_number varchar(12)
);
create table orders (
order_id int auto_increment not null primary key,
order_datetime DateTime,
customer_id int,
foreign key (customer_id) references customers (customer_id)
);
create table order_pizza (
order_pizza_id int auto_increment not null primary key,
order_id int,
pizza_id int,
quantity int,
amount decimal(10,2),
foreign key (order_id) references orders (order_id),
foreign key (pizza_id) references pizzas (pizza_id)
);
insert into pizzas (pizza_name, pizza_price)
values
('Pepperoni & Cheese', 7.99),
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian',	12.99);
insert into customers (first_name, last_name, phone_number)
values
('Trevor', 'Page', '226-555-4982'),
('John',	'Doe', '555-555-9498');
insert into orders (order_datetime, customer_id)
values
('2023-10-9 9:47:00', 1),
('2023-10-9 13:20:00', 2),
('2023-10-9 9:47:00', 1),
('2023-10-10 10:37:00', 2);
insert into order_pizza (order_id, pizza_id, quantity)
values
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(2, 3, 2),
(3, 3, 1),
(3, 4, 1),
(4, 2, 3),
(4, 4, 1);


-- Q4
select concat(customers.first_name, ' ',customers.last_name) as customer_name,
sum(pizzas.pizza_price * order_pizza.quantity) as customer_total
from customers
join orders on orders.customer_id = customers.customer_id
join order_pizza on orders.order_id = order_pizza.order_id
join pizzas on pizzas.pizza_id = order_pizza.pizza_id
group by customers.customer_id;


-- Q5
select concat(customers.first_name, ' ',customers.last_name) as customer_name,
sum(pizzas.pizza_price * order_pizza.quantity) as customer_total
from orders
join customers on orders.customer_id = customers.customer_id
join order_pizza on orders.order_id = order_pizza.order_id
join pizzas on pizzas.pizza_id = order_pizza.pizza_id
group by orders.customer_id, orders.order_datetime;
