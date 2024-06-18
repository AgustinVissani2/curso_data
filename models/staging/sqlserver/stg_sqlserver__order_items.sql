{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail'
  )
}}

with
    source as (select * from {{ ref("orders_items_snapshot") }}),
    src_sqlserver as (
        select
            order_id,
            {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id,
            quantity,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc,
            dbt_valid_to
        from source
    {% if is_incremental() %}
      where  _fivetran_synced_utc > (select max(_fivetran_synced_utc) from {{ this }})
    {% endif %}
    )

select *
from src_sqlserver
WHERE dbt_valid_to IS NULL