with
    source as (select * from {{  source("_sqlserver_sources", "events") }}),
    src_sqlserver as (
        select
            event_id,
            page_url,
            event_type,
            user_id,
            product_id,
            session_id,
            created_at,
            order_id,
            _fivetran_deleted  as date_deleted,
            _fivetran_synced as date_load
        from source
    )

select *
from src_sqlserver
