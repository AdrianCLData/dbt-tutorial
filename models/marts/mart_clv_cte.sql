--import
with paid_orders as (
    select 
        *
    from {{ ref('mart_paid_orders') }}
),

--final

final as (
 -- calcula para cada order id el CLV teniendo en cuenta el order id actual y
        -- los anteriores para el calculo.
        select
            paid_orders.order_id, sum(t2.total_amount_paid) as customer_lifetime_value
        from paid_orders
        left join
            paid_orders t2
            on paid_orders.customer_id = t2.customer_id
            and paid_orders.order_id >= t2.order_id
        group by 1
        order by paid_orders.order_id
)

select * from final