{{
  config(
    materialized='table'
  )
}}

with 

events_per_user as (
    select * from {{ ref('int_events_per_user') }}
)

select * from events_per_user