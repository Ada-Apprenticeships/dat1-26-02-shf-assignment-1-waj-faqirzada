.open fittrackpro.db
.mode column

-- 3.1- Find equipment due for maintenance in the next 30 days 
SELECT equipment_id, name, next_maintenance_date
FROM equipment
WHERE next_maintenance_date BETWEEN '2025-01-01' AND DATE('2025-01-01', '+30 days');

-- 3.2 -Count equipment types in stock
SELECT equipment_type, COUNT(*) AS count
FROM equipment
GROUP BY equipment_type;

-- 3.3 -Calculate average age of equipment by type (in days)
 SELECT 
    equipment_type,
    AVG(JULIANDAY('now') - JULIANDAY(purchase_date)) AS avg_age_days -- age of EQ(in days) by differnce of today and pruchase date 
FROM equipment
GROUP BY equipment_type;
