-- Description
-- The library management system uses two main tables - books and loans. The books table contains details about the books, 
-- while the loans table contains details about the loans.
-- books:
-- book_id (integer) - The unique identifier for a book
-- title (string) - The title of the book
-- author (string) - The author of the book
-- loans:
-- loan_id (integer) - The unique identifier for a loan
-- book_id (integer) - The identifier for the book that was loaned, corresponds to book_id in the books table
-- borrower_name (string) - The name of the person who borrowed the book
-- return_date (date) - The date when the book was returned. If the book has not yet been returned, this field is null.
-- Your task is to write a SQL query that identifies which books have been borrowed the most from a library and who was 
-- the last person to borrow them. If there is a tie, return all tied books, sorted by book_id in ascending order.
-- The output should be a single row (or list of rows in the case of the tie) with row containing the following columns:
-- book_id (integer) - The unique identifier for a book.
-- title (string) - The title of the book.
-- last_borrower (string) - The name of the last person who borrowed the book.
-- loan_count (integer) - The total count of loans for the book.
-- The "last borrower" of a book is determined based on the return_date in the loans table. There are two possibilities for 
-- each loan record:
-- The return_date is null: In this case, the book has not been returned yet, and the borrower_name is considered the current 
-- borrower of the book.
-- The return_date is not null: In this case, the book has been returned, and the borrower_name is considered a previous borrower.
-- When multiple loan records exist for the same book, the following rules are applied:
-- If there is a loan record with a null return_date, this indicates the book is currently borrowed and the borrower_name from 
-- this record is chosen as the last borrower.
-- If there are no loan records with a null return_date, the one with the most recent return_date is chosen as the last borrower. 
-- This is the person who returned the book most recently.
-- Desired Output
-- The desired output should look like this:
-- book_id	title	                       last_borrower	     loan_count
-- 18	    The Sun Also Rises	            Xavier Durgan I	     5
-- 20	    Bury My Heart at Wounded Knee	Msgr. Tammara Batz	 5
-- ...
WITH
    loan AS (
        SELECT DISTINCT
            ON (book_id) book_id,
            borrower_name,
            COUNT(loan_id) OVER (
                PARTITION BY
                    book_id
            ) AS loan_count
        FROM
            loans
        ORDER BY
            book_id,
            return_date DESC
    )
SELECT
    book_id,
    title,
    borrower_name AS last_borrower,
    loan_count
FROM
    books
    JOIN loan USING (book_id)
WHERE
    loan_count >= ALL (
        SELECT
            loan_count
        FROM
            loan
    );