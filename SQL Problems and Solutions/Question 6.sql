# Q = calculate total number of patients in each city order total patients in descending and then city in  ascending order 

SELECT 
CITY,
COUNT(*) AS TOTAL_PATIENTS
FROM patients
group by CITY
order by TOTAL_PATIENTS DESC,CITY ASC