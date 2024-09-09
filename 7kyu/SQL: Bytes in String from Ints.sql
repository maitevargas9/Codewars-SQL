-- Description
-- Given a table of random numbers as follows:
-- numbers table schema id number1 number2 number3 number4 number5
-- Your job is to return a table in the following format, where each value is the number of bytes in 
-- the string representation of the number.
-- output table schema octnum1 octnum2 octnum3 octnum4 octnum5
-- See expected results for more clarity if required.

SELECT LENGTH(number1::text) AS octnum1,
       LENGTH(number2::text) AS octnum2,
       LENGTH(number3::text) AS octnum3,
       LENGTH(number4::text) AS octnum4,
       LENGTH(number5::text) AS octnum5
FROM numbers;