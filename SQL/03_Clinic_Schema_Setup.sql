CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10,2),
    datetime DATETIME
);

-- SAMPLE DATA
INSERT INTO clinics VALUES
('c1','ABC Clinic','Hyderabad','Telangana','India');

INSERT INTO customer VALUES
('u1','John','9999999999');

INSERT INTO clinic_sales VALUES
('o1','u1','c1',5000,'2021-10-10','online');

INSERT INTO expenses VALUES
('e1','c1','Medicines',2000,'2021-10-10');