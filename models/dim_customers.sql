{{ config (
    materialized="table"
)}}

WITH customers AS (

    SELECT * FROM {{ ref('stg_customers')}}

),

orders AS (

    SELECT * FROM {{ ref('stg_orders') }}

),

customer_order_stats AS (
    SELECT 
          customer_id
        , MIN(order_date) AS first_order_date
        , MAX(order_date) AS most_recent_order_date
        , COUNT(order_date) AS number_of_orders
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
    FROM customers c 
    LEFT JOIN customer_order_stats cos 
        ON c.customer_id = cos.customer_id
)

SELECT *
FROM final