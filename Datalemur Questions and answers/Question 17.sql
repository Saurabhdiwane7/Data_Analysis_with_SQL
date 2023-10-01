# Q = https://datalemur.com/questions/non-profitable-drugs

SELECT
manufacturer,
count(drug) drug_cnt,
abs(sum(total_sales-cogs)) as total_loss
FROM pharmacy_sales
where total_sales -cogs <=0
GROUP BY manufacturer
order by total_loss desc 
