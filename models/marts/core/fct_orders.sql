{{ config(materialized='view') }}

with

int_orders as (
    select * from {{ ref('int_orders') }}
),

fct_orders as (
    select
        row_,
        order_id,
        user_id,
        shipping_service_id,
        shipping_cost_amount_usd,
        address_id,
        tracking_id,
        promo_id,
        discount_usd,
        product_id,
        price_usd,
        quantity,
        cost_per_product,
        total_price,
        final_price,
        created_at_utc,
        created_at_month,
        estimated_delivery_at_utc,
        delivered_at_utc
    from int_orders as io
)

select * from fct_orders

