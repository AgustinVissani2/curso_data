with
    source as (
        select * from {{ source("_sqlserver_sources", "promos") }}
    ),
    src_sqlserver as (
        select
            md5(promo_id) as promo_id,
            promo_id as promo_name,
            discount as discount_euro,
            iff(status = 'inactive', 0, 1) as status_id,
            status,
            _fivetran_deleted as _fivetran_deleted,
            _fivetran_synced,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc  
        from source
        union all
        select
            md5('Stranger') as promo_id,
            'Stranger' as promo_name,
            0 as discount_euro,
            0 as status_id,
            'inactive' as status,
            null as _fivetran_deleted,
            null as _fivetran_synced_utc,
            null as _fivetran_synced  
    )

select *
from src_sqlserver
