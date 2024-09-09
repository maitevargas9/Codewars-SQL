-- Description
-- As ABC Kata Solutions celebrates its 10th anniversary, the company reflects on a decade of significant growth and innovation. 
-- In the spirit of this milestone, the CFO has initiated a challenge to uncover the departments with the most creatively 
-- extravagant expenses over the years. From golden toilet seats to confetti cannons, ABC Kata Solutions' expense reports reveal 
-- a history of unorthodox spending. The task is to analyze financial data and identify the top five departments responsible for 
-- these exceptional expenditures, highlighting the company's unique corporate culture as it embarks on another decade of success.
-- We have departments table:
-- department_id (integer, primary key): Unique identifier for the department.
-- department_name (string, unique): Name of the department.
-- and expenses table:
-- expense_id (integer, primary key): Unique identifier for the expense.
-- department_id (integer, foreign key): Identifier for the department that made the expense.
-- amount (decimal): The amount of money spent on the expense.
-- date (date): The date the expense was incurred.
-- description (varchar): A description of the expense.
-- The SQL query must filter the expenses based on two types of conditions described below:
-- Description-Based Conditions:
-- This is indicated by the presence of specific keywords within the description field of the expenses table. The keywords to 
-- look for are:
-- "confetti"
-- "glitter"
-- "golden toilet"
-- "massage chair"
-- "video game"
-- "karaoke"
-- The analysis of the keywords should be case-insensitive.
-- Date-Based Conditions:
-- Expenses that were recorded on specific dates that hold particular significance:
-- April Fools’ Day (April 1st): Recognizing expenses that might have been made as part of practical jokes or humorous 
-- engagements on this day.
-- Company’s Founding Anniversary (May 21st): Identifying spending that occurred on the anniversary of ABC Kata Solutions' 
-- founding, which might be related to celebration activities.
-- Query must calculate the total spent by each department on these select expenses.
-- The results should be ordered first by the total_questionable_expenses in descending order, and secondarily by department 
-- name in descending alphabetical order to resolve any ties.
-- Only the top five departments should be listed in the final output.
-- The result should have only 2 colums:
-- department_name (varchar): The name of the department responsible for the expense.
-- total_questionable_expenses (money): The total amount spent by the department on specified extravagant items and during 
-- significant dates, aggregated across all matching records. The formatting and rounding is handled by PostgreSQL's money 
-- datatype.
-- For this sample data:
-- departments: 
-- | department_id| department_name |
-- +--------------+-----------------+
-- | 1            | Engineering     |
-- | 2            | Marketing       |
-- | 3            | Human Resources |
-- | 4            | Finance         |
-- | 5            | Sales           |
-- expenses:
-- | expense_id| department_id| amount | date       | description                           |
-- +-----------+--------------+--------+------------+---------------------------------------+
-- | 1         | 1            | 500.0  | 2022-04-01 | confetti for product launch           |
-- | 2         | 1            | 1200.0 | 2023-05-21 | golden toilet for new office          |
-- | 3         | 2            | 300.0  | 2023-01-01 | Glitter bombs for ad campaign         |
-- | 4         | 3            | 450.0  | 2022-04-01 | KARAOKE machine for office party      |
-- | 5         | 4            | 2000.0 | 2023-05-21 | luxury massage chairs for finance     |
-- | 6         | 5            | 800.0  | 2022-12-25 | video game console for sales team     |
-- the desired output is the following:
-- | department_name | total_questionable_expenses |
-- +-----------------+-----------------------------+
-- | Finance         | $2,000.00                   |
-- | Engineering     | $1,700.00                   |
-- | Sales           | $800.00                     |
-- | Human Resources | $450.00                     |
-- | Marketing       | $300.00                     |

SELECT 
  d.department_name, 
  SUM(e.amount)::money::TEXT AS total_questionable_expenses 
FROM departments d
JOIN 
  expenses e USING (department_id)
WHERE 
  e.description ~* 'confetti|glitter|golden toilet|massage chair|video game|karaoke' OR 
  to_char(e.date, 'MM-DD') IN ('04-01', '05-21')
GROUP BY d.department_name
ORDER BY SUM(e.amount) DESC, 1 DESC
LIMIT 5;