.open fittrackpro.db
.mode column

CREATE TABLE locations (
    location_id INTEGER PRIMARY NOT NULL,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    opening_hours VARCHAR(20) NOT NULL
);

INSERT INTO location_id,name,address,phone_number,email,opening_hours
1,"Downtown Fitness","123 Main St, London","020 555 1234",downtown@fittrackpro.com,06:00-22:00
2,"Suburban Wellness","45 Oak Ln, Manchester","0161 555 5678",suburban@fittrackpro.com,05:00-23:00
