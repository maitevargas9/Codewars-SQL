-- Description
-- You are provided with a PostgreSQL database that contains a table project_tasks used for tracking 
-- the progress of tasks in a company project. The table structure is as follows:
-- task_id (int): Unique identifier for each task.
-- initial_assignment (varchar): The team member initially assigned to the task.
-- first_review (varchar): The team member who conducted the first review.
-- second_review (varchar): The team member who conducted the second review.
-- final_review (varchar): The team member who conducted the final review.
-- completion (varchar): The team member who marked the task as completed.
-- Each column, apart from task_id, can have null values.
-- Write an SQL query hat selects two columns: task_id and second_last_contributor. 
-- second_last_contributor should be the name of the team member who last worked on 
-- the task, excluding the current stage. For example, if a task is in the final_review 
-- stage, second_last_contributor should show who conducted the second_review.
-- Tasks can skip stages. For example, a task might move directly from initial_assignment to 
-- final_review without intermediate reviews (all columns in between are null). 
-- This reflects real-world situations where previously set stages may become null (e.g., a reviewer being removed).
-- Sorting should be by task_id in descending order.
-- For example, for this sample data:
-- task_id: 1, initial_assignment: 'Alice', first_review: 'Bob', second_review: 'Charlie', final_review: 'Diana', 
-- completion: 'Eva'
-- task_id: 2, initial_assignment: 'Alice', first_review: 'Bob'
-- task_id: 3, initial_assignment: 'Alice'
-- task_id: 4, initial_assignment: 'Frank', first_review: 'Grace', second_review: 'Hank'
-- task_id: 5, initial_assignment: 'Ian', first_review: 'Jack', second_review: 'Kathy', final_review: 'Liam'
-- task_id: 6, initial_assignment: 'Mona', first_review: 'Nate', second_review: 'Olivia', final_review: 'Pete', 
-- completion: 'Quinn'
-- the desired output is the following;
-- task_id	second_last_contributor
-- 6	    Pete
-- 5	    Kathy
-- 4	    Grace
-- 3	
-- 2	    Alice
-- 1	    Diana

SELECT 
  task_id,
  (ARRAY_REMOVE(ARRAY[completion, final_review, second_review, first_review, initial_assignment], NULL))[2] AS second_last_contributor
FROM project_tasks
ORDER BY task_id DESC;