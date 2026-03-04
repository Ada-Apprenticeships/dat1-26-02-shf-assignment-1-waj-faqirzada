.open fittrackpro.db
.mode column

-- 7.1 -List all staff members by position
SELECT 
    staff_id,
    first_name,
    last_name,
    position AS role
FROM staff
ORDER BY position;

-- 7.2 - Find trainers with one or more personal training session in the upcoming month
SELECT 
    s.staff_id AS trainer_id,
    s.first_name || ' ' || s.last_name AS trainer_name,
    COUNT(pts.session_id) AS session_count
FROM staff s
JOIN personal_training_sessions pts ON s.staff_id = pts.staff_id
WHERE pts.session_datetime BETWEEN '2025-01-20' AND '2025-02-19'
GROUP BY s.staff_id
HAVING session_count >= 1;