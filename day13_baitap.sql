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


---ex4


---ex5


---ex6


---ex7


---ex8


---ex9


---ex10


---ex11


---ex12
