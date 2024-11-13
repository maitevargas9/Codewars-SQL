-- Description
-- Subtract the sum
-- NOTE! This kata can be more difficult than regular 8-kyu katas (lets say 7 or 6 kyu)
-- Complete the function which get an input number n such that n >= 10 and n < 10000, then:
-- Sum all the digits of n.
-- Subtract the sum from n, and it is your new n.
-- If the new n is in the list below return the associated fruit, otherwise return back to task 1.
-- Example
-- n = 325
-- sum = 3+2+5 = 10
-- n = 325-10 = 315 (not in the list)
-- sum = 3+1+5 = 9
-- n = 315-9 = 306 (not in the list)
-- sum = 3+0+6 = 9
-- n =306-9 = 297 (not in the list)
-- .
-- .
-- .
-- ...until you find the first n in the list below.
-- There is no preloaded code to help you. This is not about coding skills; think before you code

CREATE TABLE fruits (id INT, name VARCHAR);

Insert Into fruits (id, name) VALUES (1, 'kiwi');
Insert Into fruits (id, name) VALUES (2, 'pear');
Insert Into fruits (id, name) VALUES (3, 'kiwi');
Insert Into fruits (id, name) VALUES (4, 'banana');
Insert Into fruits (id, name) VALUES (5, 'melon');
Insert Into fruits (id, name) VALUES (6, 'banana');
Insert Into fruits (id, name) VALUES (7, 'melon');
Insert Into fruits (id, name) VALUES (8, 'pineapple');
Insert Into fruits (id, name) VALUES (9, 'apple');
Insert Into fruits (id, name) VALUES (10, 'pineapple');
Insert Into fruits (id, name) VALUES (11, 'cucumber');
Insert Into fruits (id, name) VALUES (12, 'pineapple');
Insert Into fruits (id, name) VALUES (13, 'cucumber');
Insert Into fruits (id, name) VALUES (14, 'orange');
Insert Into fruits (id, name) VALUES (15, 'grape');
Insert Into fruits (id, name) VALUES (16, 'orange');
Insert Into fruits (id, name) VALUES (17, 'grape');
Insert Into fruits (id, name) VALUES (18, 'apple');
Insert Into fruits (id, name) VALUES (19, 'grape');
Insert Into fruits (id, name) VALUES (20, 'cherry');
Insert Into fruits (id, name) VALUES (21, 'pear');
Insert Into fruits (id, name) VALUES (22, 'cherry');
Insert Into fruits (id, name) VALUES (23, 'pear');
Insert Into fruits (id, name) VALUES (24, 'kiwi');
Insert Into fruits (id, name) VALUES (25, 'banana');
Insert Into fruits (id, name) VALUES (26, 'kiwi');
Insert Into fruits (id, name) VALUES (27, 'apple');
Insert Into fruits (id, name) VALUES (28, 'melon');
Insert Into fruits (id, name) VALUES (29, 'banana');
Insert Into fruits (id, name) VALUES (30, 'melon');
Insert Into fruits (id, name) VALUES (31, 'pineapple');
Insert Into fruits (id, name) VALUES (32, 'melon');
Insert Into fruits (id, name) VALUES (33, 'pineapple');
Insert Into fruits (id, name) VALUES (34, 'cucumber');
Insert Into fruits (id, name) VALUES (35, 'orange');
Insert Into fruits (id, name) VALUES (36, 'apple');
Insert Into fruits (id, name) VALUES (37, 'orange');
Insert Into fruits (id, name) VALUES (38, 'grape');
Insert Into fruits (id, name) VALUES (39, 'orange');
Insert Into fruits (id, name) VALUES (40, 'grape');
Insert Into fruits (id, name) VALUES (41, 'cherry');
Insert Into fruits (id, name) VALUES (42, 'pear');
Insert Into fruits (id, name) VALUES (43, 'cherry');
Insert Into fruits (id, name) VALUES (44, 'pear');
Insert Into fruits (id, name) VALUES (45, 'apple');
Insert Into fruits (id, name) VALUES (46, 'pear');
Insert Into fruits (id, name) VALUES (47, 'kiwi');
Insert Into fruits (id, name) VALUES (48, 'banana');
Insert Into fruits (id, name) VALUES (49, 'kiwi');
Insert Into fruits (id, name) VALUES (50, 'banana');
Insert Into fruits (id, name) VALUES (51, 'melon');
Insert Into fruits (id, name) VALUES (52, 'pineapple');
Insert Into fruits (id, name) VALUES (53, 'melon');
Insert Into fruits (id, name) VALUES (54, 'apple');
Insert Into fruits (id, name) VALUES (55, 'cucumber');
Insert Into fruits (id, name) VALUES (56, 'pineapple');
Insert Into fruits (id, name) VALUES (57, 'cucumber');
Insert Into fruits (id, name) VALUES (58, 'orange');
Insert Into fruits (id, name) VALUES (59, 'cucumber');
Insert Into fruits (id, name) VALUES (60, 'orange');
Insert Into fruits (id, name) VALUES (61, 'grape');
Insert Into fruits (id, name) VALUES (62, 'cherry');
Insert Into fruits (id, name) VALUES (63, 'apple');
Insert Into fruits (id, name) VALUES (64, 'cherry');
Insert Into fruits (id, name) VALUES (65, 'pear');
Insert Into fruits (id, name) VALUES (66, 'cherry');
Insert Into fruits (id, name) VALUES (67, 'pear');
Insert Into fruits (id, name) VALUES (68, 'kiwi');
Insert Into fruits (id, name) VALUES (69, 'pear');
Insert Into fruits (id, name) VALUES (70, 'kiwi');
Insert Into fruits (id, name) VALUES (71, 'banana');
Insert Into fruits (id, name) VALUES (72, 'apple');
Insert Into fruits (id, name) VALUES (73, 'banana');
Insert Into fruits (id, name) VALUES (74, 'melon');
Insert Into fruits (id, name) VALUES (75, 'pineapple');
Insert Into fruits (id, name) VALUES (76, 'melon');
Insert Into fruits (id, name) VALUES (77, 'pineapple');
Insert Into fruits (id, name) VALUES (78, 'cucumber');
Insert Into fruits (id, name) VALUES (79, 'pineapple');
Insert Into fruits (id, name) VALUES (80, 'cucumber');
Insert Into fruits (id, name) VALUES (81, 'apple');
Insert Into fruits (id, name) VALUES (82, 'grape');
Insert Into fruits (id, name) VALUES (83, 'orange');
Insert Into fruits (id, name) VALUES (84, 'grape');
Insert Into fruits (id, name) VALUES (85, 'cherry');
Insert Into fruits (id, name) VALUES (86, 'grape');
Insert Into fruits (id, name) VALUES (87, 'cherry');
Insert Into fruits (id, name) VALUES (88, 'pear');
Insert Into fruits (id, name) VALUES (89, 'cherry');
Insert Into fruits (id, name) VALUES (90, 'apple');
Insert Into fruits (id, name) VALUES (91, 'kiwi');
Insert Into fruits (id, name) VALUES (92, 'banana');
Insert Into fruits (id, name) VALUES (93, 'kiwi');
Insert Into fruits (id, name) VALUES (94, 'banana');
Insert Into fruits (id, name) VALUES (95, 'melon');
Insert Into fruits (id, name) VALUES (96, 'banana');
Insert Into fruits (id, name) VALUES (97, 'melon');
Insert Into fruits (id, name) VALUES (98, 'pineapple');
Insert Into fruits (id, name) VALUES (99, 'apple');
Insert Into fruits (id, name) VALUES (100, 'pineapple');

CREATE FUNCTION SubstractTheSum(n int)  RETURNS text  
AS $$   
DECLARE 
  currentn int := n;
BEGIN
  
    WHILE currentn = n OR currentn > 100 
        LOOP
            currentn := currentn - (currentn            % 10
                                      + currentn / 10       % 10
                                      + currentn / 100      % 10
                                      + currentn / 1000     % 10
                                      + currentn / 10000    % 10
                                      + currentn / 100000   % 10
                                      + currentn / 1000000  % 10
                                      + currentn / 10000000 % 10);
            
        END LOOP;
    return (SELECT f.name FROM fruits f WHERE f.id = currentn);
END;
$$
LANGUAGE plpgsql;

SELECT SubstractTheSum(ss.n) AS res FROM sub_sum ss;