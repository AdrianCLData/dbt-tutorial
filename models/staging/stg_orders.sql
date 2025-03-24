with
-- IMPORT
    orders as (

        select * from  {{ ref("src_orders") }}

    ),

-- FINAL
    final as(

        select
            orders.id as order_id,
            orders.user_id as customer_id,
            orders.order_date as order_placed_at,
            orders.status as order_status,
            orders.order_date
        from orders

    )


select *  
from final
