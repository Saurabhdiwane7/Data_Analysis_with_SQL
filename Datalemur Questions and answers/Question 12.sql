#Q = https://datalemur.com/questions/click-through-rate

SELECT 
app_id,
round(100.0 * sum(case when event_type ='click' then 1 else 0 end)/
sum(case when event_type ='impression' then 1 else 0 end),2) as CTR
FROM events
where timestamp between '01/01/2022' and '12/31/2022'
GROUP BY app_id;