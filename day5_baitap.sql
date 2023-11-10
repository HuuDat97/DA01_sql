--- ex1
select distinct city 
from STATION
where ID%2=0

---ex2 
select 
count(city) - count(distinct city) as difference
from station

---ex3 


---ex4
SELECT 
ROUND(CAST(SUM(item_count*order_occurrences)/SUM(item_count)AS decimal),1) as mean
FROM items_per_order;

---ex5 
SELECT candidate_id
FROM candidates
WHERE skill IN('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3

---ex6
SELECT 
user_id,
date(MAX(post_date)) - date(MIN(post_date)) as between_day
FROM posts
WHERE post_date >='2021-01-01' AND post_date<'2022-01-01'
GROUP BY user_id
HAVING COUNT(user_id)>=2

---ex7 
SELECT 
card_name,
MAX(issued_amount) - MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name

---ex8  
SELECT 
manufacturer,
COUNT(drug) AS drug_count,
abs(SUM(total_sales-cogs)) as loss
FROM pharmacy_sales
where total_sales<cogs
GROUP BY manufacturer
ORDER BY loss DESC

---ex9 
elect * 
from cinema
where id % 2 = 1 and description !='boring'
order by rating desc

---ex10 
elect 
teacher_id,
count(distinct subject_id) as cnt 
from Teacher
group by teacher_id

---ex11
select 
user_id,
count(follower_id) as followers_count
from Followers
group by user_id
order by user_id asc

---ex12
select class
from Courses
group by class
having count (student) >=5
