-- ######### Performing Quality For crm_cust_info ######### --

-- 1) Checking data duplicasy  -- 

select cst_id , count(*) from bronze.crm_cust_info -- Identifing duplicates in the table
group by cst_id
having count(*) >=2 or cst_id is null ;

select * from bronze.crm_cust_info -- checking an example of one customer for duplicate cst_id
where cst_id =29466 ;


select 
		* 
From (
		select * ,
		row_number() over (partition by cst_id order by cst_create_date desc) as latest_flag_data
		From bronze.crm_cust_info 
	)t 
where latest_flag_data =1  ; -- Removed Duplicates and kept the latest entries of the tables if there are any duplicates.


-- 2) Checking for unwanted spaces
select * from bronze.crm_cust_info    -- This part of code will check irregular names because of  spaces
where cst_firstname != trim(cst_firstname) ;

select * from bronze.crm_cust_info    -- This part of code will check irregular names because of  spaces
where cst_lastname != trim(cst_lastname) ;


-- NOW  making it better with trimming
-- MAINTAINING STANDARDIZATION AND CONSISTANCY
INSERT INTO silver.crm_cust_info (  -- INSERTING TRANSFORMED DATA TO SILVER LAYER ( In crm_cust_info )
cst_id ,
cst_key ,
cst_firstname ,
cst_lastname ,
cst_material_status,
cst_gndr ,
cst_create_date ) 

select 
	cst_id ,
    cst_key ,
    TRIM(cst_firstname) as cst_firstname,
    TRIM(cst_lastname) as cst_lastname ,
    CASE WHEN cst_material_status = 'M'THEN 'Married'
        WHEN cst_material_status = 'S' THEN 'Single' 
		ELSE 'N/A' 
	END cst_material_status,
    CASE WHEN  cst_gndr = 'M' THEN 'Male'
        WHEN cst_gndr = 'F'  THEN 'Female' 
		ELSE 'N/A'
	END cst_gndr,
    cst_create_date
From bronze.crm_cust_info   ;



-- ######### Performin Data Quality checks in crm_prd_info ######### --


-- 1) Checking for Duplicates
select prd_nm , count(*) from bronze.crm_prdct_info -- Identifing duplicates in the table
group by prd_nm
having count(*) >=2 or prd_nm is null ; -- NO DUPLICATES -- 

-- 2) Data Standardization and Consistancy checking
insert into Silver.crm_prdct_info(
	prd_id ,
    prd_key ,
    cat_id ,
    prd_nm ,
    prd_cost ,
    prd_line ,
    prd_start_dt ,
    prd_end_dt ,
    prd_end_dt_test
)
SELECT 
	prd_id ,
   REPLACE(SUBSTRING(prd_key , 1,5) ,'-','_' )  as cat_id , 
   SUBSTRING(prd_key , 7,LENGTH(prd_key))   as prd_key,
    prd_nm , 
    ifnull (prd_cost , 0 ) as prd_cost ,
    CASE 
		WHEN UPPER(TRIM(prd_line) ) = 'M' THEN 'Mountain'
        WHEN UPPER(TRIM(prd_line) ) = 'R' THEN  'Road'
        WHEN UPPER(TRIM(prd_line) ) = 'S' THEN 'Other States' 
        WHEN UPPER(TRIM(prd_line) ) = 'T' THEN  'Touring'
		ELSE 'N/A' 
	END prd_line ,
    cast(prd_start_dt as Date)  prd_start_dt,
CASE
    WHEN CAST(prd_end_dt AS CHAR) = '0000-00-00 00:00:00'
    THEN NULL
    ELSE STR_TO_DATE(prd_end_dt, '%Y-%m-%d %H:%i:%s')
END AS prd_end_dt ,
LEAD(CAST(prd_start_dt AS DATE)) OVER (
        PARTITION BY prd_key 
        ORDER BY prd_start_dt
    ) - INTERVAL 1 DAY AS prd_end_dt_test
FROM Bronze.crm_prdct_info;



-- CHeck for Null and Negative numbers 

select prd_cost from bronze.crm_prdct_info 
where prd_cost <= 0 or prd_cost is null
 ;
select distinct (prd_line) from bronze.crm_prdct_info ;


-- Check For Date Consistencies 


select * from bronze.crm_prdct_info
where prd_start_dt > prd_end_dt
