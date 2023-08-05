--  Returns: A SQL window function string with the specified rolling calculation.
{% macro rolling_func_periods(column_name, partition_by, order_by, window_size=7, alias_name="rolling_agg", function="avg") %}
    {{ function }}({{ column_name }}) OVER (
        PARTITION BY {{ partition_by }}
        ORDER BY {{ order_by }}
        ROWS BETWEEN {{ window_size - 1 }} PRECEDING AND CURRENT ROW
    ) AS {{ alias_name }}_{{ function }}_{{ window_size }}_{{ column_name }}
{% endmacro %}


-- Notes: This macro helps create a rolling window function in SQL, allowing you to calculate
-- aggregations over a specified period for each row in the dataset. The `periods`
-- parameter can be an integer to specify the number of preceding rows to include in the
-- window, or 'unbounded' to include all preceding rows in the range.
