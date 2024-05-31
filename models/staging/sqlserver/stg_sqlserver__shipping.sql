with
source as (select * from {{ ref("base_sqlserver__orders") }}),

src_sqlserver as (
    select distinct
        md5(shipping_service_name) as shipping_id,
        case
            when
                shipping_service_name is null
                or shipping_service_name = ''
                or shipping_service_name = 'No value'
            then 'Unknown'
            else shipping_service_name
        end as shipping_service_name
    from source

)

select *
from src_sqlserver
