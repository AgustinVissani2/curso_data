with
    source as (select * from {{ ref("base_sqlserver__promos") }}),

    src_sqlserver as (
        select
            {{ dbt_utils.generate_surrogate_key(['promo_name']) }} AS promo_id,
            promo_name,
            discount_euro,
            status_id,
            _fivetran_deleted,
            _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
