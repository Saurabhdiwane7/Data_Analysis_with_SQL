# Q = https://datalemur.com/questions/tesla-unfinished-parts

SELECT part,
assembly_step
FROM parts_assembly
where finish_date is null;