with
    source as (select * from {{ ref("base_sqlserver__promos") }}),

    src_sqlserver as (
        select
            md5(promo_name) as promo_id,
            promo_name,
            discount_euro,
            iff(status = 'inactive', 0, 1) as status,
            _fivetran_deleted,
            _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
