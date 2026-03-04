.open fittrackpro.db
.mode column

-- 6.1 - Record a member's gym visit
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, '2025-02-14 16:30:00');

-- 6.2 - Retrieve a member's attendance history
SELECT 
    DATE(check_in_time) AS visit_date,
    check_in_time,
    check_out_time
FROM attendance
WHERE member_id = 5;

-- 6.3 -Find the busiest day of the week based on gym visits
SELECT 
    strftime('%w', check_in_time) AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

-- 6.4 -Calculate the average daily attendance for each location
SELECT 
    l.name AS location_name,
    AVG(daily_counts.visit_count) AS avg_daily_attendance
FROM locations l
LEFT JOIN (
    SELECT location_id, DATE(check_in_time) as visit_date, COUNT(*) as visit_count
    FROM attendance
    GROUP BY location_id, visit_date
) AS daily_counts ON l.location_id = daily_counts.location_id
GROUP BY l.location_id;
