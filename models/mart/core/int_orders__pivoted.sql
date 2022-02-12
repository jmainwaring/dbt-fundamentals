{%- set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}


WITH pivoted_payments AS (
    SELECT
           order_id
        {%- for payment_type in payment_methods %}
          , SUM(CASE WHEN payment_method = '{{ payment_type }}' THEN amount ELSE 0 END) AS {{ payment_type }}_amount
        {%- endfor %}
    FROM {{ ref('stg_payments') }}
    WHERE
        status = 'success'
    GROUP BY order_id
)

SELECT *
FROM pivoted_payments