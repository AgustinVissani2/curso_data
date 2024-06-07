with
    source as (
        select * from {{ source("_sqlserver_sources", "orders") }}
    ),
    src_sqlserver as (
        select
            order_id,
            case
                when shipping_service is null or shipping_service = '' then 'unknown' 
                else lower(shipping_service)
            end as shipping_service_name,
            shipping_cost as shipping_cost_amount_usd,
            address_id,
            convert_timezone('UTC', created_at) as created_at_utc,
            case
                when promo_id is null or promo_id = '' then 'unknown' 
                else {{ normalize_promo_name('promo_id') }}
            end as promo_id,
            convert_timezone('UTC', estimated_delivery_at) as estimated_delivery_at_utc,
            order_cost as order_cost_usd,
            user_id,
            order_total as order_total_usd,
            convert_timezone('UTC', delivered_at) as delivered_at_utc,
            tracking_id,
            case
                when status is null or status = '' then 'unknown' 
                else lower(status)
            end as status,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )
select *
from src_sqlserver
