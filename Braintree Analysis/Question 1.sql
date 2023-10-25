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

