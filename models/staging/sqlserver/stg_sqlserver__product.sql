with
    source as (select * from {{ source("_sqlserver_sources", "products") }}),

    src_sqlserver as (
        select
            product_id,
            price as price_euro,
            name as product_name,
            inventory,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
