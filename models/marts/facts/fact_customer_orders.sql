with
    -- - Import CTEs
    clv_cte as (select * from {{ ref("mart_clv_cte") }}),

    customer_paid_orders as (select * from {{ ref("mart_customer_paid_orders") }}),

    -- FINAL CTEs
    final as (
        select customer_paid_orders.*, clv_cte.customer_lifetime_value
        from customer_paid_orders
        left outer join clv_cte on clv_cte.order_id = customer_paid_orders.order_id
        order by order_id
    )

select *
from final
