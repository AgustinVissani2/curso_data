{% snapshot users_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='timestamp',
      updated_at='_fivetran_synced_utc'
    )
}}



WITH distinct_stg_users AS
(
    SELECT DISTINCT(user_id)
    FROM {{ ref('stg_sqlserver__events') }}
),

distinct_stg_events AS 
(
    SELECT DISTINCT(user_id)
    FROM {{ ref('stg_sqlserver__events') }}
),

distinct_stg_orders AS 
(
    SELECT DISTINCT(user_id)
    FROM {{ ref('stg_sqlserver__orders') }}
),

union_all_with_duplicates AS 
(
    SELECT *
    FROM distinct_stg_users
    UNION ALL
    SELECT *
    FROM distinct_stg_events
    UNION ALL
    SELECT *
    FROM distinct_stg_orders
),

removing_duplicates AS 
(
    SELECT DISTINCT(user_id)
    FROM union_all_with_duplicates
)

SELECT *
FROM removing_duplicates
FULL JOIN
{{ ref('stg_sqlserver__users') }} AS users
USING (user_id)

{% endsnapshot %}