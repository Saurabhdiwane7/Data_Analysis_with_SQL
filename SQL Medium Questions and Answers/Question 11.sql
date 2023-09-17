#Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)

select
patients.patient_id,
first_name,
last_name
from patients
left join admissions on patients.patient_id = admissions.patient_id
where admissions.patient_id is null;
