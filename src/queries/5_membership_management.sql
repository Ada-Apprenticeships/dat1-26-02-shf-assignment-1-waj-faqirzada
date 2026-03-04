.open fittrackpro.db
.mode column

-- 5.1 -List all active memberships with member details   
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    mem.type AS membership_type,
    m.join_date
FROM members m
JOIN memberships mem ON m.member_id = mem.member_id
WHERE mem.status = 'Active';

-- 5.2 - Calculate the average duration of gym visits for each membership type
SELECT 
    mem.type AS membership_type,
    AVG((strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60.0) AS avg_visit_duration_minutes
FROM memberships mem
JOIN attendance a ON mem.member_id = a.member_id
GROUP BY mem.type;

-- 5.3 - Identify members with expiring memberships in 2025
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    mem.end_date
FROM members m
JOIN memberships mem ON m.member_id = mem.member_id
WHERE mem.end_date BETWEEN '2025-01-01' AND '2025-12-31';
