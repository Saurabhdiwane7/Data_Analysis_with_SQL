# Q = Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

select
province_name
from province_names
group by (case when province_name = "Ontario" then 0 else 1 end),
province_name