-- Description
-- You need to create a function that calculates the number of weekdays (Monday through Friday) between two dates 
-- inclusively.
-- The function should be named weekdays accept two arguments of type DATE and return an INTEGER value.
-- weekdays(DATE, DATE) INTEGER
-- The order of arguments shouldn't matter. To illustrate both of the following queries
-- SELECT weekdays('2016-01-01', '2016-01-10');
-- SELECT weekdays('2016-01-10', '2016-01-01');
-- should produce the same result
--  weekdays
-- ----------
--         6
-- (1 row)

CREATE OR REPLACE FUNCTION weekdays(date1 DATE, date2 DATE)
RETURNS INTEGER AS $$
DECLARE
    start_date DATE;
    end_date DATE;
    total_days INTEGER;
    full_weeks INTEGER;
    extra_days INTEGER;
    i INTEGER;
    current_day DATE;
    weekday_count INTEGER := 0;
BEGIN
    IF date1 <= date2 THEN
        start_date := date1;
        end_date := date2;
    ELSE
        start_date := date2;
        end_date := date1;
    END IF;
    
    total_days := end_date - start_date + 1;
    
    full_weeks := total_days / 7;
    weekday_count := full_weeks * 5;
    
    extra_days := total_days % 7;
    
    FOR i IN 0..extra_days - 1 LOOP
        current_day := start_date + (full_weeks * 7) + i;
        IF EXTRACT(DOW FROM current_day) BETWEEN 1 AND 5 THEN
            weekday_count := weekday_count + 1;
        END IF;
    END LOOP;

    RETURN weekday_count;
END;
$$ LANGUAGE plpgsql;