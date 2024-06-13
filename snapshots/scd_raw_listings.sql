{% snapshot scd_raw_listings %}
    {{
        config(
            target_schema='DEV',
            target_database='AIRBNB',
            unique_key='ID',
            strategy='timestamp',
            invalidate_hard_deletes=True,
            updated_at='UPDATED_AT'
        )
    }}

    select * from {{ source('airbnb', 'listings') }}
 {% endsnapshot %}