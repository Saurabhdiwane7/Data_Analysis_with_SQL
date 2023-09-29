# Q = https://datalemur.com/questions/time-spent-snaps

SELECT 
ab.age_bucket,
round(100.0 * sum(case when a.activity_type ='send' then time_spent else 0 end)  /sum(time_spent),2) as send_percentage,
round(100.0 * sum(case when a.activity_type ='open' then time_spent else 0 end)  /sum(time_spent),2) as open_percent
FROM activities a
join age_breakdown ab
on a.user_id = ab.user_id
where activity_type in ('open','send')
GROUP BY ab.age_bucket;