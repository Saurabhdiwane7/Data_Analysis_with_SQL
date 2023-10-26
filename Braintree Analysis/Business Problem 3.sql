with cte as 
(select 
concat(first_name," ",last_name) as full_name,
state,
count(1) as total,
dense_rank()over(partition by concat(first_name," ",last_name) 
 order by count(1) desc) as rnk
from candidates_tab c
join results_tab r 
on c.id = r.candidate_id
group by full_name,state)
select 
full_name,
group_concat(case when rnk =1 then concat(state,"(",total,")") end) "1st_place",
group_concat(case when rnk =2 then concat(state,"(",total,")") end) "2nd_place",
group_concat(case when rnk =3 then concat(state,"(",total,")") end) "3rd_place"
from cte
where rnk <=3
group by full_name;