WITH payments AS (
    SELECT
          id AS payment_id
        , orderid AS order_id
        , paymentmethod AS payment_method
        , status
        , {{ cents_to_dollars('amount', decimal_places=3) }} AS amount  
        , created AS date_created
    FROM {{ source('stripe', 'payment') }}
)  

SELECT *
FROM payments