with
source as (select * from {{ ref("base_sqlserver__orders") }}),

src_sqlserver as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['status']) }} AS status_id,
        status
    from source
)

select *
from src_sqlserver
