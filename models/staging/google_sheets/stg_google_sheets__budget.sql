with
src_budget as (select * from {{ source("_google_sheets__sources", "budget") }}),

renamed_casted as (
    select
        _row as budget_id,
        product_id,
        quantity as quantity_sold_expected,
        month as "DATE",
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
    from src_budget
)

select *
from renamed_casted
