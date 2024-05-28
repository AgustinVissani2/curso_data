{{ config(materialized="view") }}

with
    src_budget as (select * from {{ source("_google_sheets__sources", "budget") }}),

    renamed_casted as (
        select
            _row,
            product_id,
            quantity,
            month,
            coalesce(_fivetran_synced, null) as date_load
        from src_budget
    )

select *
from renamed_casted
