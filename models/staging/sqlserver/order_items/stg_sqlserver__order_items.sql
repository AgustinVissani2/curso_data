{{ config(materialized="view") }}

with
    src_sqlserver as (
        select
            ORDER_ID,
            PRODUCT_ID,
            QUANTITY,
            COALESCE(_FIVETRAN_DELETED, false) as _FIVETRAN_DELETED,
            COALESCE(_FIVETRAN_SYNCED, null) as _FIVETRAN_SYNCED
        from {{ source('_sqlserver_sources', 'order_items') }}
    )

select *
from src_sqlserver