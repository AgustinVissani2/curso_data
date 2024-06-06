{{ config(
    materialized='table'
    ) 
}}

WITH dim_users AS (
    SELECT  DISTINCT *
    FROM {{ ref('stg_sqlserver__users') }}
)

SELECT
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
FROM dim_users
