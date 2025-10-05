-- ==========================================================
-- Task 1: Insert a New Book Record
-- Objective: Adds the book "To Kill a Mockingbird" to the books table
-- ==========================================================
INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- ==========================================================
-- Task 2: Update an Existing Member’s Address
-- Objective: Updates the address for the member with ID 'C103'
-- ==========================================================
UPDATE members
SET member_address = '841 Main St'
WHERE member_id = 'C103';

-- ==========================================================
-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table
-- ==========================================================
DELETE
FROM issued_status
WHERE issued_id = 'IS121';

-- ==========================================================
-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'
-- ==========================================================
SELECT *
FROM issued_status
WHERE issued_emp_id = 'E101';

-- ==========================================================
-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book
-- ==========================================================
SELECT issued_member_id,
       COUNT(*) AS total_books_issued
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(*) > 1;

-- ==========================================================
-- Task 6: Create a Summary Table of Book Issue Counts
-- Objective: Use CTAS (Create Table As Select) to generate a table
--             listing each book and the total number of times it was issued
-- ==========================================================
CREATE TABLE book_issued_cnt AS
SELECT b.isbn,
       b.book_title,
       COUNT(ist.issued_id) AS issue_count
FROM issued_status AS ist
         JOIN books AS b
              ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;