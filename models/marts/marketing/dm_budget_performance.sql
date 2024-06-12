WITH budgets AS (
    SELECT * 
    FROM {{ref('fct_budget')}}
),

products AS (
    SELECT * 
    FROM {{ref('dim_products')}}
),

budget_details AS (
    SELECT
        b.budget_id,
        b.product_id,
        p.product_name,
        p.price_usd,
        b.quantity_sold_expected,
    FROM budgets b
    LEFT JOIN products p ON b.product_id = p.product_id

    GROUP BY all
),

budget_user_details AS (
    SELECT
        bd.budget_id,
        bd.product_id,
        bd.product_name,
        bd.price_usd,
        bd.quantity_sold_expected,
        (price_usd * quantity_sold_expected) as  expected_sales_usd
    FROM budget_details bd
)

SELECT DISTINCT
   *
FROM budget_user_details
