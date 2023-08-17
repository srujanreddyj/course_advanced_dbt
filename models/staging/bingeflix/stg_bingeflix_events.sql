{{
    config(
        materialized='incremental',
        unique_key='event_id'
    )
}}

WITH source AS (

    SELECT
        session_id,
        created_at,
        user_id,
        event_name,
        event_id
    FROM {{ source('bingeflix', 'events') }}

{% if is_incremental() %}
  {{ incremental_where_clause('created_at', -3, 'day') }}
  
  {# WHERE created_at > (SELECT MAX(created_at) FROM {{ this }}) #}

{% endif %}

)

SELECT * FROM source