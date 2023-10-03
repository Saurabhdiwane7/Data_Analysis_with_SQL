#Q = https://datalemur.com/questions/supercloud-customer

with cte as (SELECT 
C.CUSTOMER_ID,
COUNT(distinct P.PRODUCT_CATEGORY) AS TOTAL_COUNT
FROM customer_contracts C
LEFT JOIN PRODUCTS P ON C.PRODUCT_ID = P.PRODUCT_ID
GROUP BY CUSTOMER_ID)
SELECT  
customer_id
from cte 
where total_count = (select count(distinct product_category) from products)