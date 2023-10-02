#Q = https://datalemur.com/questions/signup-confirmation-rate

SELECT 
round(count(t.email_id):: decimal/
count(distinct e.email_id),2) as act_rate
FROM EMAILS E
LEFT JOIN TEXTS T ON E.email_id = T.email_id
and t.signup_action ='Confirmed';