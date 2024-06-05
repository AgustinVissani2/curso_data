with
source as (select * from {{ ref("base_sqlserver__orders") }}),

src_sqlserver as (
    select
        order_id,
        shipping_service_name,
        {{ dbt_utils.generate_surrogate_key(['shipping_service_name'])}} AS shipping_service_id,
        shipping_cost_amount_usd,
        {{ dbt_utils.generate_surrogate_key(['address_id'])}} AS address_id,
        created_at,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id,
        estimated_delivery_at,
        order_cost_usd,
        user_id,
        order_total_usd,
        delivered_at,
        tracking_id,
        status,
        {{ dbt_utils.generate_surrogate_key(['status'])}} AS status_id,
        _fivetran_deleted,
        _fivetran_synced_utc
    from source
    where _fivetran_deleted is null
)

select * from src_sqlserver