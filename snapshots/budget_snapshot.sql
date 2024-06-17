{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='budget_id',
      strategy='timestamp',
      updated_at='_fivetran_synced_utc',
    )
}}

select *  FROM {{ ref('stg_google_sheets__budget') }}


{% endsnapshot %}