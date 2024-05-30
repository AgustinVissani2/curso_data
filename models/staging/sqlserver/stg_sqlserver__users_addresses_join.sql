with
    addresses_source as (select * from {{ ref("stg_sqlserver__addresses") }}),
    users_source as (select * from {{ ref("stg_sqlserver__users") }}),
    addresses_src_sqlserver as (
        select
            a.address_id as address_id,
            zipcode,
            country,
            address,
            state,
            _fivetran_deleted,
            _fivetran_synced_utc
        from addresses_source a
    ),
    users_src_sqlserver as (
        select
            u.user_id,
            u.first_name,
            u.last_name,
            a.zipcode,
            a.country,
            a.address,
            a.state,
            u.phone_number,
        from users_source u
        left join addresses_src_sqlserver a on u.address_id = a.address_id
        where u._fivetran_deleted is null and a._fivetran_deleted is null
    )

select *
from users_src_sqlserver
