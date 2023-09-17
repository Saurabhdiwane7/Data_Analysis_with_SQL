# Q  show total amount of patients with respect to the provinance order by descending ?
 
select 
province_name,
count(patient_id) as total_count
from patients
join province_names
on patients.province_id = province_names.province_id
group by province_name
order by total_count desc
