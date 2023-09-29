# Q = https://datalemur.com/questions/completed-trades

SELECT u.city,
sum(case when t.status ='Completed' then 1 else 0 end) as completed_trade
FROM users u 
join trades t on u.user_id = t.user_id
GROUP BY u.city
order by completed_trade desc limit 3

;