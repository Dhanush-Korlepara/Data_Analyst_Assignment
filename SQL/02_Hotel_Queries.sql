-- 1. Last booked room for each user
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking
    FROM bookings
    GROUP BY user_id
) latest
ON b.user_id = latest.user_id 
AND b.booking_date = latest.last_booking;

-- 2. Total billing amount in Nov 2021
SELECT 
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;

-- 3. Bills > 1000 in Oct 2021
SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- 4. Most & least ordered item each month
WITH item_orders AS (
    SELECT 
        DATE_FORMAT(bill_date, '%Y-%m') AS month,
        item_id,
        SUM(item_quantity) AS total_qty
    FROM booking_commercials
    WHERE YEAR(bill_date) = 2021
    GROUP BY month, item_id
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS max_rank,
        RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS min_rank
    FROM item_orders
)
SELECT * FROM ranked WHERE max_rank = 1 OR min_rank = 1;

-- 5. Second highest bill each month
WITH bill_totals AS (
    SELECT 
        bill_id,
        DATE_FORMAT(bill_date, '%Y-%m') AS month,
        SUM(bc.item_quantity * i.item_rate) AS total_amount
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY bill_id, month
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY month ORDER BY total_amount DESC) AS rnk
    FROM bill_totals
)
SELECT * FROM ranked WHERE rnk = 2;