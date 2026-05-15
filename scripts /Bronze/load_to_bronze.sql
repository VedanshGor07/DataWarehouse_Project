
--  FULL LOAD (Truncate + Insert) --> no need to keep the history of the records


Truncate table bronze.crm_cust_info;

LOAD DATA local INFILE '/Users/vedanshgor/Downloads/cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


Truncate table bronze.crm_prdct_info ;
LOAD DATA LOCAL INFILE '/Users/vedanshgor/Downloads/prd_info.csv'
INTO TABLE bronze.crm_prdct_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



Truncate Table bronze.crm_sales_details ;
LOAD DATA LOCAL INFILE '/Users/vedanshgor/Downloads/sales_details.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

									-- ERV --- 

Truncate Table bronze.erp_cust_az12 ; 
LOAD DATA LOCAL INFILE '/Users/vedanshgor/Downloads/cust_az12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
 
Truncate Table bronze.erp_loc_a101; 
LOAD DATA LOCAL INFILE '/Users/vedanshgor/Downloads/loc_a101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

Truncate Table bronze.erp_px_cat_g1v2 ; 
LOAD DATA LOCAL INFILE '/Users/vedanshgor/Downloads/PX_CAT_G1V2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

 



