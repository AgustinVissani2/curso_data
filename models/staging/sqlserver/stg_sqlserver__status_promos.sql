with
source as (select * from {{ ref("base_sqlserver__promos") }}),

src_sqlserver as (
    select distinct
        status_id,
        status
    from source
)

select *
from src_sqlserver
