with
    source as (select * from {{ source("_sqlserver_sources", "users") }}),
    src_sqlserver as (
        select
            user_id,
            updated_at,
            address_id,
            last_name,
            created_at,
            phone_number,
            total_orders,
            first_name,
            email,
            _fivetran_deleted = 'true' as _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
