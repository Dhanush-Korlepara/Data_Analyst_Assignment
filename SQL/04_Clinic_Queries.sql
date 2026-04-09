-- 1. Revenue per channel
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime)=2021
GROUP BY sales_channel;

-- 2. Top 10 customers
SELECT uid, SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime)=2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- 3. Month-wise profit
WITH revenue AS (
    SELECT DATE_FORMAT(datetime,'%Y-%m') AS month, SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY month
),
expenses_cte AS (
    SELECT DATE_FORMAT(datetime,'%Y-%m') AS month, SUM(amount) AS expense
    FROM expenses
    GROUP BY month
)
SELECT 
    r.month,
    r.revenue,
    e.expense,
    (r.revenue - e.expense) AS profit,
    CASE 
        WHEN (r.revenue - e.expense) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
JOIN expenses_cte e ON r.month = e.month;

-- 4. Most profitable clinic per city
WITH cp AS (
    SELECT c.cid, c.city, SUM(cs.amount) - SUM(IFNULL(e.amount,0)) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.cid, c.city
)
SELECT * FROM cp;

-- 5. Second least profitable clinic per state
WITH cp AS (
    SELECT c.cid, c.state, SUM(cs.amount) - SUM(IFNULL(e.amount,0)) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.cid, c.state
),
ranked AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM cp
)
SELECT * FROM ranked WHERE rnk = 2;