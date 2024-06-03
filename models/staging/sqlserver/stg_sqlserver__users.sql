WITH source AS (
    SELECT * 
    FROM {{ source("_sqlserver_sources", "users") }}
),

src_sqlserver AS (
    SELECT
        user_id,
        first_name,
        last_name,
        address_id,
        phone_number,
        COALESCE(
            REGEXP_LIKE(phone_number, '^[0-9]{3}-[0-9]{3}-[0-9]{4}$') = true,
            false
        ) AS is_valid_phone_number,
        email,
        COALESCE(
            REGEXP_LIKE(
                email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
            ) = true,
            false
        ) AS is_valid_email_address,
        total_orders,
        created_at,
        updated_at,
        _fivetran_deleted,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS _fivetran_synced_utc
    FROM source
    WHERE _fivetran_deleted IS NULL

    UNION ALL

    SELECT
        md5('no_user') AS user_id,
        'no_exist' AS first_name,
        'no_exist' AS last_name,
        md5('no_address') AS address_id,
        '000-000-0000' AS phone_number,
        true AS is_valid_phone_number,
        'noexist@gmail.com' AS email,  
        COALESCE(
            REGEXP_LIKE('noexist@gmail.com', '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$') = true,
            false
        ) AS is_valid_email_address,
        0 AS total_orders,
        NULL::timestamp AS created_at,
        NULL::timestamp AS updated_at,
        NULL::boolean AS _fivetran_deleted,
        NULL::timestamp AS _fivetran_synced_utc
)

SELECT *
FROM src_sqlserver
