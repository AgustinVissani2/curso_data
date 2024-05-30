with users as (
    select * from {{ ref('stg_sqlserver__users') }}
),

addresses as (
    select * from {{ ref('stg_sqlserver__addresses') }}
),

orders as (
    select * from {{ ref('stg_sqlserver__orders') }}
)

select
    o.order_id,
    o.shipping_service_name,
    o.shipping_cost_amount_euro,
    o.created_at,
    o.promo_id,
    o.estimated_delivery_at,
    o.order_cost_euro,
    o.user_id,
    o.order_total_euro,
    o.delivered_at,
    o.tracking_id,
    o.status_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.total_orders,
    a.address,
    a.zipcode,
    a.country,
    a.state
from orders o
left join users u on o.user_id = u.user_id
left join addresses a on u.address_id = a.address_id
