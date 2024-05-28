{{ config(materialized="view") }}

with
    src_sqlserver as (
        select
            address_id,
            zipcode,
            country,
            address,
            state,
            coalesce(_fivetran_deleted, false) as date_deleted,
            coalesce(_fivetran_synced, null) as date_load
        from {{ source("_sqlserver_sources", "addresses") }}
    )

select *
from src_sqlserver
