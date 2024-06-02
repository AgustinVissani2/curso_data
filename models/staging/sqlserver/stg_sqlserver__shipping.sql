with
source as (select * from {{ ref("base_sqlserver__orders") }}),

src_sqlserver as (
    select distinct
        md5(shipping_service_name) as shipping_id,
        shipping_service_name
    from source
)

select *
from src_sqlserver
