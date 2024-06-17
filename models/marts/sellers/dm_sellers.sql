{{
  config(
    materialized='table'
  )
}}

WITH dim_sellers AS (
    SELECT
        sellers_id,
        first_name,
        last_name,
        salary AS fixed_salary,
        commission,
        date_load
    FROM {{ ref("dim_sellers") }}
),

fact_order AS (
    SELECT
        order_item_id,
        price_total_order_item_usd,
        sellers_id
    FROM {{ ref("fct_orders") }}
)

SELECT
    sellers_id,
    first_name,
    last_name,
    commission AS commission_prc,
    date_load AS date,
    COUNT(DISTINCT order_item_id) AS total_order_sellers,
    SUM(price_total_order_item_usd) AS total_sales_sellers,
    (commission / 100)
    * total_sales_sellers::decimal(7, 1) AS total_benefits_commission,
    fixed_salary + total_benefits_commission AS current_salary
FROM dim_sellers
INNER JOIN fact_order_items
    ON dim_sellers.sellers_id = fact_order_items.sellers_id
GROUP BY
    sellers_id,
    first_name,
    last_name,
    commission,
    date_load,
    fixed_salary
