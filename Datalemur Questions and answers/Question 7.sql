#Q = https://datalemur.com/questions/odd-even-measurements

WITH cte AS (
  SELECT 
    CAST(measurement_time AS DATE) AS measurement_day, 
    measurement_value, 
    ROW_NUMBER() OVER (
      PARTITION BY CAST(measurement_time AS DATE) 
      ORDER BY measurement_time) AS measurement_num 
  FROM measurements
) 

SELECT measurement_day,
sum(case when measurement_num % 2 =0 then measurement_value else 0 end) as even_num,
sum(case when measurement_num %2 =1 then measurement_value else 0 end) as odd_num
FROM cte
GROUP BY measurement_day; 