select
    -- paid_orders
    orders.id as order_id,
    orders.user_id as customer_id,
    orders.order_date as order_placed_at,
    orders.status as order_status,

    
from {{ ref("src_orders") }}
