.open fittrackpro.db
.mode column

DROP TABLE IF EXISTS EQUIPMENT_MAINTENANCE_LOG;
DROP TABLE IF EXISTS MEMBER_HEALTH_METRICS;
DROP TABLE IF EXISTS PERSONAL_TRAINING_SESSIONS;
DROP TABLE IF EXISTS PAYMENT;
DROP TABLE IF EXISTS CLASS_ATTENDANCE;
DROP TABLE IF EXISTS ATTENDANCE;
DROP TABLE IF EXISTS MEMBERSHIPS;
DROP TABLE IF EXISTS CLASS_SCHEDULE;
DROP TABLE IF EXISTS CLASSES;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT, --This creates a unique ID number for every location that the database counts up automatically each time you add a new one.
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    opening_hours VARCHAR(20) NOT NULL CHECK (opening_hours LIKE '__:__-__:__')
);

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INTEGER NOT NULL CHECK (capacity >0), --has to be a positive number
    duration INTEGER NOT NULL CHECK (capacity >0), --class cant be shorter then 0 minutes as then theres no point of a class
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

INSERT INTO locations (location_id, name, address, phone_number, email, opening_hours)
VALUES
(1, 'Downtown Fitness','123 Main St, London','020 555 1234','downtown@fittrackpro.com','06:00-22:00'),
(2, 'Suburban Wellness','45 Oak Ln, Manchester','0161 555 5678','suburban@fittrackpro.com','05:00-23:00');

INSERT INTO classes (class_id, name, description, capacity, duration, location_id)
VALUES
(1, 'Spin Class', 'High intensity indoor cycling', 20, 45, 1),
(2, 'Yoga Basics', 'Beginner level yoga', 15, 60, 1),
(3, 'HIIT', 'High Interval Intensity Training', 10, 30, 2);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARcHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    phone_number VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL CHECK (date_of_birth LIKE '____-__-__'),
    join_date DATE NOT NULL DEFAULT CURRENT_DATE CHECK (join_date LIKE '____-__-__'),
    emergency_contact_name VARCHAR(100) NOT NULL,
    emergency_contact_phone VARCHAR(20) NOT NULL
);

INSERT INTO members(member_id, first_name, last_name, email, phone_number, date_of_birth, join_date,emergency_contact_name, emergency_contact_phone)
VALUES
(1, 'Alice', 'Smith', 'alice.smith@email.com', '07700 900001', '1990-05-15', '2023-01-10', 'Bob Smith', '07700 900002'),
(2, 'Bob', 'Jones', 'bob.jones@email.com', '07700 900003', '1985-08-22', '2023-02-15', 'Carol Jones', '07700 900004'),
(3, 'Charlie', 'Brown', 'charlie.brown@email.com', '07700 900005', '1992-03-30', '2023-03-20', 'Dave Brown', '07700 900006'),
(4, 'Diana', 'Prince', 'diana.prince@email.com', '07700 900007', '1988-11-05', '2023-04-25', 'Steve Trevor', '07700 900008'),
(5, 'Emily', 'Jones', 'emily.jones@email.com', '07700 900009', '1995-07-12', '2023-05-10', 'Frank Jones', '07700 900010'),
(6, 'Frank', 'Castle', 'frank.castle@email.com', '07700 900011', '1980-02-18', '2023-06-15', 'Maria Castle', '07700 900012'),
(7, 'Grace', 'Lee', 'grace.lee@email.com', '07700 900013', '1998-09-25', '2023-07-20', 'Henry Lee', '07700 900014'),
(8, 'Henry', 'Ford', 'henry.ford@email.com', '07700 900015', '1975-12-30', '2023-08-05', 'Iris Ford', '07700 900016'),
(9, 'Iris', 'West', 'iris.west@email.com', '07700 900017', '1993-04-14', '2023-09-10', 'Barry Allen', '07700 900018'),
(10, 'Jack', 'Ryan', 'jack.ryan@email.com', '07700 900019', '1982-10-08', '2023-10-15', 'Cathy Ryan', '07700 900020'),
(11, 'Kevin', 'Mitnick', 'kevin.mitnick@email.com', '07700 900021', '1996-01-22', '2023-11-20', 'Unknown', '07700 900022');

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    phone_number VARCHAR(20) NOT NULL,
    position VARCHAR(50) NOT NULL CHECK (position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE CHECK (hire_date LIKE '____-__-__'),
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) --This link makes sure that every person in the staff table is connected to a real place listed in the locations table.
 );

 INSERT INTO staff (staff_id, first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES 
(1, 'James', 'Bond', 'james.bond@fittrackpro.com', '07007 007007', 'Manager', '2022-01-01', 1),
(2, 'Ivy', 'Irwin', 'ivy.irwin@fittrackpro.com', '07123 456789', 'Trainer', '2023-05-15', 1),
(3, 'Sarah', 'Connor', 'sarah.connor@fittrackpro.com', '07999 888777', 'Receptionist', '2023-08-01', 1),
(4, 'Lara', 'Croft', 'lara.croft@fittrackpro.com', '07555 444333', 'Trainer', '2023-09-10', 2);

CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    type varchar(20) NOT NULL CHECK (type IN('Cardio', 'Strength')),
    purchase_date DATE NOT NULL CHECK (purchase_date LIKE '____-__-__'),
    last_maintenance_date DATE CHECK (last_maintenance_date LIKE '____-__-__'),
    next_maintenance_date DATE CHECK (next_maintenance_date LIKE '____-__-__'),
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
 );

INSERT INTO equipment (equipment_id, name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES
(1, 'Treadmill 2000', 'Cardio', '2023-01-15', '2024-12-15', '2025-01-15', 1),
(2, 'Elliptical Trainer', 'Cardio', '2023-02-20', '2024-07-20', '2025-02-20', 1),
(3, 'Smith Machine', 'Strength', '2023-03-10', '2024-03-10', '2025-03-10', 1),
(4, 'Dumbbell Set', 'Strength', '2023-04-05', '2024-04-05', '2025-04-05', 2);

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER,
    staff_id INTEGER,
    start_time DATETIME NOT NULL CHECK (start_time  LIKE '____-__-__ __:__:__'),
    end_time DATETIME NOT NULL CHECK (end_time LIKE '____-__-__ __:__:__'),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

INSERT INTO class_schedule (schedule_id, class_id, staff_id, start_time, end_time)
VALUES
(1, 1, 2, '2025-02-01 09:00:00', '2025-02-01 09:45:00'),
(2, 2, 4, '2025-02-01 10:00:00', '2025-02-01 11:00:00'),
(3, 3, 2, '2025-02-02 18:00:00', '2025-02-02 18:30:00'),
(7, 2, 4, '2025-02-05 12:00:00', '2025-02-05 13:00:00');