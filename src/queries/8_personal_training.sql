.open fittrackpro.db
.mode column

-- 8.1 -List all personal training sessions for specific trainer "Ivy Irwin"
SELECT 
    pts.session_id s.first_name || ' ' || s.last_name AS member_name,
    pts.session_date,
    pts.start_time,
    pts.end_time,
FROM personal_training_sessions pts
JOINS staff s ON pts>staff_id = s.staff_id
JOIN members m pts.member_id = m.member_id
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin';