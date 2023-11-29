---EX1
SELECT
EXTRACT(year from transaction_date) as year,
product_id,
spend as curr_year_spend,
lag(spend) over(partition by product_id) as prev_year_spend,
round(100*(spend - lag(spend) over(partition by product_id))/lag(spend) over(partition by product_id),2)  as yoy_rate
FROM user_transactions

---EX2
with cte as (
select card_name,issued_amount,
dense_rank() over(partition by card_name order by issue_year,issue_month) as issued_amount_rank
from monthly_cards_issued )
select card_name,issued_amount
from cte
where issued_amount_rank=1
ORDER BY issued_amount DESC

---EX3
with cte as (
select
user_id,
spend,
transaction_date,
dense_rank() over(partition by user_id order by transaction_date) as giao_dich
from transactions )
select
user_id,
spend,
transaction_date
from cte
where giao_dich=3

---EX4
WITH cte AS 
(SELECT *,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC)
FROM user_transactions
ORDER BY user_id,transaction_date DESC)
SELECT transaction_date,user_id,COUNT(transaction_date) purchase_count
FROM cte
WHERE rank = 1
GROUP BY user_id,transaction_date
ORDER BY transaction_date

---EX5
WITH cte AS (
SELECT
user_id,
tweet_date,
tweet_count,
COALESCE(LAG(tweet_count) OVER (PARTITION BY user_id ORDER BY user_id), 0) AS SAU,
COALESCE(LAG(tweet_count,2) OVER (PARTITION BY user_id ORDER BY user_id), 0) AS SAU_NUA,
CASE 
WHEN COALESCE(LAG(tweet_count) OVER (PARTITION BY user_id ORDER BY user_id), 0) = 0 THEN 1
WHEN 
(COALESCE(LAG(tweet_count) OVER (PARTITION BY user_id ORDER BY user_id), 0) = 0 
OR COALESCE(LAG(tweet_count,2) OVER (PARTITION BY user_id ORDER BY user_id), 0) = 0)
THEN 2
WHEN (COALESCE(LAG(tweet_count) OVER (PARTITION BY user_id ORDER BY user_id), 0) != 0 
OR COALESCE(LAG(tweet_count,2) OVER (PARTITION BY user_id ORDER BY user_id), 0) != 0)
THEN 3
END AS chia
FROM tweets )
SELECT user_id,
tweet_date,
ROUND(1.0*(tweet_count + SAU + SAU_NUA) / chia,2) AS rolling_avg_3d
FROM cte

---EX6
WITH cte as (
SELECT merchant_id,transaction_timestamp,
LEAD (transaction_timestamp) OVER(PARTITION BY merchant_id ORDER BY merchant_id),
EXTRACT(hour FROM (LEAD(transaction_timestamp) OVER (PARTITION BY merchant_id ORDER BY transaction_timestamp) - transaction_timestamp)) * 60
+ EXTRACT(minute FROM (LEAD(transaction_timestamp) OVER (PARTITION BY merchant_id ORDER BY transaction_timestamp) - transaction_timestamp)) AS CHENH_LECH
FROM transactions
)
select count(*) as payment_count
from cte
where CHENH_LECH<10

---EX7
WITH cte AS (
SELECT
category,
product,
SUM(spend) as total_spend,
RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS rank
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product
)
SELECT
category,
product,
total_spend
FROM cte
WHERE rank <= 2

---EX8
with cte as
(
select
a.artist_name as artist_name,
COUNT(*) AS song_appearances,
DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS artist_rank
from artists as a
join songs  as s on a.artist_id=s.artist_id
join global_song_rank  as g on g.song_id = s.song_id
where g.rank <=10
group by a.artist_name
)
select artist_name, artist_rank
from cte
where artist_rank <=5
order by artist_rank
