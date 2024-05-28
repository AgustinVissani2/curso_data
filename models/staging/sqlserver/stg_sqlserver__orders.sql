with
    source as (select * from {{ source("_sqlserver_sources", "orders") }}),
    src_sqlserver as (
        select
            order_id,
            shipping_service,
            shipping_cost,
            address_id,
            created_at,
            iff(promo_id = '', 'Stranger', md5(promo_id)) as promo_id, 
            estimated_delivery_at,
            order_cost,
            user_id,
            order_total,
            delivered_at,
            tracking_id as tracking_id,
            status,
            _fivetran_deleted as _fivetran_deleted,  
            _fivetran_synced as _fivetran_synced  
        from source
        where _fivetran_deleted is null 
    )

select *
from src_sqlserver
