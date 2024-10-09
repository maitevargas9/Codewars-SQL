-- Description
-- Write a function that checks if a given string (case insensitive) is a palindrome.
-- A palindrome is a word, number, phrase, or other sequence of symbols that reads the 
-- same backwards as forwards, such as madam or racecar.
-- SELECT str, str.reverse() == true AS str, res FROM ispalindrome;
SELECT
    str,
    REVERSE (LOWER(str)) = LOWER(str) as res
FROM
    ispalindrome;