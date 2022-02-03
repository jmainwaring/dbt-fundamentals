/* 
Meant to be illustrative. May be overkill for a fairly trivial transformation to put in your SQL, 
since it’s only used once in the project at the moment 
*/

{% macro cents_to_dollars(column_name, decimal_places=2) -%}
ROUND(1.0 * {{ column_name }}/100, {{ decimal_places }})
{%- endmacro %}
