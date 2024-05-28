{{ config(materialized="view") }}

with
    src_sqlserver as (
        select
            order_id,
            shipping_service,
            shipping_cost,
            address_id,
            created_at,
            coalesce(promo_id, 'No value') as promo_id,
            coalesce(estimated_delivery_at, null) as estimated_delivery_at,
            order_cost,
            user_id,
            order_total,
            delivered_at,
            tracking_id,
            status,
            coalesce(_fivetran_deleted, false) as _fivetran_deleted,
            coalesce(_fivetran_synced, null) as _fivetran_synced
        from {{ source("_sqlserver_sources", "orders") }}
    )

select *
from src_sqlserver
