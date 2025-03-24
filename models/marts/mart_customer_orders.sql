--imports
with orders as (
    select * 
    from {{ ref('stg_orders') }}
),
customers as (
    select *
    from {{ ref('stg_customers') }}
),

--final
final as (
    select
            customers.customer_id,
            customers.customer_first_name,
            customers.customer_last_name,
            min(orders.order_date) as fdos,
            max(orders.order_date) as most_recent_order_date,
            count(orders.order_id) as number_of_orders,

        from customers
        left join orders on orders.customer_id = customers.customer_id
        group by 1, 2, 3 
)

select * from final