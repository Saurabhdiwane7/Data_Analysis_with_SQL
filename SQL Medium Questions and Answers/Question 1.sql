# Q find out the difference between maximum and minimum weight of patients whose last name is MMaroni?

select
(max(weight)-min(weight)) as difference
from patients
where last_name ="Maroni"
