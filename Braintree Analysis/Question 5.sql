# c. create a running total of gdp_per_capita by continent_name

SELECT 
continent_name,
sum(gdp_per_capita) over(partition by continent_name order by gdp_per_capita) as running_sum
FROM alldata;
