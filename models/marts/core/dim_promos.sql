{{
  config(
    materialized='table'
  )
}}

WITH stg_sqlserver__promos AS (
    SELECT *
    FROM {{ ref('stg_sqlserver__promos') }}
)

SELECT *
FROM stg_sqlserver__promos