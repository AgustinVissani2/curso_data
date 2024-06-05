{{ config(
    materialized='table'
    ) 
}}

WITH stg_addresses AS (
    SELECT DISTINCT *
    FROM {{ ref('stg_sqlserver__addresses') }}
)

SELECT *
FROM stg_addresses
