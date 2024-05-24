{{ config(materialized="view") }}

with
    src_budget as (select * from {{ ref("stg_google_sheets__budget") }}),

    renamed_casted as (
        select _row, product_id, quantity, month
        from src_budget
    )

select *
from renamed_casted
