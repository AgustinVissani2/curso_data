{{
  config(
    materialized='table'
  )
}}

WITH users_snapshot AS 
(
    SELECT * 
    FROM {{ ref('users_snapshot') }}
)

    select     
    user_id,
    first_name,
    last_name,
    address_id,
    phone_number,
    email,
    created_at_date,
    created_at_time_utc,
    updated_at_date,
    updated_at_time_utc,
    _fivetran_synced_utc
    from users_snapshot
    where dbt_valid_to is null