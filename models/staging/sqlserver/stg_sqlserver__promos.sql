with
    source as (select * from {{ ref("base_sqlserver__promos") }}),

    src_sqlserver as (
        select
            {{ dbt_utils.generate_surrogate_key(['promo_name']) }} AS promo_id,
            promo_name,
            discount_usd,
            status,
            status_id,
            _fivetran_deleted,
            _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    ),

    status_normalized as (
        select distinct
        status,
        iff(status = 'inactive', 0, 1) as status_id
        from src_sqlserver
    ),

promos_normalized as (
    select
            o.promo_id,
            o.promo_name,
            o.discount_usd,
            sn.status_id,
            sn.status,
            o._fivetran_deleted,
            o._fivetran_synced_utc
    from src_sqlserver as o
    left join status_normalized as sn
        on o.status = sn.status
)

select * from promos_normalized
