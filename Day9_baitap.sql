---ex1
SELECT
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_reviews,
SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership

---ex2
select x,y,z,
CASE
WHEN x+y>z and x+z>y and y+z>x then 'Yes'
ELSE 'No'
END AS triangle
from Triangle

---ex3
select
round(100.0 * sum(case  call_category is null
or call_category = 'n/a' then 1
else 0
end) / count(*),1) as call_percentage
from callers

---ex4
select
name
from Customer
where referee_id != 2 or referee_id is null

--ex5
 select
survived,
sum(case
when pclass=1 then 1 else 0
end) as first_class,
sum(case
when pclass=2 then 1 else 0
end) as second_classs,
sum(case
when pclass=3 then 1 else 0
end) as third_class
from titanic
group by survived
