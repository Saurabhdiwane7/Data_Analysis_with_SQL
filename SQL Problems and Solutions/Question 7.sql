# Q = Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' as role FROM patients
union all
select first_name, last_name, 'Doctor' from doctors;