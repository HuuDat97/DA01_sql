---ex1
select
Name
from STUDENTS
where marks > 75 
order by right(Name,3) , ID

---ex2
select 
user_id,
upper(left(name,1)) || lower(right(name,length(name)-1)) as name
from Users
order by user_id

---ex3
SELECT
manufacturer,
'$' ||ROUND(SUM(total_sales)/1000000,0)|| ' ' || 'milions' as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC , manufacturer

---ex4
SELECT 
EXTRACT(month from submit_date) as mth,
product_id,
ROUND(AVG(stars),2) AS avg_star
FROM reviews
GROUP BY EXTRACT(month from submit_date),product_id
ORDER BY EXTRACT(month from submit_date), product_id

---ex5
SELECT 
sender_id,
COUNT(message_id) as message_count
FROM messages
WHERE EXTRACT(month FROM sent_date) = '8' 
AND EXTRACT(year FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY COUNT(sender_id) DESC
LIMIT 2

---ex6
select
tweet_id
from Tweets
where length(content) >15

---ex7


---ex8
select 
count(id) as employees_hired
from employees
where extract(month from joining_date) between 1 and 7
and extract(year from joining_date) = '2022'

---ex9
select 
position('a' in first_name)
from worker
where first_name = 'Amitah'

---ex10
select 
substring(title from length(winery)+2 for 4) as nam_sx
from winemag_p2
where country = 'Macedonia'
