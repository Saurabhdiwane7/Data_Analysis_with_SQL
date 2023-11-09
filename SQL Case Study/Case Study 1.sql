CREATE SCHEMA dannys_diner;
USE DANNYS_DINER;
CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INT
); 

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  
select * from sales;
select * from members;
select * from menu;
  
-- 1. What is the total amount each customer spent at the restaurant?

select
	m.customer_id as Customer,
	sum(price) as total 
from sales s
join members m on s.customer_id = m.customer_id
join menu me on s.product_id = me.product_id
group by m.customer_id;

-- 2. How many days has each customer visited the restaurant?

select 
customer_id as customer,
sum(order_date) as Total_days
from sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?


with cte as 
(select s.customer_id, s.order_date, s.product_id, m.product_name, 
row_number() over (partition by customer_id order by order_date asc) as rnk  
from sales s
join menu m on s.product_id = m.product_id)
select * from cte
where rnk =1;


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

select 
m.product_name,
count(s.customer_id) as total_count from sales s
join menu m 
on s.product_id = m.product_id
group by m.product_name
order by total_count desc;

-- 5. Which item was the most popular for each customer? 

with cte as (select 
m.product_name,customer_id,
count(customer_id) as total_count
from sales s
join menu m 
on s.product_id = m.product_id
group by m.product_name,s.customer_id)
select * from cte;

-- 6. Which item was purchased first by the customer after they became a member?

with cte as 
(select 
me.product_name,
s.order_date,
s.customer_id,
m.join_date,
row_number() over(partition by customer_id order by order_date) as rnk
from sales s
join members m on s.customer_id = m.customer_id
join menu me on s.product_id = me.product_id
where s.order_date > m.join_date)
select * from cte where rnk =1;

-- 7. Which item was purchased just before the customer became a member?

with cte as 
(select 
me.product_name,
s.order_date,
s.customer_id,
m.join_date,
row_number() over(partition by customer_id order by order_date desc) as rnk
from sales s
join members m on s.customer_id = m.customer_id
join menu me on s.product_id = me.product_id
where s.order_date < m.join_date)
select * from cte
where rnk =1;

-- 8. What is the total items and amount spent for each member before they became a member?

with cte as (select 
s.customer_id,
me.product_name,
s.order_date,
s.product_id,
m.join_date,
me.price
from sales s 
join members m on s.customer_id = m.customer_id 
join menu me on s.product_id = me.product_id
where s.order_date < m.join_date)
select 
customer_id,
count(product_id) as total_count,
sum(price) as total_amount
from cte 
group by customer_id;



-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

with cte as
(select s.customer_id,
me.product_name,
me.price,
case when me.product_name = "sushi" then price*20 else price*10 end as total_points  from sales s
join members m on s.customer_id = m.customer_id 
join menu me on s.product_id = me.product_id)
select customer_id,
sum(total_points) as total_points
from cte
group by customer_id;


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

with cte as
(select s.customer_id,
me.product_name,
s.order_date,
m.join_date,
me.price,
case when s.order_date <=date_add(m.join_date, interval 1 week) then price*2 else price end as total_points
from sales s
join members m on s.customer_id = m.customer_id 
join menu me on s.product_id = me.product_id)
select 
customer_id,
sum(total_points) as total from cte 
where order_date between '2021-01-01' and '2021-01-31'
group by customer_id;

