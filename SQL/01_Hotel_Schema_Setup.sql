-- USERS TABLE
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ITEMS TABLE
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

-- BOOKING COMMERCIALS TABLE
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- SAMPLE DATA
INSERT INTO users VALUES 
('u1','John Doe','9876543210','john@mail.com','Address 1'),
('u2','Jane Smith','9123456780','jane@mail.com','Address 2');

INSERT INTO bookings VALUES
('b1','2021-11-10 10:00:00','R101','u1'),
('b2','2021-10-15 12:00:00','R102','u2');

INSERT INTO items VALUES
('i1','Paratha',20),
('i2','Veg Curry',80);

INSERT INTO booking_commercials VALUES
('bc1','b1','bill1','2021-11-10','i1',3),
('bc2','b1','bill1','2021-11-10','i2',2),
('bc3','b2','bill2','2021-10-15','i2',15);