--imports
with paid_orders as ( select * from {{ ref('mart_paid_orders') }}),
customer_orders as (select * from  {{ ref('mart_customer_orders') }}),

--final
final as (
    select
            paid_orders.*,
            customer_orders.customer_first_name,
            customer_orders.customer_last_name,
            row_number() over (order by paid_orders.order_id) as transaction_seq,
            row_number() over (
                partition by customer_id order by paid_orders.order_id
            ) as customer_sales_seq,
            case
                when customer_orders.fdos = paid_orders.order_placed_at
                then 'new'
                else 'return'
            end as nvsr,
            customer_orders.fdos
        from paid_orders
        left join customer_orders using (customer_id)
)

select * from final