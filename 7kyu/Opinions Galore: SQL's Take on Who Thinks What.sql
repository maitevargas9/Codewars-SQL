-- Description
-- Develop an SQL query that retrieves a sorted list of opinion changes among individuals, with special emphasis 
-- on handling NULL values
-- We have people table:
-- person_id (int, primary key): Unique identifier for each person.
-- name (string): The name of the person.
-- and people_opinions
-- opinion_giver_id (int, foreign key referencing people.person_id): Identifier for the person giving the opinion.
-- person_id (int, foreign key referencing people.person_id): Identifier for the person being opined about.
-- current_opinion (string, nullable): The current opinion of the opinion giver about the person. Nullable to represent 
-- the absence of an opinion.
-- previous_opinion (string, nullable): The previous opinion of the opinion giver about the person. Nullable to represent 
-- the absence of an opinion.
-- Write an SQL query that selects the names of the opinion giver and receiver(opinion_giver and opinion_receiver), 
-- along with their current (current_opinion) and previous (previous_opinion) opinions. Include only records where the 
-- current opinion differs from the previous opinion. Sort the results first by the name of the opinion giver and then by 
-- the name of the opinion receiver - both in ascending alphabetical order.
-- Desired Output
-- The desired output should look like this:
-- opinion_giver	   opinion_receiver	    current_opinion	     previous_opinion
-- Albert Einstein	   Robert Oppenheimer	Innovator	
-- Richard Feynman	   Linus Pauling	    Pseudoscientific	 Brilliant
-- Richard Feynman	   Richard Feynman		                     Admirable
-- Robert Oppenheimer  Albert Einstein	    Incomparable Genius	 Genius
SELECT
    giver.name AS opinion_giver,
    receiver.name AS opinion_receiver,
    po.current_opinion,
    po.previous_opinion
FROM
    people_opinions AS po
    INNER JOIN people AS giver ON giver.person_id = po.opinion_giver_id
    INNER JOIN people AS receiver ON receiver.person_id = po.person_id
WHERE
    po.current_opinion IS DISTINCT
FROM
    po.previous_opinion
ORDER BY
    opinion_giver ASC,
    opinion_receiver ASC;