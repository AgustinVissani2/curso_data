{{
  config(
    materialized='view'
  )
}}

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
        o.address_id,
        o.tracking_id,
        o.created_at,
        o.promo_id,
        o.estimated_delivery_at,
        o.order_cost_usd,
        o.user_id,
        o.order_total_usd,
        o.delivered_at,
        o.status_id,
        u.product_id,
        u.quantity,


    from orders as o
    left join order_items as u on o.order_id = u.order_id

)

select * from fct_orders
