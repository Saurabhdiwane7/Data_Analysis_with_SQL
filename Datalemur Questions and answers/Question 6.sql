#Q = https://datalemur.com/questions/rolling-average-tweets

SELECT 
user_id,
tweet_date,
round(avg(tweet_count)
over(partition by user_id order by tweet_date 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) as rolling_avg
from tweets