-- Description
-- As part of streamlining the hiring process at tech company, we aim to categorize all job applications into 
-- two distinct groups based on their evaluation status:
-- Rejected: Applications where the candidate did not meet the necessary criteria for the role, including technical 
-- skills, company cultural fit, or other qualifications as determined by the hiring team.
-- Approved: Applications where the candidate successfully met or exceeded the evaluation criteria and are considered 
-- strong candidates for the next stages of the hiring process.
-- To achieve this, we use the applications table, where each application has a status represented by the application_status 
-- column. A status value of 5 or lower indicates a rejected application, while a status value greater than 5 indicates an 
-- approved application.
-- applications:
-- application_id (int): primary key
-- application_status: The status of the job application, represented by an integer.
-- Result Set Columns:
-- status_group: This column categorizes the applications into two groups: 'Rejected' and 'Approved'. We display 'Rejected' 
-- at first. The categorization is based on the value of the application_status column in the applications table:
-- 'Rejected': Applications with an application_status value of 5 or lower.
-- 'Approved': Applications with an application_status value greater than 5.
-- application_num: The number of applications in each status group. This column provides a count of applications that fall 
-- into the 'Rejected' or 'Approved' categories.
-- We always have to see both categories in the results, even if one or both of the counts is zero.
-- For this sample data:
-- | application_id | application_status |
-- +----------------+--------------------+
-- | 1              | 3                  |
-- | 2              | 6                  |
-- | 3              | 4                  |
-- | 4              | 7                  |
-- | 5              | 5                  |
-- | 6              | 8                  |
-- | 7              | 2                  |
-- | 8              | 9                  |
-- the expected output of the query is following:
-- | status_group  | application_num|
-- +---------------+----------------+
-- | Rejected      | 4              |
-- | Approved      | 4              |
SELECT
    'Rejected' AS status_group,
    COUNT(application_status) AS application_num
FROM
    applications
WHERE
    application_status <= 5
UNION
SELECT
    'Approved' AS status_group,
    COUNT(application_status) AS application_num
FROM
    applications
WHERE
    application_status > 5
ORDER by
    status_group DESC;