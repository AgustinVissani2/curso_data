with
    source as (select * from {{ source("_sqlserver_sources", "events") }}),
    src_sqlserver as (
        select
            event_id,
            page_url,
            event_type,
            user_id,
            iff(product_id = '', null,  product_id) as product_id,
            session_id,
            created_at,
            iff(order_id = '', null,  order_id) as order_id,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
