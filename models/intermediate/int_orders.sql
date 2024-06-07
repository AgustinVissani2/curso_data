with

source_order_items as (
    select * from {{ ref('stg_sqlserver__order_items') }}
),

source_orders as (
    select * from {{ ref('stg_sqlserver__orders') }}
),

source_products as (
    select * from {{ ref('stg_sqlserver__product') }}
),

source_promos as (
    select * from {{ ref('stg_sqlserver__promos') }}
),

join_order_Ordersitems_products_promo as (
    select
        i.order_id,
        o.user_id,
        o.shipping_service_id,
        o.shipping_cost_amount_usd,
        o.address_id,
        o.tracking_id,
        o.promo_id,
        pr.discount_usd,
        i.product_id,
        p.price_usd,
        i.quantity,
        o.created_at_utc,
        o.created_at_month,
        o.estimated_delivery_at_utc,
        o.delivered_at_utc,
    from source_orders as o
    join source_order_items as i
        on o.order_id = i.order_id
    join source_products as p
        on i.product_id = p.product_id
    join source_promos as pr
        on o.promo_id = pr.promo_id
    order by i.order_id
),

fc as (
    select
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
        (price_usd * quantity) as cost_per_product,
        created_at_utc,
        created_at_month,
        estimated_delivery_at_utc,
        delivered_at_utc
    from join_order_Ordersitems_products_promo
),

sc as (
    select
        ROW_NUMBER() over (partition by order_id order by order_id) as row_,
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
        SUM(cost_per_product) over (partition by order_id) as total_price,
        (total_price - IFF(ROW_ = '1', discount_usd, 0) + IFF(ROW_ = '1', shipping_cost_amount_usd, 0)) AS final_price,
        created_at_utc,
        created_at_month,
        estimated_delivery_at_utc,
        delivered_at_utc
    from fc
)

select * from sc
