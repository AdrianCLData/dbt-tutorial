-- import
with orders as (
    select
        *
    from {{ ref('stg_orders') }}
),  
customers as (
    select
        *
    from {{ ref('stg_customers') }}
),
payment_aggregations as (
select
        *
    from {{ ref('stg_payment_aggregations') }}
),

-- FINAL
final as (
    -- CTE extracting some information of the paid order and the customer
        select
            orders.*,
            payment_aggregations.total_amount_paid,
            payment_aggregations.payment_finalized_date,
            
        from orders
        left join
            payment_aggregations
            on orders.order_id = payment_aggregations.order_id
        left join customers on orders.customer_id = customers.customer_id
)

select * from final
