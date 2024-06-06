{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select * from {{ ref('stg_sqlserver__events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type_id,
        user_id,
        product_id,
        session_id,
        created_at,
        order_id,

    from source

)

select * from renamed