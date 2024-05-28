with
    source as (select * from {{ source("_sqlserver_sources", "promos") }}),
    src_sqlserver as (
        select
            md5(promo_id) as promo_id,
            promo_id as promo_name,
            discount as discount_euro,
            status as id_status,
            status,
            _fivetran_deleted  as date_deleted,
            _fivetran_synced as date_load
            from source
    )

select *
from src_sqlserver
