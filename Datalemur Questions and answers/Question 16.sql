#Q = https://datalemur.com/questions/top-profitable-drugs

SELECT 
drug,
sum(total_sales-cogs) as total_profit 
FROM pharmacy_sales
GROUP BY drug 
order by total_profit desc
limit 3;