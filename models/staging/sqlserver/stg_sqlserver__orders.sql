with
    source as (select * from {{ source("_sqlserver_sources", "orders") }}),
    src_sqlserver as (
        select
            order_id,
            case
                when
                    shipping_service is null
                    or shipping_service = ''
                    or shipping_service = 'No value'
                then 'unknown'
                else shipping_service
            end as shipping_service_name,
            shipping_cost as shipping_cost_amount_euro,
            address_id,
            convert_timezone('UTC', created_at) as created_at,
            case
                when promo_id is null or promo_id = '' then 'Unknown' else md5(promo_id)
            end as promo_id,
            convert_timezone('UTC', estimated_delivery_at) as estimated_delivery_at,
            order_cost as order_cost_euro,
            user_id,
            order_total as order_total_euro,
            convert_timezone('UTC', delivered_at) as delivered_at,
            tracking_id,
            status as status_name,
            case
                when status_name = 'delivered'
                then 0
                when status_name = 'shipped'
                then 1
                when status_name = 'preparing'
                then 2
                else null
            end as status_id,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver

