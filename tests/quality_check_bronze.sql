
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

-- 2) Data standardization & Consistancy 

											-- Checking for unwanted spaces
                                            
select * from bronze.crm_cust_info    -- This part of code will check irregular names because of  spaces for First name
where cst_firstname != trim(cst_firstname) ;

select * from bronze.crm_cust_info    -- This part of code will check irregular names because of  spaces For Last name
where cst_lastname != trim(cst_lastname) ;a

