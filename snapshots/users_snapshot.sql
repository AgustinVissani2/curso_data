{% snapshot users_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='_fivetran_synced_utc',
      check_cols=['quantity'],
      invalidate_hard_deletes=True,
    )
}}

select * from {{ source('_sqlserver_sources', 'users') }}

{% endsnapshot %}