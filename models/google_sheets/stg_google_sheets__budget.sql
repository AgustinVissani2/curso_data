{{ config(materialized="view") }}

with
    src_budget as (select * from {{ source("google_sheets_source", "budget") }}),

    renamed_casted as (
        select _row, product_id, quantity, month, _fivetran_synced as date_load
        from src_budget
    )

select *
from renamed_casted
