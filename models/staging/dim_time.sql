
WITH dates AS (
    SELECT
        CAST(date_trunc('day', dateadd('day', seq4() )) AS DATE) AS date_day
    FROM
        table(generator(rowcount => 365 * 3)) 
),
time_dimension AS (
select
    date
    ,extract(year from date) as year
    ,extract(month from date) as month
    ,monthname(date) as month_name
    ,extract(day from date) as day
    ,extract(dayofweek from date) as number_week_day
    ,dayname(date) as week_day
    ,extract(quarter from date) as quarter
from dates
)
SELECT
    *
FROM
    time_dimension