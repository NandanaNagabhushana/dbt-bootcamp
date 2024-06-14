with f_r as (
    select * from {{ ref('fct_reviews') }}
),
d_l as (
    select * from {{ ref('dim_listings_cleansed') }}
)
select f_r.* 
from f_r inner join d_l using (listing_id)
where f_r.review_date < d_l.created_at