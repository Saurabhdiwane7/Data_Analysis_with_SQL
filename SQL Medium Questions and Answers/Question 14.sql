#Q = Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.

select 
sum(case when gender ="M" then 1 else 0 end) as Male_count,
sum(case when gender ="F" then 1 else 0 end) as Female_count
from patients