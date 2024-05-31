with
    source as (select * from {{ source("_sqlserver_sources", "addresses") }}),
    src_sqlserver as (
        select
            address_id,
            zipcode,
            country,
            address,
            state,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
