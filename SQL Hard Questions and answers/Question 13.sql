/* # Q Show the city, company_name, contact_name from the customers and suppliers table merged together.
Create a column which contains 'customers' or 'suppliers' depending on the table it came from.*/

select
city,
company_name,
contact_name,
'Customers' as relationship
from customers
union
select
city,company_name,contact_name,'Suppliers' as relationship
from suppliers
