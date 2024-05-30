with
    source as (select * from {{ ref("stg_sqlserver__orders") }}),
    src_sqlserver as (
        select
            order_id,
            shipping_service_name,
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
            status_name,
            status_id,
            _fivetran_deleted,
            _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select
    src_sqlserver.*,
    dim_time.*
from src_sqlserver
cross join {{ ref('dim_time') }} as dim_time
