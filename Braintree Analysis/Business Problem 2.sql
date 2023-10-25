
with cte as (select 
status,
concat(first_name," ",last_name) as full_name,
group_concat(distinct name) as campaign,
count(1) as total,
rank()over(partition by status order by count(1) desc) as rnk
from customers cus
join campaigns cam on cus.id = cam.customer_id
join events e on e.campaign_id = cam.id
group by full_name,status)
select 
status,
full_name,
campaign,total
from cte where rnk =1;