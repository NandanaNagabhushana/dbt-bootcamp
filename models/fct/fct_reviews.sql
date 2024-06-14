{{
    config(
        materialized='incremental',
        on_schema_change='fail'
    )
}}
WITH src_reviews AS (
SELECT * FROM {{ ref('src_reviews') }}
)
SELECT 
{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name']) }} as review_id,
* FROM src_reviews
WHERE review_text is not null
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    AND review_date > (select max(review_date) from {{this}})
{% endif %}
