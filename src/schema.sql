.open fittrackpro.db
.mode column

DROP TABLE IF EXISTS equipment_maintenance_log;
DROP TABLE IF EXISTS member_health_metrics; 
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS classes;
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
    description VARCHAR(255) NOT NULL,
    capacity INTEGER NOT NULL CHECK (capacity >0), --has to be a positive number
    duration INTEGER NOT NULL CHECK (capacity >0), --class cant be shorter then 0 minutes as then theres no point of a class
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) --Foreign Key is like a permanent link that prevents you from listing a location that doesn't actually exist in your main records.
);

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

CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER,
    type VARCHAR(40) NOT NULL,
    start_date DATE NOT NULL CHECK (start_date LIKE '____-__-__'),
    end_date DATE NOT NULL CHECK (end_date LIKE '____-__-__'),
    status VARCHAR(20) NOT NULL CHECK (status IN ('Active', 'Inactive')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    measurement_date DATE NOT NULL CHECK (measurement_date LIKE '____-__-__'),
    weight DECIMAL(5, 2) NOT NULL,
    body_fat_percentage DECIMAL(4, 1),
    muscle_mass DECIMAL(5, 2),
    bmi DECIMAL(4, 1),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    MEMBER_ID INTEGER NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal')),
    payment_type VARCHAR(50) NOT NULL CHECK (payment_type IN ('Monthly membership fee', 'Day pass;')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    phone_number VARCHAR(20) NOT NULL,
    position VARCHAR(50) NOT NULL CHECK (position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE CHECK (hire_date LIKE '____-__-__'),
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

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

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER,
    staff_id INTEGER,
    start_time DATETIME NOT NULL CHECK (start_time  LIKE '____-__-__ __:__:__'),
    end_time DATETIME NOT NULL CHECK (end_time LIKE '____-__-__ __:__:__'),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER,
    member_id INTEGER,
    attendance_status VARCHAR(20) NOT NULL CHECK (attendance_status IN ('Registered', 'Attended', 'Unattended')),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipment_id INTEGER NOT NULL,
    maintenance_date DATE NOT NULL CHECK (maintenance_date LIKE '____-__-__'),
    description VARCHAR(255) NOT NULL,
    staff_id INTEGER NOT NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN key (staff_id) REFERENCES staff(staff_id)
);
