# Q = We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.

select
doctors.doctor_id,
concat(doctors.first_name," ",doctors.last_name) as Doctor_full_name,
doctors.specialty,
year(admissions.admission_date),
count(admissions.admission_date ) as total_admissions_per_year
from admissions
join doctors on admissions.attending_doctor_id = doctors.doctor_id
group by doctors.doctor_id,Doctor_full_name,
doctors.specialty,
year(admissions.admission_date)