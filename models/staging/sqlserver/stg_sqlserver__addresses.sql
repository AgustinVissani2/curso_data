with
    source as (select * from {{ source("_sqlserver_sources", "addresses") }}),
    src_sqlserver as (
        select
            address_id,
            zipcode,
            country,
            address,
            state,
            _fivetran_deleted  as date_deleted,
            _fivetran_synced as date_load
        from source
    )

select *
from src_sqlserver
