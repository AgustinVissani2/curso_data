{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='_row',
      strategy='check',
      check_cols=['quantity'],
        )
}}

select * from {{ source('_google_sheets__sources', 'budget') }}

{% endsnapshot %}