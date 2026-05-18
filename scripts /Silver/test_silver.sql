
-- CHeck for Null and Negative numbers 

select prd_cost from bronze.crm_prdct_info 
where prd_cost <= 0 or prd_cost is null
 ;
select distinct (prd_line) from bronze.crm_prdct_info ;


-- Check For Date Consistencies 


select * from bronze.crm_prdct_info
where prd_start_dt > prd_end_dt
 ;

SELECT NULLIF(sls_order_dt, 0) sls_order_dt
FROM bronze.crm_sales_details 
WHERE sls_order_dt = 0 or Length(sls_order_dt) != 8 ;

SELECT NULLIF(sls_ship_dt, 0) sls_ship_dt
FROM bronze.crm_sales_details 
WHERE sls_ship_dt = 0 or Length(sls_ship_dt) != 8 ;


SELECT NULLIF(sls_due_dt, 0) sls_due_dt
FROM bronze.crm_sales_details 
WHERE sls_due_dt = 0 or Length(sls_due_dt) != 8 ;

-- Check For Invalid date orders
select * From bronze.crm_sales_details
where sls_order_dt > sls_ship_dt OR sls_order_dt >sls_due_dt;

select * from bronze.crm_sales_Details
where  sls_sales != sls_quantity * sls_price 
		or
        sls_sales is null or sls_quantity is null or sls_price is null
        or
        sls_sales <=0 or sls_quantity <=0 or sls_price <=0 
Order By sls_sales,sls_quantity , sls_price

-- Defining rules : 
-- if sales is null negative zero then derive it using quantity and price
-- if price is zero , derive it using sales and quantity 
-- if price is negative , convert it to positive 


		
