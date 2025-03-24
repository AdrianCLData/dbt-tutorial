-- import
with
    payments as (select * from {{ ref("stg_payment_not_failed") }}),

    -- final
    final as (
        -- CTE extracting last payment date and total payed by order. ORDER LEVEL
        select
            payments.order_id,
            max(payments.created) as payment_finalized_date,
            sum(payments.amount) / 100.0 as total_amount_paid
        from payments
        group by 1
    )

select *
from final
