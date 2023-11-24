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


---ex9


---ex10


---ex11


---ex12
