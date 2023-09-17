#Q = find out the count of most to least admissions on the day of 1-31 of the month sort by total most to least count of admissions 

select
day(admission_date) as day_number,
count(admission_date) as total_count
from admissions
group by day(admission_date)
order by total_count desc
 
