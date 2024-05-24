{{ config(materialized="view") }}

with
    src_sqlserver as (select * from {{ source("_sqlserver_sources", "addresses") }}),

    renamed_casted as (
        select
            address_id,
            zipcode,
            country,
            address,
            state,
            _FIVETRAN_DELETED as date_deleted,
            _fivetran_synced as date_load
        from src_sqlserver
    )

select *
from renamed_casted
