-- TESTING SILVER



-- Check For Date Consistencies 

SELECT NULLIF(sls_order_dt, 0) sls_order_dt
FROM Silver.crm_sales_details 
WHERE sls_order_dt = 0 or Length(sls_order_dt) != 8 ;

SELECT NULLIF(sls_ship_dt, 0) sls_ship_dt
FROM Silver.crm_sales_details 
WHERE sls_ship_dt = 0 or Length(sls_ship_dt) != 8 ;


SELECT NULLIF(sls_due_dt, 0) sls_due_dt
FROM Silver.crm_sales_details 
WHERE sls_due_dt = 0 or Length(sls_due_dt) != 8 ;

-- Check For Invalid date orders
select * From Silver.crm_sales_details
where sls_order_dt > sls_ship_dt OR sls_order_dt >sls_due_dt;

select * from Silver.crm_sales_Details
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


		
