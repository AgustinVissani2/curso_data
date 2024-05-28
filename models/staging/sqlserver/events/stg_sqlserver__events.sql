{{ config(materialized="view") }}

with
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
            coalesce(_fivetran_deleted, false) as _fivetran_deleted,
            coalesce(_fivetran_synced, null) as _fivetran_synced
        from {{ source("_sqlserver_sources", "events") }}
    )

select *
from src_sqlserver