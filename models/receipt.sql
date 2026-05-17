WITH receipt AS (
SELECT 
    PRODUCT_CODE, WAREHOUSE_CODE, SUM(QUANTITY) AS total_received_qty
FROM {{ source('demo', 'receipt_transaction') }}
WHERE STATUS = '入荷済'
GROUP BY 1,2
)

SELECT * FROM receipt