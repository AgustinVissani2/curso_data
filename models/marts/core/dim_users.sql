{{ config(
    materialized='table'
    ) 
}}

WITH dim_users AS (
    SELECT DISTINCT *
    FROM {{ ref('stg_sqlserver__users') }}
)

SELECT
    USER_ID,
    FIRST_NAME,
    ADDRESS_ID,
    PHONE_NUMBER,
    EMAIL,
    TOTAL_ORDERS,
    CREATED_AT_DATE,
    CREATED_AT_TIME_UTC,
    UPDATED_AT_DATE,
    UPDATED_AT_TIME_UTC,
    _FIVETRAN_SYNCED_UTC,
FROM dim_users
