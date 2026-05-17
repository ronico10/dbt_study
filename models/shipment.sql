WITH shipment AS (
SELECT 
    PRODUCT_CODE, WAREHOUSE_CODE, SUM(QUANTITY) AS total_shipped_qty
FROM {{ source('demo', 'shipment_transaction') }}
WHERE STATUS = '出荷済'
GROUP BY 1,2
)

SELECT * FROM shipment