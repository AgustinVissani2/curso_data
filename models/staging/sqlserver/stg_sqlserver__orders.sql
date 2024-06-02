with
source as (select * from {{ ref("base_sqlserver__orders") }}),

src_sqlserver as (
    select
        order_id,
        shipping_service_name,
        shipping_cost_amount_euro,
        address_id,
        created_at,
        md5(promo_id) as promo_id,
        estimated_delivery_at,
        order_cost_euro,
        user_id,
        order_total_euro,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced_utc
    from source
    where _fivetran_deleted is null
),

shipping_service_normalized as (
    select distinct
        shipping_service_name,
        md5(shipping_service_name) as shipping_service_id
    from src_sqlserver
),

status_normalized as (
    select distinct
        status,
        md5(status) as status_id
    from src_sqlserver
),

orders_normalized as (
    select
        o.order_id,
        ssn.shipping_service_id,
        o.shipping_cost_amount_euro,
        o.address_id,
        o.created_at,
        o.promo_id,
        o.estimated_delivery_at,
        o.order_cost_euro,
        o.user_id,
        o.order_total_euro,
        o.delivered_at,
        o.tracking_id,
        sn.status_id,
        o._fivetran_deleted,
        o._fivetran_synced_utc
    from src_sqlserver o
    left join shipping_service_normalized ssn
        on o.shipping_service_name = ssn.shipping_service_name
    left join status_normalized sn
        on o.status = sn.status
)

select * from orders_normalized