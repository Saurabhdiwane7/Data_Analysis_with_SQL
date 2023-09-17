# Q = Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000

select 
province_id,
SUM(height) AS SUM_HEIGHT
FROM patients
group by province_id
HAVING SUM_HEIGHT >=7000
