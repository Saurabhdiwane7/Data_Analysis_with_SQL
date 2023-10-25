/*2a\. What is the count of countries and sum of their related gdp_per_capita values for the year 2007 where the string 'an' (case insensitive) appears anywhere in the country name?
2b\. Repeat question 4a, but this time make the query case sensitive.
*/

select 
count(*) as total_count,
sum(gdp_per_capita) as total_sum
from alldata 
where year =2007 and country_name like "%an%";


select 
count(*) as total_count,
sum(gdp_per_capita) as total_sum
from alldata
where year =2007 and country_name like binary "%an%";