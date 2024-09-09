-- Description
-- monsters table schema id name legs arms characteristics
-- Your task is to turn the numeric columns (arms, legs) into equivalent hexadecimal values.
-- output table schema legs arms
SELECT
    to_hex (legs) as legs,
    to_hex (arms) as arms
FROM
    monsters;