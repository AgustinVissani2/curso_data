with
source as (select * from {{ ref("base_sqlserver__orders") }}),

src_sqlserver as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['shipping_service_name']) }} AS shipping_id,
        shipping_service_name
    from source
)

select *
from src_sqlserver
