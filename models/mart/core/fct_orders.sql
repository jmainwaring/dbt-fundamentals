WITH orders AS (

    SELECT * FROM {{ ref('stg_orders') }}

),

payments AS (

    SELECT * FROM {{ ref('stg_payments')}}

),

fct_orders AS (
    SELECT 
          orders.order_id
        , orders.customer_id
        , orders.order_date
        , payments.amount
    FROM orders
    JOIN payments
        ON orders.order_id = payments.order_id
    WHERE
        payments.status = 'success'
)

SELECT *
FROM fct_orders