with

fct_orders as (

    select * from {{ ref('fct_orders') }}

),

dim_users as (

    select * from {{ ref('dim_users') }}

),

dim_promos as (

    select * from {{ ref('dim_promos') }}

),

dim_addresses as (

    select * from {{ ref('dim_addresses') }}

),

dm_marketing as (

    select
        o.user_id,
        u.first_name,
        u.last_name,
        u.email,
        u.phone_number,
        u.created_at_time_utc,
        u.updated_at_time_utc,
        a.address,
        a.zipcode,
        a.state,
        a.country,
        count(distinct order_id) as total_num_orders,
        sum(order_total_usd) as total_orders_cost_usd,
        sum(shipping_cost_amount_usd) as total_shipping_cost_usd,
        sum(pr.discount_usd) as total_discount_usd,
        sum(quantity) as total_quantity_products,
        count(distinct product_id) as total_different_products


    from fct_orders as o
    inner join dim_users as u
        on o.user_id = u.user_id
    inner join dim_addresses as a
        on u.address_id = a.address_id
    inner join dim_promos as pr
        on o.promo_id = pr.promo_id
    group by all
)

select * from dm_marketing
