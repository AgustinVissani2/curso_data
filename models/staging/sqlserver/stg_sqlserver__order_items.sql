with
    source as (select * from {{ source("_sqlserver_sources", "order_items") }}),
    src_sqlserver as (
        select
            order_id,
            product_id,
            quantity,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
    )

select *
from src_sqlserver
