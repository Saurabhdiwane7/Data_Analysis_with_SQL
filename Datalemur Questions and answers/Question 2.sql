#Q = https://datalemur.com/questions/sql-page-with-no-likes

SELECT p.page_id
from pages p
left join page_likes pl
on p.page_id = pl.page_id
where pl.liked_date is null
ORDER BY p.page_id asc