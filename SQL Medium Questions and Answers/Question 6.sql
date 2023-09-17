# Q show full name of doctoe with the first and last admission they attended? 

select 
doctor_id,
concat (first_name," ",last_name) as full_name,
min(admission_date) first_admission_date,
max(admission_date) last_admission_date
from doctors
join admissions on 
admissions.attending_doctor_id = doctors.doctor_id
group by 
doctor_id,
first_name,
last_name;

