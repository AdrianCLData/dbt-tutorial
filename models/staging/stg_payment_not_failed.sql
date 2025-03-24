-- imports
with
    payments as (
        select order_id,
            created,
            amount
        from {{ ref("stg_payments") }}
        where status <> 'fail'
    ),

    final as (select * from payments)

select *
from final
