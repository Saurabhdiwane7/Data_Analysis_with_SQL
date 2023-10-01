#Q = https://datalemur.com/questions/second-day-confirmation

SELECT distinct e.user_id 
FROM emails e
inner join texts t on 
e.email_id = t.email_id
where  t.action_date = e.signup_date + interval '1 day'
and t.signup_action ='Confirmed';