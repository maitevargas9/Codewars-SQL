-- Description
-- The library management system uses two main tables - books and loans. The books table contains details about the 
-- books, while the loans table contains details about the loans.
-- books:
-- book_id (integer) - The unique identifier for a book
-- title (string) - The title of the book
-- author (string) - The author of the book
-- loans:
-- loan_id (integer) - The unique identifier for a loan
-- book_id (integer) - The identifier for the book that was loaned, corresponds to book_id in the books table
-- borrower_name (string) - The name of the person who borrowed the book
-- return_date (date) - The date when the book was returned. If the book has not yet been returned, this field is null.
-- Important Note: In this system, the date a book is loaned corresponds directly to the return date of its previous loan. 
-- This means that when one loan ends (i.e., when a book is returned), a new loan for the same book can start immediately 
-- on that return date.
-- Your task is to write a SQL query to identify the book that has experienced the longest duration between two 
-- consecutive borrows (i.e., between two return dates). If a book is currently borrowed (i.e., return_date is null), 
-- then the duration should be calculated from the last return_date till the CURRENT_DATE. If there is a tie, return 
-- all loans with the same longest duration.
-- The output should be a list of rows with each row containing the following columns:
-- book_id (integer) - The unique identifier for a book.
-- title (string) - The title of the book.
-- author (string) - The author of the book.
-- loan_id (integer) - The ID of the loan.
-- borrower_name (string) - The name of the borrower.
-- longest_borrow_interval (string) - The longest duration for which the book has been borrowed, in the form of "N Days".
-- The results should be ordered by loan_id in ascending order in case of the tie (i.e., when there are multiple loans 
-- with the same longest borrow interval).
-- Desired Output
-- The desired output should look like this:
-- book_id	title	            author	          loan_id	borrower_name	    longest_borrow_interval
-- 5	    Nectar in a Sieve	Arleen Bayer	  14	    Jamal Kuhn DO	    17 Days
-- 16	    The Painted Veil	Valorie Kihn CPA  49	    Tressa Schamberger
WITH
    loan_intervals AS (
        SELECT
            l.book_id,
            b.title,
            b.author,
            l.loan_id,
            l.borrower_name,
            l.return_date,
            LAG (l.return_date) OVER (
                PARTITION BY
                    l.book_id
                ORDER BY
                    l.return_date
            ) AS previous_return_date
        FROM
            loans l
            JOIN books b ON l.book_id = b.book_id
    ),
    borrow_gaps AS (
        SELECT
            book_id,
            title,
            author,
            loan_id,
            borrower_name,
            COALESCE(l.return_date, CURRENT_DATE) - previous_return_date AS borrow_gap
        FROM
            loan_intervals l
        WHERE
            previous_return_date IS NOT NULL
    ),
    max_gap AS (
        SELECT
            MAX(borrow_gap) AS longest_borrow_interval
        FROM
            borrow_gaps
    )
SELECT
    bg.book_id,
    bg.title,
    bg.author,
    bg.loan_id,
    bg.borrower_name,
    CONCAT (bg.borrow_gap, ' Days') AS longest_borrow_interval
FROM
    borrow_gaps bg
    JOIN max_gap mg ON bg.borrow_gap = mg.longest_borrow_interval
ORDER BY
    bg.loan_id ASC;