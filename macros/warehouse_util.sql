{% macro check_main_warehouse(x) %}

CASE WHEN {{ x }} = 'WH001' THEN 'main_wh' ELSE '' END

{% endmacro %}