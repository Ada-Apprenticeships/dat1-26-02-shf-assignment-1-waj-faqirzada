.open fittrackpro.db
.mode column

-- 5.1 
SELECT - List all active memberships with member details   
    m.member_id,
    m.first_name,
    m.last_name,
    mem.membership_type,
    mem.join_date
FROM members m
JOIN memberships mem ON m.member_id = mem.member_id
WHERE mem.status = 'Active' ;

-- 5.2 - Calculate the average duration of gym visits for each membership type
SELECT 
    mem.membership_type,
    AVG((strftime('%s', gv.check_out) - strftime('%s', gv.check_in)) / 60.0) AS avg_visit_duration_minutes
FROM memberships mem
JOIN gym_visits gv ON mem.member_id = gv.member_id
GROUP BY mem.membership_type;

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
