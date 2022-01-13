WITH customers AS (
    SELECT * FROM {{ ref('stg_customers')}}
),

orders AS (
    SELECT * FROM {{ ref('fct_orders') }}
),

customer_order_stats AS (
    SELECT 
          customer_id
        , MIN(orders.order_date) AS first_order_date
        , MAX(orders.order_date) AS most_recent_order_date
        , COUNT(orders.order_date) AS number_of_orders
        , SUM(orders.amount) AS lifetime_value
    FROM orders
    GROUP BY customer_id
),

final AS (
    SELECT 
          c.customer_id
        , c.first_name
        , c.last_name
        , cos.first_order_date
        , cos.most_recent_order_date
        , COALESCE(number_of_orders, 0) AS number_of_orders
        , COALESCE(lifetime_value, 0) AS lifetime_value
    FROM customers c 
    LEFT JOIN customer_order_stats cos 
        ON c.customer_id = cos.customer_id
)

SELECT *
FROM final