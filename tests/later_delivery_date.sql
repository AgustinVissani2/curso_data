SELECT *
FROM {{ ref('stg_sqlserver__orders') }}
WHERE delivered_at_utc < created_at_utc
-- checks if there is any case where the delivery date is earlier than the date the order was placed, which would not make logical sense and would indicate some kind of problem with the data 