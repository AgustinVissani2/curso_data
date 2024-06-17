{% snapshot orders_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='timestamp',
        updated_at='delivery_timestamp' 
    )
}}

-- que tengo que usar en updated_at

WITH fct_orders AS (
    SELECT DISTINCT
        order_id,
        status_id,
        user_id,
        shipping_service_id,
        shipping_cost_amount_usd,
        address_id,
        tracking_id,
        promo_id,
        order_total_usd,
        created_at_date,
        created_at_time_utc,
        estimated_delivery_at_date,
        estimated_delivery_at_time_utc,
        delivered_at_date,
        delivered_at_time_utc,
        TIMESTAMP(delivered_at_date, delivered_at_time_utc) AS delivery_timestamp
    FROM {{ ref('fct_orders') }}
),

dim_status_orders AS (
    SELECT
        status_id,
        status
    FROM {{ ref('dim_status_orders') }}
),

orders_with_status AS (
    SELECT
        f.order_id,
        f.status_id,
        d.status,
        f.user_id,
        f.shipping_service_id,
        f.shipping_cost_amount_usd,
        f.address_id,
        f.tracking_id,
        f.promo_id,
        f.order_total_usd,
        f.created_at_date,
        f.created_at_time_utc,
        f.estimated_delivery_at_date,
        f.estimated_delivery_at_time_utc,
        f.delivered_at_date,
        f.delivered_at_time_utc

    FROM fct_orders f
    LEFT JOIN dim_status_orders d ON f.status_id = d.status_id
)

SELECT *
FROM orders_with_status

{% endsnapshot %}
