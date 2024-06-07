{{ config(materialized='view') }}

with

order_items as (
    select * from {{ ref('stg_sqlserver__order_items') }}
),

orders as (
    select * from {{ ref('stg_sqlserver__orders') }}
),


fct_orders as (
    select
        o.order_id,
        o.shipping_service_id,
        o.shipping_cost_amount_usd,
        o.shipping_cost_amount_usd / COUNT(o.order_id) over (partition by o.order_id order by o.order_id) as shipping_cost_product,
        o.address_id,
        o.tracking_id,
        o.created_at_utc,
        o.promo_id,
        o.estimated_delivery_at_utc,
        o.order_cost_usd,
        o.user_id,
        o.order_total_usd,
        o.delivered_at_utc,
        o.status_id,
        u.product_id,
        u.quantity,


    from orders as o
    JOIN order_items as u
        on o.order_id = u.order_id
    ORDER by order_id

)

select * from fct_orders

