# Q = https://datalemur.com/questions/sql-average-post-hiatus-1

SELECT 
user_id,
max(post_date::date)-min(post_date::date) as difference
FROM posts
where extract(year from post_date) =2021
GROUP BY user_id
HAVING count(post_id)>1