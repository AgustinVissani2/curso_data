with
    source as (select * from {{ source("_sqlserver_sources", "events") }}),
    src_sqlserver as (
        select
            event_id,
            page_url,
            event_type, -- event type dim? 
            user_id,
            COALESCE({{ dbt_utils.generate_surrogate_key(['product_id'])}}, 'no-product') AS product_id,
            session_id,
            created_at,
            COALESCE({{ dbt_utils.generate_surrogate_key(['order_id'])}}, 'no-order') AS order_id,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
