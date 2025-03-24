with
    -- IMPORT
    customers as (select * from {{ ref("src_customers") }}),

    -- FINAL
    final as (

        select
            customers.id as customer_id,
            customers.first_name as customer_first_name,
            customers.last_name as customer_last_name
        from customers

    )

select *
from final
