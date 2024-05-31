with
    source as (select * from {{ ref("base_sqlserver__orders") }}),
    src_sqlserver as (
        select
            order_id,
            md5(iff(shipping_service_name = '','Unknown', shipping_service_name) )as shipping_service_name,
            shipping_cost_amount_euro,
            address_id,
            created_at,
            promo_id,
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
    )

select *
from src_sqlserver

