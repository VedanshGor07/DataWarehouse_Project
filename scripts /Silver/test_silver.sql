-- ######### Performing Quality For crm_cust_info ######### --

-- 1) Checking data duplicasy  -- 

select cst_id , count(*) from bronze.crm_cust_info -- Identifing duplicates in the table
group by cst_id
having count(*) >=2 or cst_id is null ;

select * from bronze.crm_cust_info -- checking an example of one customer for duplicate cst_id
where cst_id =29466 ;

-- Reverify The null in Primary key
select * from bronze.crm_cust_info 
where cst_id is null ;

-- Removed Duplicates and kept the latest entries of the tables if there are any duplicates.

select 
		* 
From (
		select * ,
		row_number() over  (partition by cst_id order by cst_create_date desc) as latest_flag_data
		From bronze.crm_cust_info 
	)t 
where latest_flag_data =1  ; 


-- 2) Checking for unwanted spaces
select * from bronze.crm_cust_info    -- This part of code will check irregular names because of  spaces for First name
where cst_firstname != trim(cst_firstname) ;

select * from bronze.crm_cust_info    -- This part of code will check irregular names because of  spaces For Last name
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



-- CHeck for Null and Negative numbers 

select prd_cost from bronze.crm_prdct_info 
where prd_cost <= 0 or prd_cost is null
 ;
select distinct (prd_line) from bronze.crm_prdct_info ;


-- Check For Date Consistencies 


select * from bronze.crm_prdct_info
where prd_start_dt > prd_end_dt
