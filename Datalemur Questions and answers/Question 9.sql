#Q = https://datalemur.com/questions/sql-histogram-tweets


with cte as
(SELECT
user_id,
count(tweet_id) as tweet_num 
from tweets
where tweet_date between '01/01/2022' and '12/31/2022'
GROUP BY user_id)

select 
tweet_num as tweet_bucket,
count(user_id) as user_num
from cte 
GROUP BY tweet_num
