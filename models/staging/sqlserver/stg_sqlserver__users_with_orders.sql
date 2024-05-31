with
    source as (
        select
            user_id,
            first_name,
            last_name,
            address_id,
            phone_number,
            is_valid_phone_number,
            email,
            is_valid_email_address,
            created_at,
            updated_at,
            _fivetran_synced_utc
        from {{ ref("stg_sqlserver__users") }}
        where _fivetran_deleted is null
    )

select
    s.user_id,
    s.first_name,
    s.last_name,
    s.address_id,
    s.phone_number,
    s.is_valid_phone_number,
    s.email,
    s.is_valid_email_address,
    coalesce(o.total_orders, 0) as total_orders,
    s.created_at,
    s.updated_at,
    s._fivetran_synced_utc
from source s
left join
    (
        select user_id, count(*) as total_orders 
        from {{ ref("stg_sqlserver__orders") }}
        where _fivetran_deleted is null
        group by user_id
    ) o
    on s.user_id = o.user_id
