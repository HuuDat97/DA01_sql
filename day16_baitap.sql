---ex1
with main as (with cte1 as (
    select customer_id , order_date , customer_pref_delivery_date ,
    dense_rank() over(partition by customer_id order by order_date  ) as don_hang
    from Delivery)
select  
count(
    case 
    when order_date = customer_pref_delivery_date then 1 
    end
) as first,
count(*) as tong
from cte1 where don_hang=1)
select 
100.0*first/tong as immediate_percentage 
from main

---ex2
with cte as (
select player_id ,event_date , 
lead(event_date)  over(order by player_id ) as next_day,
dense_rank() over(partition by player_id order by event_date ) as ngay_choi
from Activity
)
select 
round(1.0*count(
    case when next_day-event_date=1 then 1 end
)/count(*),2) as fraction  
from cte
where ngay_choi =1

---ex3


---ex4
-- Write your PostgreSQL query statement below
with main as (
with cte AS
(
SELECT
visited_on,   
SUM(amount) as total
FROM Customer
GROUP BY visited_on
order by visited_on
),
cte1 as (
select visited_on,total, 
coalesce(lag(total) over(order by visited_on),0) as ngay1,
coalesce(lag(total,2) over(order by visited_on),0) as ngay2,
coalesce(lag(total,3) over(order by visited_on),0) as ngay3,
coalesce(lag(total,4) over(order by visited_on),0) as ngay4,
coalesce(lag(total,5) over(order by visited_on),0) as ngay5,
coalesce(lag(total,6) over(order by visited_on),0) as ngay6
from cte)
select * 
from cte1
where  ngay6 !=0)
select visited_on, 1.0*(ngay1+ngay2+ngay3+ngay4+ngay5+ngay6+total) as amount, 
round(1.0*(ngay1+ngay2+ngay3+ngay4+ngay5+ngay6+total)/7,2) as average_amount 
from main
order by visited_on 

---ex5


---ex6
with cte as (select name as Employee , salary,departmentId as department,
dense_rank() over(partition by departmentId order by salary) as rnk
from Employee) 
select  
case when  department = 1 then 'IT'
     else 'Sales' end as Department,
 Employee,
Salary 
from cte where rnk<=3 

---ex7
with cte as (
select person_name ,
sum(weight) over(order by person_name  ) - 1000 as tong
from Queue )
select person_name
from cte 
where tong > 0
limit 1

---ex8
WITH cte AS (
SELECT
product_id,
MAX(new_price) AS latest_price
FROM Products
WHERE change_date <= '2019-08-16'
GROUP BY product_id
)
SELECT
p.product_id,
COALESCE(cte.latest_price, 10) AS price
FROM
(SELECT DISTINCT product_id FROM Products) as p
LEFT JOIN cte ON p.product_id =cte.product_id

