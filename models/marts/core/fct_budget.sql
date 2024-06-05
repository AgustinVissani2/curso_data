{{ config(
    materialized='table'
    ) 
}}

WITH fct_budget AS (
    SELECT DISTINCT *
    FROM {{ ref('stg_google_sheets__budget') }}
)

SELECT
    *
FROM fct_budget
