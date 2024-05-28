with
    source as (select * from {{ source("_sqlserver_sources", "order_items") }}),
    src_sqlserver as (
        select
            order_id,
            product_id,
            quantity,
            _fivetran_deleted  as date_deleted,
            _fivetran_synced as date_load
        from source
    )

select *
from src_sqlserver
