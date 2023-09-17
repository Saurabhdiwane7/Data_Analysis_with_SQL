# Q = Select patient_id , first_name from patients where first name starts and end with "S"  and length of characters are ate least 6

select 
patient_id,
first_name
from patients
where first_name like "s%s" and len(first_name)>=6