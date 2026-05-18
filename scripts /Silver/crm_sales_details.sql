INSERT INTO silver.crm_sales_details (
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)

SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,

    -- Order Date
    CASE 
        WHEN sls_order_dt = 0 
             OR LENGTH(CAST(sls_order_dt AS CHAR)) != 8
        THEN NULL
        ELSE STR_TO_DATE(CAST(sls_order_dt AS CHAR), '%Y%m%d')
    END AS sls_order_dt,

    -- Ship Date
    CASE 
        WHEN sls_ship_dt = 0 
             OR LENGTH(CAST(sls_ship_dt AS CHAR)) != 8
        THEN NULL
        ELSE STR_TO_DATE(CAST(sls_ship_dt AS CHAR), '%Y%m%d')
    END AS sls_ship_dt,

    -- Due Date
    CASE 
        WHEN sls_due_dt = 0 
             OR LENGTH(CAST(sls_due_dt AS CHAR)) != 8
        THEN NULL
        ELSE STR_TO_DATE(CAST(sls_due_dt AS CHAR), '%Y%m%d')
    END AS sls_due_dt,

    -- Clean Sales
    CASE 
        WHEN sls_sales IS NULL 
             OR sls_sales <= 0
        THEN
            CASE
                WHEN sls_quantity > 0 
                     AND ABS(COALESCE(sls_price,0)) > 0
                THEN sls_quantity * ABS(sls_price)

                ELSE NULL
            END

        WHEN sls_sales != ABS(COALESCE(sls_price,0)) * sls_quantity
             AND sls_quantity > 0
             AND ABS(COALESCE(sls_price,0)) > 0
        THEN sls_quantity * ABS(sls_price)

        ELSE sls_sales
    END AS sls_sales,

    sls_quantity,

    -- Clean Price
    CASE 
        WHEN sls_price IS NULL 
             OR sls_price <= 0
        THEN
            CASE
                WHEN sls_sales > 0 
                     AND sls_quantity > 0
                THEN sls_sales / sls_quantity
                ELSE NULL
            END

        ELSE ABS(sls_price)
    END AS sls_price

FROM bronze.crm_sales_details;
