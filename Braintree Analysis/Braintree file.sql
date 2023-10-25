create database braintree;
USE braintree;

/* Replace '' empty strings with NULL*/
UPDATE continent_map
SET
    country_code = CASE country_code WHEN '' THEN NULL ELSE country_code END,
    continent_code = CASE continent_code WHEN '' THEN NULL ELSE continent_code END;
    
    
/* Select Statement To Pull Up Duplicate Country Codes, FOO on top*/
SELECT 
    COALESCE(country_code, 'FOO')
FROM
    braintree.continent_map
GROUP BY country_code
HAVING COUNT(*) > 1
ORDER BY country_code;


# Create a temporary table with a new column ID as a row_number on the table after order by contry_code, continent_code*/

 CREATE TABLE t1 (
SELECT row_number() over (order by country_code, continent_code asc) as 'ID',
country_code,
continent_code
FROM braintree.continent_map );

CREATE TABLE t2 
(Select MIN(ID) as ID from t1 group by country_code );

select * from t1;
select * from t2;


/*Delete the rows that dont have a min ID number after group by country_code*/

Delete From t1 where ID NOT IN(select ID from t2);

Delete From continent_map;

insert into continent_map
select country_code, continent_code from t1;

 DROP TABLE t1;
 DROP TABLE t2;

# Refill continent_map from temp_table

select * from continent_map;
use braintree;

select * from continent_map;
select * from continents;
select * from countries;
select * from per_capita;


create table alldata (select continent_map.country_code,continents.continent_code,continents.continent_name,
countries.country_name,per_capita.year,per_capita.gdp_per_capita from continent_map 
join continents on continent_map.continent_code = continents.continent_code
join countries on continent_map.country_code = countries.country_code
join per_capita on countries.country_code = per_capita.country_code);

 
 create table gdp_growth_rank (
 select 
	t1.continent_name,
    t1.country_code,
    t1.country_name,
    concat(round(((t2.gdp_2012 - t1.gdp_2011)/t1.gdp_2011)*100,2),"%") as growth_percent,
    rank() over(partition by t1.continent_name order by (t2.gdp_2012 - t1.gdp_2011)/t1.gdp_2011 desc) as drank
from 
(
select 
	continent_name,
	country_code,
	country_name,
	gdp_per_capita as "gdp_2011"
from 
alldata where year =2011
) t1
join 
(
select 
distinct country_code,
gdp_per_capita as "Gdp_2012"
from alldata
where year =2012
) t2
on t1.country_code = t2.country_code);



/*3 For the year 2012, create a 3 column, 1 row report showing the percent share of gdp_per_capita for the following regions:
(i) Asia, (ii) Europe, (iii) the Rest of the World. Your result should look something like

 Asia  | Europe | Rest of World 
------ | ------ | -------------
25.0%  | 25.0%  | 50.0%*/

select * from alldata;

select
concat(round(((select sum(gdp_per_capita) from alldata where  year = 2012 and continent_name ="Asia")/ (select sum(gdp_per_capita) from alldata where year =2012)) *100,1),"%") as "Asia",
concat(round(((select sum(gdp_per_capita) from alldata where year =2012 and continent_name = "Europe")/(select sum(gdp_per_capita) from alldata where year = 2012))*100,1),"%") as "Europe",
concat(round(((select sum(gdp_per_capita) from alldata where year =2012 and continent_name != "Asia" and continent_name != "Europe")/(select sum(gdp_per_capita) from alldata where year =2012))*100,1),"%") as "Rest of the World";

/*4a\. What is the count of countries and sum of their related gdp_per_capita values for the year 2007 where the string 'an' (case insensitive) appears anywhere in the country name?
4b\. Repeat question 4a, but this time make the query case sensitive.
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

select * from countries;
 
SELECT 
    year,
    COUNT(*) country_count,
    SUM(gdp_per_capita) AS total_sum
FROM
    alldata
WHERE
    country_code IN (SELECT DISTINCT
            (t1.country_code)
        FROM
            countries t1
                LEFT JOIN
            (SELECT 
                *
            FROM
                per_capita
            WHERE
                year = 2012) t2 ON t1.country_code = t2.country_code
        WHERE
            year IS NULL)
GROUP BY year;



/*
6\. All in a single query, execute all of the steps below and provide the results as your final answer
a. create a single list of all per_capita records for year 2009 that includes columns:

- continent_name
- country_code
- country_name
- gdp_per_capita

b. order this list by:

- continent_name ascending
- characters 2 through 4 (inclusive) of the country_name descending
*/

select 
continent_name, country_Code,country_name,gdp_per_capita
from alldata
where year =2009
order by continent_name asc, substring(country_name,2,3);

# c. create a running total of gdp_per_capita by continent_name

SELECT 
continent_name,
sum(gdp_per_capita) over(partition by continent_name order by gdp_per_capita) as running_sum
FROM alldata;

#d. return only the first record from the ordered list for which each continent's running total of gdp_per_capita meets or exceeds $70,000.00 with the following columns:

/*- continent_name
- country_code
- country_name
- gdp_per_capita
- running_total*/


with cte as(select 
*,
sum(gdp_per_capita) over(partition by continent_name order by gdp_per_capita ) as running_total
from alldata),
cte2 as 
(select *
from cte where running_total >=70000),
cte3 as (select 
*,
rank() over(partition by continent_name order by gdp_per_capita) rnk from cte2)
select * from cte3 where rnk =1;

