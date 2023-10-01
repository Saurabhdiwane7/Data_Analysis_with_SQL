#Q = https://datalemur.com/questions/sql-highest-grossing

with cte as 
(
select 
category,
product,
sum(spend) as total_spend,
rank() over (partition by category order by sum(spend) desc) rnk
from product_spend
where transaction_date between '01/01/2022' and '12/31/2022'
GROUP BY category,product
)
select 
category,
product,
total_spend
from cte
where rnk <=2

