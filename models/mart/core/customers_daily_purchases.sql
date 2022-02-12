WITH customer_daily_purchases AS (
    SELECT 
         {{ dbt_utils.surrogate_key(['customer_id', 'order_date']) }} AS id
        , customer_id
        , order_date
        , COUNT(*) AS orders_on_that_day
    FROM {{ ref('stg_orders') }}
    GROUP BY 
        customer_id
    , order_date
    ORDER BY 
        order_date
)

SELECT *
FROM customer_daily_purchases