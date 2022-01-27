WITH amount_by_day AS (
    SELECT
          order_date
        , sum(amount) AS daily_sales
    FROM {{ ref('fct_orders') }}
    GROUP BY order_date
),

compared_days AS (
    SELECT
        order_date
        , daily_sales
        , LAG(order_date) OVER(ORDER BY order_date) AS prev_day
        , LAG(daily_sales) OVER(ORDER BY order_date) AS prev_day_sales
    FROM amount_by_day
    ORDER BY order_date
)
 
SELECT *
FROM compared_days