{{ config(
    materialized='table'
    ) 
}}

with stg_addresses AS 
(
    SELECT DISTINCT *
    FROM {{ ref('stg_sqlserver__addresses') }}
)

SELECT
    *
from stg_addresses