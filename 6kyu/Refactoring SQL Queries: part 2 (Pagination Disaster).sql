-- Description
-- A financial analysis platform is facing an issue with its current database query logic. The platform, which provides 
-- insights into various financial deals and their associated financial tranches, was developed to help clients analyze 
-- deal performance across different currencies. Initially, a developer wrote an SQL query to aggregate transaction amounts
-- by both deal and currency. This query worked well for the primary use case of showing aggregated data per deal per currency.
-- However, a recent bug report from a major client highlighted a critical issue: when viewing the deal summaries with 
-- pagination, the currency data for a single deal could span multiple pages. This issue arose because the pagination was 
-- breaking up the data for a single deal across different pages due to the grouping by both deal and currency. As a result, 
-- clients couldn't view a complete summary of a deal on a single page, leading to confusion and inefficiency.
-- The client's requirement is to have each page display complete information for each deal, irrespective of the number of 
-- currencies involved. Therefore, the task is to refactor the SQL query to ensure that pagination is based solely on deals, 
-- not on the currency breakdowns within those deals.
-- The original query written by the previous developer is as follows:
-- select deals.deal_id, deals.deal_name, tranches.currency, sum(tranches.amount) as total_amount
-- from deals
-- join tranches using (deal_id)
-- group by deals.deal_id, tranches.currency
-- order by deals.deal_id desc, tranches.currency;
-- Your task is to refactor this query to meet the client's requirements. The refactored query should group the data only 
-- by deal, not by currency, to allow for proper pagination. Each deal should present an aggregated summary of the tranches 
-- across different currencies. We need to aggregate currency details into a JSON array, which can then be handled in the 
-- programming layer of the platform.
-- Expected Outcome:
-- The refactored query should return each deal's ID and name, along with a JSON array of currency details (each currency 
-- and its total amount).
-- Ensure that the currency details are consistently ordered (by currency in ascending order).
-- The pagination should be based on deals, ensuring that each deal's information, regardless of how many currencies are 
-- involved, is displayed completely on one page.
-- We have deals table:
-- deal_id (integer, primary key): Unique identifier for each deal.
-- deal_name (string): Name of the deal.
-- and tranches table:
-- id (integer, primary key): Unique identifier for each tranche record.
-- deal_id (integer, foreign key): references deal_id in the deals table. Indicates which deal this tranche belongs to.
-- currency (string): Currency of the tranche (e.g., USD, EUR).
-- amount (float): Amount of money in the tranche in its specified currency.
-- The resultant set should include:
-- deal_id (integer): The unique identifier for each deal.
-- deal_name (string): The name of the deal.
-- currency_details (JSON Array): A JSON array ordered by currency in ascending order where each element is a JSON object 
-- containing:
-- currency (string): The currency of the tranches.
-- total_amount (float): Total amount aggregated for this currency.
-- Result should be ordered by deal_id in descending order.
-- For this sample data:
-- deals: 
-- | deal_id | deal_name |
-- +---------+-----------+
-- |       1 | Deal A    |
-- |       2 | Deal B    |
-- tranches: 
-- | id | deal_id | currency | amount |
-- +----+---------+----------+--------+
-- |  1 |       1 | USD      | 1000.0 |
-- |  2 |       1 | EUR      |  800.0 |
-- |  3 |       1 | EUR      |  400.0 |
-- |  4 |       2 | USD      |  500.0 |
-- |  5 |       2 | GBP      |  600.0 |
-- the desired output is the following:
-- deal_id	deal_name	currency_details
-- 2	    Deal B	    [{"currency" : "GBP", "total_amount" : 600}, {"currency" : "USD", "total_amount" : 500}]
-- 1	    Deal A	    [{"currency" : "EUR", "total_amount" : 1200}, {"currency" : "USD", "total_amount" : 1000}]
SELECT
    deal_id,
    deal_name,
    json_agg (
        currency
        ORDER BY
            currency - > > 'currency'
    ) AS currency_details
FROM
    (
        SELECT
            deals.deal_id,
            deals.deal_name,
            json_build_object (
                'currency',
                tranches.currency,
                'total_amount',
                SUM(tranches.amount)
            ) AS currency
        FROM
            deals
            JOIN tranches USING (deal_id)
        GROUP BY
            deals.deal_id,
            deals.deal_name,
            tranches.currency
    ) w
GROUP BY
    deal_id,
    deal_name
ORDER BY
    deal_id DESC;