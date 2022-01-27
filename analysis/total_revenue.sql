WITH total_revenue AS (
    SELECT
        SUM(amount) AS total_revenue_amount
    FROM {{ ref('stg_payments') }}
    WHERE status = 'success'
)

SELECT *
FROM total_revenue