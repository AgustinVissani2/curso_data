{{
  config(
    materialized='table'
  )
}}

with

source_order_items as (
    select * from {{ ref('stg_sqlserver__order_items') }}
),

source_orders as (
    select * from {{ ref('stg_sqlserver__orders') }}
),

join_order_Ordersitems as (
    select
        i.order_id,
        o.user_id,
        o.shipping_service_id,
        o.shipping_cost_amount_usd,
        o.address_id,
        o.tracking_id,
        o.promo_id,
        o.order_total_usd,
        i.product_id,
        i.quantity,
        o.created_at_date,
        o.created_at_time_utc,
        o.estimated_delivery_at_date,
        o.estimated_delivery_at_time_utc,
        o.delivered_at_date,
        o.delivered_at_time_utc,
    from source_orders as o
    inner join source_order_items as i
        on o.order_id = i.order_id
    group by all
)

select * from join_order_Ordersitems

