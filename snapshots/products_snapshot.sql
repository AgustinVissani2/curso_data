{% snapshot products_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_id',
      strategy='timestamp',
      updated_at='_fivetran_synced_utc',
        )
}}

select *  FROM {{ ref('stg_sqlserver__product') }}


{% endsnapshot %}