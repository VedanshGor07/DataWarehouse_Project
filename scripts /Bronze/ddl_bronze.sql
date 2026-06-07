

-- DDL FOR BRONZE LAYER -- 


DROP TABLE IF EXISTS bronze_erp_loc_a101;
CREATE TABLE bronze.crm_custom_info
(
cst_id INT , 
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date Date
);

DROP TABLE IF EXISTS bronze.crm_prdct_info;
CREATE TABLE bronze.crm_prdct_info(
prd_id INT,
prd_key NVARCHAR(50),
cat_id NVARCHAR(50) ,
prd_nm NVARCHAR(50),
prd_cost int,
prd_line NVARCHAR(50) ,
prd_start_dt Datetime ,
prd_end_dt Datetime
);

DROP TABLE IF EXISTS bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
sls_ord_num NVARCHAR(50) ,
sls_prd_key NVARCHAR(50) ,
sls_cust_id INT ,
sls_order_dt INT ,
sls_ship_dt INT ,
sls_due_dt INT,
sls_sales INT ,
sls_quantity INT ,
sls_price INT 
);


-- ERP -- 

DROP TABLE IF EXISTS bronze_erp_loc_a101;

CREATE TABLE bronze_erp_loc_a101 (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

DROP TABLE IF EXISTS bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
cid Nvarchar(50) ,
bdate date ,
gen  Nvarchar(50) 
);

DROP TABLE IF EXISTS erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
id Nvarchar(50) ,
cat Nvarchar(50) ,
subcat Nvarchar(50),
maintenance Nvarchar(50) 
);
