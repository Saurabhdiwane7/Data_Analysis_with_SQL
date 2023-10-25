with cte as 
(select *,
rank() over(partition by constituency_id order by votes desc) as rnk
from candidates c
join results r on  c.id = r.candidate_id)
select concat (party," ",count(*)) as party_seat_won
from cte where rnk =1
group by party;