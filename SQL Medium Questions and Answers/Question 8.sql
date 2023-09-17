# Q = show the first_name ,last_name and allergies of the patients who has allergies in penicillin and morphine order by allergies in desending order 

SELECT
  first_name,
  last_name,
  allergies
FROM patients
WHERE
  allergies IN ('Penicillin', 'Morphine')
ORDER BY
  allergies,
  first_name,
  last_name;
  