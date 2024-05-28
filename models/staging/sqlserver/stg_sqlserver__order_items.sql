with
    source as (select * from {{ source("_sqlserver_sources", "order_items") }}),
    src_sqlserver as (
        select
            order_id,
            product_id,
            quantity,
            _fivetran_deleted as _fivetran_deleted,  
            _fivetran_synced as _fivetran_synced  
        from source
    )

select *
from src_sqlserver
