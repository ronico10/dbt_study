{% macro get_specific_category(x) %}

CASE WHEN {{ x }} = 'スポーツ' THEN 'I love it' ELSE '' END

{% endmacro %}