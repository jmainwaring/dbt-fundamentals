/*
Fictional scenario that LTV model is broken and we want to create another dim_customers table without that
column. Just for practicing star() macro but in production. Should just list out each column name
*/

WITH dim_customer_no_ltv AS (
    SELECT
        {{ dbt_utils.star(from=ref('dim_customers'), except=['lifetime_value']) }}
    FROM {{ ref('dim_customers') }}
)

SELECT *
FROM dim_customer_no_ltv