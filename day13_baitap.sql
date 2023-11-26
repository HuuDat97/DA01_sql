---ex1
SELECT COUNT(*)
FROM
(SELECT company_id, 
title, 
description, 
COUNT(*)
FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(*)>=2
) as new_table

---ex2
WITH b AS
(
SELECT category,
product,
SUM(spend) as total_spend,
RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as ranking,
EXTRACT(year FROM transaction_date) as year
FROM product_spend
GROUP BY category,product, EXTRACT(year FROM transaction_date)
HAVING EXTRACT(year FROM transaction_date) = '2022'
)
SELECT category,
product,
total_spend
FROM b 
where ranking <=2

---ex3
WITH call AS
(
SELECT  policy_holder_id,
COUNT(case_id) AS so_cuoc_goi
FROM callers
GROUP BY policy_holder_id
)
SELECT
COUNT(*) AS member_count
FROM call
WHERE so_cuoc_goi >= 3

---ex4
SELECT pages.page_id FROM pages
FULL OUTER JOIN page_likes ON pages.page_id = page_likes.page_id
WHERE liked_date is NULL
ORDER BY pages.page_id ASC  ---đã có lời giải sẵn trong link

---ex5
WITH cte AS 
(
  SELECT user_id,
    EXTRACT(MONTH FROM event_date) AS mth
  FROM user_actions
  WHERE event_type IN ('sign-in','like','comment')
    AND EXTRACT (MONTH FROM event_date) IN (6,7)
    AND date_part ('year', event_date) = 2022
  GROUP BY user_id, mth
  HAVING COUNT(EXTRACT(MONTH FROM event_date))  = 2
)
SELECT mth, 
COUNT(user_id) AS active_user
FROM cte
WHERE mth = 7
GROUP BY mth

---ex6
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(id) AS trans_count,
    COUNT(CASE WHEN state = 'approved' THEN id END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount END) AS approved_total_amount
FROM
    transactions
GROUP BY
    month, country

---ex7
select 
distinct(product_id),
year as first_year,
quantity,
price 
from Sales 
group by product_id

---ex8
select customer_id
from Customer 
group by customer_id
having count(product_key) >=
(select count(*) as so_dem 
from Product) 

---ex9
with cte as (
select *
from Employees 
where salary <30000
)
select a.employee_id
from cte as a
join cte as b
on a.employee_id =b.manager_id

---ex10
WITH cte AS(
SELECT company_id, 
title, 
description, 
COUNT(*)
FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(*)>=2
) SELECT COUNT(*) FROM cte

---ex11
with cte as (
select s.title,       
avg(r.rating)  
from MovieRating as r 
join Movies as s on r.movie_id=s.movie_id 
where extract(month from r.created_at) = 2
group by s.title
order by avg(r.rating) desc, s.title
limit 1
), cte2 as (
    select u.name,
count(m.rating)
from MovieRating as m
join Users as u on m.user_id=u.user_id
group by u.name
order by u.name 
limit 1
)
select cte2.name as results      
from cte2
union select cte.title from cte 

---ex12
with cte as (
select requester_id as user_id,
accepter_id AS friend_id
from RequestAccepted 
Union all 
select accepter_id as user_id,
requester_id AS friend_id
from RequestAccepted
)
select user_id as id,
count(friend_id) as num
from cte
group by user_id
order by count(friend_id) desc
limit 1
