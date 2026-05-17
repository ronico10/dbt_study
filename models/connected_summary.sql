SELECT
    master.PRODUCT_CODE,
    master.PRODUCT_NAME,
    CATEGORY,
    master.WAREHOUSE_CODE,
    shipment.total_shipped_qty,
    receipt.total_received_qty,
    inventory.total_inventory_qty,
    {{ get_specific_category('CATEGORY') }} as cat_label,
    {{ check_main_warehouse('master.WAREHOUSE_CODE') }} as warehouse_mark,
    COALESCE(receipt.total_received_qty, 0) - COALESCE(shipment.total_shipped_qty, 0) as net_movement,
    CASE WHEN shipment.total_shipped_qty IS NOT NULL THEN TRUE ELSE FALSE END AS has_shipment,
    CASE WHEN receipt.total_received_qty IS NOT NULL THEN TRUE ELSE FALSE END AS has_receipt
FROM {{ source('demo', 'product_master') }} as master
LEFT JOIN {{ ref('shipment') }}
ON master.product_code = shipment.product_code
AND master.warehouse_code = shipment.warehouse_code
LEFT JOIN {{ ref('receipt') }}
ON master.product_code = receipt.product_code
AND master.warehouse_code = receipt.warehouse_code
LEFT JOIN {{ ref('inventory') }}
ON master.product_code = inventory.product_code
AND master.warehouse_code = inventory.warehouse_code
