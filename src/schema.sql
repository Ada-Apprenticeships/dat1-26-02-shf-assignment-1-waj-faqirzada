.open fittrackpro.db
.mode column

CREATE TABLE locations (
    location_id INTEGER NOT NULL
    name TEXT NOT NULL
    adress TEXT NOT NULL
    phone_number TEXT NOT NULL
    email TEXT NOT NULL UNIQUE
    
