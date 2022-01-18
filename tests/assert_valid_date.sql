WITH payments AS (
    SELECT * FROM {{ ref('stg_payments') }}
)  

SELECT 
     *
FROM payments
WHERE 
    date_created < '2018-01-01'
    OR date_created > CURRENT_DATE()