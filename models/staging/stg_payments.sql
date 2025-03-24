-- imports
with
    payments as (select * from {{ ref("src_payments") }}),

    -- final
    final as (
        select payments.orderid as order_id,
            payments.created,
            payments.amount,
            payments.status
        from payments

    )

select *
from final
