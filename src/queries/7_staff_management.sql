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

