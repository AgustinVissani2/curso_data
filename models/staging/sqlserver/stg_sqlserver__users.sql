with
    source as (select * from {{ source("_sqlserver_sources", "users") }}),
    src_sqlserver as (
        select
            user_id,
            first_name,
            last_name,
            address_id,
            phone_number,
            coalesce(
                regexp_like(phone_number, '^[0-9]{3}-[0-9]{3}-[0-9]{4}$') = true,
                false
            ) as is_valid_phone_number,
            email,
            coalesce(
                regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
                = true,
                false
            ) as is_valid_email_address,
            total_orders,
            created_at,
            updated_at,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
    )

select *
from src_sqlserver
