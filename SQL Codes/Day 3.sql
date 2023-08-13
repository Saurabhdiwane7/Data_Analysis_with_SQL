
# Rewriting all queries using case statement

Select
concat(First,' ',Last) as FullName
,Status
,case
when Status = 'Full Time' then 'Permanent'
when Status = 'Contract' then 'Temporary'
else 'Terminated'
end as EmpType
from employees.employees ;

Select
concat(First,' ',Last) as FullName
,Status
,Salary
,case
when Status = 'Full Time' then Salary * 1.1
when Status = 'Contract' then Salary * 1.05
else Salary
end as NewSalary
from employees.employees ;


# 1. Hike the Salary by 10% for all full time employees and only those contract employees with jobrating 1

Select
concat(First,' ',Last) as FullName
,Status
,Jobrating
,Salary
,case
when Status = 'Full Time' or (Status = 'Contract' and Jobrating = 1) then Salary * 1.1
else Salary
end as NewSalary
from employees.employees ;

# 2. Hike the Salary by 10% for only full time employees hired before 2000 Year

Select
concat(First,' ',Last) as FullName
,Status
,Hiredate
,Salary
,case
when Status = 'Full Time' and HireDate < '2000-1-1' then Salary * 1.1
else Salary
end as NewSalary
from employees.employees ;

# 3. Display as classic blockbuster if boxofficedollars more than 1e9 and oscarwins more than zero,else others

Select
Title
,BoxofficeDollars
,OscarWins
,case
when BoxofficeDollars > 1e9 and OscarWins >0 then 'Classic Blockbuster'
else 'Others'
end as MovieType
from movies.film ;

# 4. Display Text Title if Title contains only Text,else alphanumeric Title

Select
Title
,case
when Title not regexp '[0-9]' then 'Text Title'
else 'Alphanumeric Title'
end as MovieType
from movies.film ;

# 5. Hike the salary by 10% if jobrating is 4 or more,by 5% if jobrating is 2-3,else same salary

Select
concat(First,' ',Last) as FullName
,Jobrating
,Salary
,case
when Jobrating >=4 then Salary * 1.1
when Jobrating >=2 then Salary * 1.05
else Salary
end as NewSalary
from employees.employees ;

# 6. Display Short Film if RunTimeMinutes less than 100,Avg Length Film if RunTimeMinutes 100-160,else Long Film

Select
Title
,RunTimeMinutes
,case
when RunTimeMinutes < 100 then 'Short Film'
when RunTimeMinutes < 160 then 'Avg Length film'
else 'Long film'
end as MovieType
from movies.film ;

# 7. Display Text Title if Title contains only Text,alphanumeric Title if it contains text and number,else numeric Title

Select
Title
,case 
when Title not regexp '[0-9]' then 'Text Title'
when Title regexp '[A-Z]' then 'Alphanumeric Title'
else 'Numeric Title'
end as MovieType
from movies.film ;

# 8. Display Classic Blockbuster if boxoffice more than 1e9 and oscarwins more than 0,Blockbuster if Boxoffice more than 1e9
#         without oscars ,else others

Select
Title
,BoxofficeDollars
,OscarWins
,case
when BoxofficeDollars > 1e9 and OscarWins >0 then 'Classic Blockbuster'
when BoxofficeDollars > 1e9 then 'Blockbuster'
else 'Others'
end as MovieType
from movies.film ;

# 9. Display Old Actor if actor dob before 1970,middle aged actor if actor dob 1970-1990,else young actor

Select
concat(FirstName,' ',FamilyName) as FullName
,Dob
,case
when Dob < '1970-1-1' then 'Old Actor'
when Dob < '1990-1-1' then 'Middle Aged Actor'
else 'Young Actor'
end as ActorType
from movies.actor ;

Select
Title
,If(BoxofficeDollars > 1e9,'Blockbuster','Others') as MovieType
from movies.film ;

Select
Title
,case
when BoxofficeDollars > 1e9 then 'Blockbuster'
end as MovieType
from movies.film ;

# Order by
# Ascending Sort,Descending Sort,Multiple Column Sort,Custom Sort

Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
Order by Salary desc ;

Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
Order by Salary ;

Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
Order by Salary desc
Limit 5 ;

Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
Order by Salary desc
Limit 1 Offset 5 ;

Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
where Status = 'Full Time'
Union
Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
Where Status = 'Contract' ;

Select
concat(First,' ',Last) as FullName
,Department
,Salary
from employees.employees
Order by Department asc,Salary desc ;

# Full Time,Contract,Half-Time,Hourly

Select
concat(First,' ',Last) as FullName
,Status
,case
when Status = 'Full Time' then 1
when Status = 'Contract' then 2
when Status = 'Half-Time' then 3
else 4
end as Sort
from employees.employees
Order by Sort ;

Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
Order by case
when Status = 'Full Time' then 1
when Status = 'Contract' then 2
when Status = 'Half-Time' then 3
else 4
end asc ,Salary desc ;

# 1. Display Top 10 Highest Grossing Films (Based on BoxofficeDollars)

Select
Title
,BoxofficeDollars
from movies.film
Order by Boxofficedollars desc
Limit 10 ;

# 2. Display Top 10 Youngest Players from India (Country_Name = 1)

Select
Player_Name
,Dob
from ipl.Player
Where Country_Name = 1
Order by Dob desc
Limit 10 ;

# 3. Sort by Status in Full Time,Contract,Half-Time,Hourly order and then by Jobrating
#       and then by Salary in desc order

Select
concat(First,' ',Last) as FullName
,Status
,Jobrating
,Salary
from employees.employees
Order by case
when Status = 'Full Time' then 1
when Status = 'Contract' then 2
when Status = 'Half-Time' then 3
else 4
end asc,Jobrating asc,salary desc ;

# 4. Sort by highest to lowest oscars and then by Boxoffice Dollars in desc

Select
Title
,BoxofficeDollars
,OscarWins
from movies.film
Order by OscarWins desc,BoxofficeDollars desc ;

# 5. Sort by Text Title and then by alphanumeric title and then by numeric title
#       within each group,sort by title again

Select
Title
from movies.film
Order by case
when Title not regexp '[0-9]' then 1
when Title regexp '[A-Z]' then 2
else 3
end asc,Title asc ;

Select
concat(First,' ',Last) as FullName
,Status
,Salary
from employees.employees
Order by Salary asc
Limit 1 Offset 1 ;

with ty as
(
Select
concat(First,' ',Last) as FullName
,Status
,Salary
,Row_number() over (Order by Salary asc) as rw
,Row_number() over (Order by Salary desc) as rh
from employees.employees 
)
Select *
from ty
where rw = 2 or rh = 2;
