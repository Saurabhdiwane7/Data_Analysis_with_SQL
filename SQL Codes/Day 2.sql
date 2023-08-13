Select
Title
,OscarWins
,If(OscarWins = 0,'Average Film',If(OscarWins < 5,'Great Film','Classic Film')) as MovieType
from movies.film ;

# 1. Hike the Salary by 10% for all full time employees and only those contract employees with jobrating 1

Select
concat(First,' ',Last) as FullName
,Status
,Jobrating
,Salary
,If(Status = 'Full Time' or (Status = 'Contract' and Jobrating = 1),Salary * 1.1,Salary) as NewSalary
from employees.employees ;

# 2. Hike the Salary by 10% for only full time employees hired before 2000 Year

Select
concat(First,' ',Last) as FullName
,Status
,Hiredate
,Salary
,If(Status = 'Full Time' and HireDate < '2000-1-1',Salary * 1.1,Salary) as NewSalary
from employees.employees ;

# 3. Display as classic blockbuster if boxofficedollars more than 1e9 and oscarwins more than zero,else others

Select
Title
,BoxofficeDollars
,OscarWins
,If(BoxofficeDollars > 1e9 and OscarWins >0,'Classic Blockbuster','Others') as MovieType
from movies.film ;

# 4. Display Text Title if Title contains only Text,else alphanumeric Title

Select
Title
,If(Title not regexp '[0-9]','Text Title','Alphanumeric Title') as MovieType
from movies.film ;

# 5. Hike the salary by 10% if jobrating is 4 or more,by 5% if jobrating is 2-3,else same salary

Select
concat(First,' ',Last) as FullName
,Jobrating
,If(Jobrating >=4,Salary * 1.1,If(Jobrating >=2,Salary * 1.05,Salary)) as NewSalary
from employees.employees ;

# 6. Display Short Film if RunTimeMinutes less than 100,Avg Length Film if RunTimeMinutes 100-160,else Long Film

Select
Title
,RunTimeMinutes
,If(RunTimeMinutes < 100,'Short Film',If(RunTimeMinutes < 160,'Avg Length film','Long film')) as MovieType
from movies.film ;

# 7. Display Text Title if Title contains only Text,alphanumeric Title if it contains text and number,else numeric Title

Select
Title
,If(Title not regexp '[0-9]','Text Title',If(Title regexp '[A-Z]','Alphanumeric Title','Numeric Title')) as MovieType
from movies.film ;

# 8. Display Classic Blockbuster if boxoffice more than 1e9 and oscarwins more than 0,Blockbuster if Boxoffice more than 1e9
#         without oscars ,else others

Select
Title
,BoxofficeDollars
,OscarWins
,If(BoxofficeDollars > 1e9 and OscarWins >0,'Classic Blockbuster',If(BoxofficeDollars > 1e9,'Blockbuster','Others')) as MovieType
from movies.film ;

# 9. Display Old Actor if actor dob before 1970,middle aged actor if actor dob 1970-1990,else young actor

Select
concat(FirstName,' ',FamilyName) as FullName
,Dob
,If(Dob < '1970-1-1','Old Actor',If(Dob < '1990-1-1','Middle Aged Actor','Young Actor')) as ActorType
from movies.actor ;
