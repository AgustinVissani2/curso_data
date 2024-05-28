with
    source as (select * from {{ source("_sqlserver_sources", "addresses") }}),
    src_sqlserver as (
        select
            address_id,
            zipcode,
            country,
            address,
            state,
            _fivetran_deleted as _fivetran_deleted,  
            _fivetran_synced as _fivetran_synced  
        from source
    )

select *
from src_sqlserver
