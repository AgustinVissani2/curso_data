{{ config(materialized="view") }}

with
    src_sqlserver as (
        select
            ORDER_ID,
            SHIPPING_SERVICE,
            SHIPPING_COST,
            ADDRESS_ID,
            CREATED_AT,
            COALESCE(PROMO_ID, 'No value') as PROMO_ID,
            COALESCE(ESTIMATED_DELIVERY_AT, null) as ESTIMATED_DELIVERY_AT,
            ORDER_COST,
            USER_ID,
            ORDER_TOTAL,
            DELIVERED_AT,
            TRACKING_ID,
            STATUS,
            COALESCE(_FIVETRAN_DELETED, false) as _FIVETRAN_DELETED,
            COALESCE(_FIVETRAN_SYNCED, null) as _FIVETRAN_SYNCED
        from {{ source('_sqlserver_sources', 'orders') }}
    )

select *
from src_sqlserver
