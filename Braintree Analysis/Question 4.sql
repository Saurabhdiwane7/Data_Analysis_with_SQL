/*
5\. All in a single query, execute all of the steps below and provide the results as your final answer
a. create a single list of all per_capita records for year 2009 that includes columns:
- continent_name
- country_code
- country_name
- gdp_per_capita
b. order this list by:
- continent_name ascending
- characters 2 through 4 (inclusive) of the country_name descending*/

select 
continent_name, country_Code,country_name,gdp_per_capita
from alldata
where year =2009
order by continent_name asc, substring(country_name,2,3);