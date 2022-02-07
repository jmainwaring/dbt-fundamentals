/* 
When in development, this limits the data to only go num_days 
back rather than using the entire dataset 
*/

{% macro limit_data_in_dev(column_name, num_days=3) -%}

{% if target.name == 'dev' %}
    WHERE
        DATEDIFF('day', '2018-01-05', {{ column_name }}) < {{ num_days }}
{%- endif %}

{%- endmacro %}