with
    dates as (
        select
            cast(
                date_trunc('day', dateadd('day', seq4(), '2023-11-11')) as date
            ) as date_day
        from table(generator(rowcount => 365 * 3))
    ),
    time_dimension as (
        select
            date_day,
            extract(year from date_day) as year,
            extract(month from date_day) as month,
            monthname(date_day) as month_name,
            extract(day from date_day) as day,
            extract(dayofweek from date_day) as number_week_day,
            dayname(date_day) as week_day,
            extract(quarter from date_day) as quarter
        from dates
    )
select *
from time_dimension
