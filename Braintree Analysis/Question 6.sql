# d. return only the first record from the ordered list for which each continent's running total of gdp_per_capita meets or exceeds $70,000.00 with the following columns:

with cte as(select 
*,
sum(gdp_per_capita) over(partition by continent_name order by gdp_per_capita) as running_total
from alldata)
select * from cte where running_total >=70000;
