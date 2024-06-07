with
    source as (
        select * from {{ source("_sqlserver_sources", "products") }}
    ),
    src_sqlserver as (
        select
            product_id,
            name as product_name,
            price as price_usd,
            inventory,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null

        union all

        select
           
           'No products' AS product_id,
            'No products' as product_name,
            0 as price_usd,
            '0' AS inventory,
            null AS _fivetran_deleted,
            null AS _fivetran_synced_utc
    )
    select   
        product_id,
        product_name,
        price_usd,
        inventory,
        _fivetran_deleted,
        _fivetran_synced_utc
            
    from src_sqlserver
