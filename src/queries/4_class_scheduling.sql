.open fittrackpro.db
.mode column

-- 4.1 -List all classes with their instructors
SELECT c.class_id,
    c.name AS class_name,
     s.first_name || ' ' || s.last_name AS instructor_name 
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN staff s ON cs.staff_id = s.staff_id;

-- 4.2 - List classes available on '2025-02-01'
SELECT
    c.class_id,
    c.name,
    cs.start_time,
    cs.end_time
FROM classes C
JOIN class_schedule cs ON c.class_id = cs.class_id
WHERE DATE(cs.start_time) = '2025-02-01';

-- 4.3 -Register member with ID 11 for the Spin Class (class_id 1) on '2025-02-01'
INSERT INTO class_attendance (member_id, schedule_id, attendance_status) -- Adds a brand new row of data into the class_attendance  table so that a record of what class a specefic member has signed up to 
VALUES (11, (SELECT schedule_id FROM class_schedule
    WHERE class_id = 1 AND DATE(start_time) = '2025-02-01'), 'Registered');

-- 4.4 -Cancel a class registration
DELETE FROM class_attendance
WHERE member_id = 3 AND schedule_id = 7;


-- 4.5 -Display most popular classes
SELECT 
    c.class_id,
    c.name AS class_name,
    COUNT(ca.member_id) AS registration_count
FROM classes c 
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
WHERE ca.attendance_status = 'Registered'
GROUP BY c.class_id, c.name
ORDER BY registration_count DESC 
LIMIT 1;

-- 4.6 -Calculate average number of classes per member
SELECT AVG(class_count)
FROM (
    SELECT COUNT(*) AS class_count
    FROM class_attendance
    WHERE attendance_status IN ('Registered', 'Attended')
    GROUP BY member_id
)AS members_count;
