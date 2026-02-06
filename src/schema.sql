.open fittrackpro.db
.mode column

DROP TABLE IF EXISTS locations;
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    opening_hours VARCHAR(20) NOT NULL CHECK (opening_hours LIKE '__:__-__:__')
);

-- INSERT INTO locations (location_id,name,address,phone_number,email,opening_hours)
-- VALUES
-- (1, 'Downtown Fitness','123 Main St, London','020 555 1234','downtown@fittrackpro.com','06:00-22:00'),
-- (2, 'Suburban Wellness','45 Oak Ln, Manchester','0161 555 5678','suburban@fittrackpro.com','05:00-23:00');


DROP TABLE IF EXISTS members;
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARVHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    phone_number VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL CHECK (date_of_birth LIKE '____-__-__'),
    join_date DATE NOT NULL  CURRENT_DATE CHECK (join_date LIKE '____-__-__'),
    emergency_contact_name VARCHAR(100) NOT NULL,
    emergency_contact_phone VARCHAR(20) NOT NULL
);

INSERT INTO members (member_id,first_name,last_name,email,phone_number,date_of_birth,join_date,emergency_contact_name,emergency_contact_phone)
VALUES
(1,'Alice,Smith,alice.smith@email.com,'07700 900001',1990-05-15,2023-01-10,'Bob Smith','07700 900002'),
2,Bob,Jones,bob.jones@email.com,'07700 900003',1985-08-22,2023-02-15,'Carol Jones','07700 90000');



