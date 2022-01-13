WITH payments AS (
    SELECT
          id AS payment_id
        , orderid AS order_id
        , paymentmethod AS payment_method
        , status
        , amount / 100 AS amount  
        , created AS date_created
    FROM raw.stripe.payment
)  

SELECT *
FROM payments