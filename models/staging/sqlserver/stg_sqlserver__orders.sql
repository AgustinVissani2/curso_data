with
    source as (select * from {{ source("_sqlserver_sources", "orders") }}),
    src_sqlserver as (
        select
            order_id,
            shipping_service,
            shipping_cost,
            address_id,
            created_at,
            md5(promo_id) as promo_id,
            iff(promo_id = '', 'Stranger', promo_id ) as promo_id,
            estimated_delivery_at,
            order_cost,
            user_id,
            order_total,
            delivered_at,
            tracking_id as tracking_id,
            status,
            _fivetran_deleted  as date_deleted,
            _fivetran_synced as date_load
        from source
    )

select *
from src_sqlserver
