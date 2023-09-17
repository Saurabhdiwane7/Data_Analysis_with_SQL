# Q - Show the total amount of male patients and the total amount of female patients in the patients table.Display the two results in the same row.

select 
gender,
count(patient_id) as total_count
from patients
group by gender 
 