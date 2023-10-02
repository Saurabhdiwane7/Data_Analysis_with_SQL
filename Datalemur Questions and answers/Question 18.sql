# Q = https://datalemur.com/questions/total-drugs-sales

SELECT 
manufacturer,
concat('$', round(sum(total_sales)/1000000,0),' million') as total_drug_sales
FROM pharmacy_sales
GROUP BY manufacturer
order by sum(total_sales) desc ,manufacturer asc;