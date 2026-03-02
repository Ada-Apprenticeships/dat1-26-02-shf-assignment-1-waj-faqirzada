.open fittrackpro.db
.mode column

-- 1.1-Retrieve all members
SELECT 
    member_id,
    first_name,
    last_name,
    email,
    join_date
FROM members;       

-- 1.2-Update a member's contact information
SET phone_number = '0700 100005',
    email = 'emily.jones.updated@email.com'
WHERE member_id = 5;


-- 1.3-Count total number of members
SELECT COUNT(*) AS total_members
FROM members:

-- 1.4-Find member with the most class registrations
SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.class_attendance_id) AS registration_count
FROM members m
JOIN class_attendance ca ON m.member_id = ca.member_id
GROUP BY m.member_id
ORDER BY registration_count DESC 
LIMIT 1;

-- 1.5-Find member with the least class registrations
SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.class_attendance_id) AS registration_count
FROM members m
JOIN class_attendance ca ON m.member_id = ca.member_id
GROUP BY m.member_id
ORDER BY registration_count ASC 
LIMIT 1;

-- 1.6-Count the total number of members who have attended at least two classes
SELECT COUNT(*) AS high_frequency_members
FROM (
    SELECT member_id 
    FROM class_attendance 
    WHERE attendance_status = 'Attended' 
    GROUP BY member_id 
    HAVING COUNT(*) >= 2
);
