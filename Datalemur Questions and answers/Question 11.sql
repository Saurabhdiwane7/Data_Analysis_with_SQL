# Q = https://datalemur.com/questions/teams-power-users

SELECT 
sender_id,
count(message_id) as tot_num
FROM messages
where EXTRACT(month from sent_date) = 8
and EXTRACT(year from sent_date) = 2022
GROUP BY sender_id
ORDER BY tot_num desc limit 2;