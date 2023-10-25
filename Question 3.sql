use braintree;

/*3\. Find the sum of gpd_per_capita by year and the count of countries for each year that have non-null gdp_per_capita where
(i) the year is before 2012 and (ii) the country has a null gdp_per_capita in 2012. Your result should have the columns:

- year
- country_count
- total
*/

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