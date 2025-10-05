/*
 * Project Name: Library Management System
 * Description: SQL script to create and manage the Library Management database.
 * This includes tables for branches, employees, books, members, issued books, and returned books.
 */

-- ==========================================================
-- Step 1: Create and select the database
-- ==========================================================
DROP
DATABASE IF EXISTS library_management;
CREATE
DATABASE library_management;
USE
library_management;

-- ==========================================================
-- Step 2: Create 'branch' table
-- Stores information about each library branch
-- ==========================================================
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
    branch_id      VARCHAR(10) PRIMARY KEY,
    manager_id     VARCHAR(10),
    branch_address VARCHAR(55),
    contact_no     VARCHAR(20)
);

SELECT *
FROM branch;

-- ==========================================================
-- Step 3: Create 'employees' table
-- Stores details about library employees and links them to a branch
-- ==========================================================
DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
    emp_id    VARCHAR(10) PRIMARY KEY,
    emp_name  VARCHAR(25),
    position  VARCHAR(15),
    salary    FLOAT,
    branch_id VARCHAR(10) -- Foreign key referencing 'branch'
);

-- ==========================================================
-- Step 4: Create 'books' table
-- Stores information about books available in the library
-- ==========================================================
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
    isbn         VARCHAR(20) PRIMARY KEY,
    book_title   VARCHAR(75),
    category     VARCHAR(15),
    rental_price FLOAT,
    status       VARCHAR(10),
    author       VARCHAR(35),
    publisher    VARCHAR(55)
);

-- ==========================================================
-- Step 5: Create 'members' table
-- Stores details of library members
-- ==========================================================
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
    member_id      VARCHAR(10) PRIMARY KEY,
    member_name    VARCHAR(25),
    member_address VARCHAR(75),
    reg_date       DATE
);

-- ==========================================================
-- Step 6: Create 'issued_status' table
-- Tracks information about books issued to members
-- ==========================================================
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
    issued_id        VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(10), -- FK referencing 'members'
    issued_book_name VARCHAR(75),
    issued_date      DATE,
    issued_book_isbn VARCHAR(25), -- FK referencing 'books'
    issued_emp_id    VARCHAR(10)  -- FK referencing 'employees'
);

-- ==========================================================
-- Step 7: Create 'return_status' table
-- Tracks books returned by members
-- ==========================================================
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
    return_id        VARCHAR(10) PRIMARY KEY,
    issued_id        VARCHAR(10), -- FK referencing 'issued_status'
    return_book_name VARCHAR(75),
    return_date      DATE,
    return_book_isbn VARCHAR(25)
);

-- ==========================================================
-- Step 8: Define foreign key relationships
-- ==========================================================

-- Link employees to their respective branch
ALTER TABLE employees
    ADD CONSTRAINT fk_branch_id
        FOREIGN KEY (branch_id)
            REFERENCES branch (branch_id);

-- Link issued books to members
ALTER TABLE issued_status
    ADD CONSTRAINT fk_member_id
        FOREIGN KEY (issued_member_id)
            REFERENCES members (member_id);

-- Link issued books to book records
ALTER TABLE issued_status
    ADD CONSTRAINT fk_book_id
        FOREIGN KEY (issued_book_isbn)
            REFERENCES books (isbn);

-- Link issued books to employees who issued them
ALTER TABLE issued_status
    ADD CONSTRAINT fk_employee_id
        FOREIGN KEY (issued_emp_id)
            REFERENCES employees (emp_id);

-- Link returned books to issued records
ALTER TABLE return_status
    ADD CONSTRAINT fk_issued_status_id
        FOREIGN KEY (issued_id)
            REFERENCES issued_status (issued_id);
