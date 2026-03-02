.open fittrackpro.db
.mode column

-- 2.1 -Record a payment for a membership
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (11, 50.00, datetime('now'), 'Credit Card', 'Monthly membership fee');

-- 2.2 -Calculate total revenue from membership fees for each month
SELECT 
    strftime('%Y-%m', payment_date) AS month, 
    SUM(amount) AS total_revenue
FROM payments
WHERE payment_type = 'Monthly membership fee'
  AND payment_date BETWEEN '2024-11-01' AND '2025-02-28 23:59:59'
GROUP BY month
ORDER BY month;

-- 2.3 -Find all day pass purchases
SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass';
