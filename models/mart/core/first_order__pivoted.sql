/*
In the dim_customers table, all of the customer’s first orders are between 
January and April of 2018. Made a column of binary indicators for whether the first order was in January,
first order was in February, etc. to April
*/

{% set early_months = 
    {
      1 : 'january',
      2 : 'febuary',
      3 : 'march',
      4 : 'april'
    }
%}   


WITH first_order_date AS (
    SELECT 
          customer_id
        , EXTRACT(MONTH FROM first_order_date) AS first_order_month
    FROM {{ ref('dim_customers') }}
    WHERE
        first_order_date IS NOT NULL  
)

SELECT 
      customer_id
    {% for key, value in early_months.items() -%}
    , CASE WHEN first_order_month = {{ key }} THEN 'True' ELSE 'False' END AS {{ early_months[key] }}_first_purchase
    {% endfor %} 
FROM first_order_date;