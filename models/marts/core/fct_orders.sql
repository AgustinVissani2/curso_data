with users as (
    select * from {{ ref('stg_sqlserver__product') }}
),

addresses as (
    select * from {{ ref('stg_sqlserver__order_items') }}
),

orders as (
    select * from {{ ref('stg_sqlserver__orders') }}
)

select
    o.order_id,
    o.shipping_service_name,
    o.shipping_cost_amount_usd,
    o.created_at,
    o.promo_id,
    o.estimated_delivery_at,
    o.order_cost_usd,
    o.user_id,
    o.order_total_usd,
    o.delivered_at,
    o.tracking_id,
    o.status_id,
    u.product_id,
    u.quantity,
   


from orders as o
left join stg_sqlserver__order_items as u on o.order_id = u.order_id
left join stg_sqlserver__product as p on u.product_id = p.product_id
