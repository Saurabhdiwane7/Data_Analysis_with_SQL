#Q =https://datalemur.com/questions/sql-avg-review-ratings 

SELECT 
extract (month from submit_date) as monthval,
product_id,
round(avg(stars),2) avg_val
from reviews
group by extract(month from submit_date),product_id
ORDER BY monthval,product_id