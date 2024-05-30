with
    ventas_virginia as (
        select order_total_euro
        from {{ ref("stg_sqlserver__users_addresses_orders_join") }}
        where state = 'Virginia' and zipcode = '23605' and status_name = 'delivered'
    )

select sum(order_total_euro) as total_ventas_virginia
from ventas_virginia
