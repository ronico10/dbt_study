select
*
from {{ source('demo', 'inventory_transaction') }}
limit 10
