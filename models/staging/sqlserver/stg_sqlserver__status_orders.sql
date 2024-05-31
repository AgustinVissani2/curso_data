with
source as (select * from {{ ref("base_sqlserver__orders") }}),

src_sqlserver as (
    select distinct
            md5(status) as status_id,
            status as status_name
    from source
)

select *
from src_sqlserver
