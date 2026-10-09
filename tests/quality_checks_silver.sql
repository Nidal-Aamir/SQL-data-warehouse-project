/*
==============================================================================
 Quality Checks
==============================================================================
 Script Purpose:
	This script performs data quality checks across the Silver layer to ensure
	data consistency, accuracy, and standardization. The checks cover:
		- Null or duplicate primary keys.
		- Unwanted whitespace in string fields.
		- Data standardization and consistency.
		- Invalid date ranges and chronological order.
		- Consistency between related fields.

	Usage Notes:
		- Execute these checks after loading data into the Silver layer.
		- Investigate and resolve any discrepancies identified during the checks.
================================================================================
*/

------ Checking silver.crm_cust_info

--==============================================================================

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--Check for unwanted spaces
-- Expectation: No Result
SELECT cst_firstname, cst_lastname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;

--==============================================================================

------ Quality Check for silver.crm_prd_info

--==============================================================================

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

--Check for unwanted spaces
-- Expectation: No Result
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

SELECT prd_key
FROM silver.crm_prd_info
WHERE prd_key != TRIM(prd_key);

-- Check for Nulls or Negative Numbers
-- Expectation: No Result
SELECT *
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

-- Check for Invalid Order Dates (Start Date > End Date)
-- Expectation: No Result
SELECT *
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt;

SELECT *
FROM silver.crm_prd_info;

--==============================================================================

------ Quality Check for silver.crm_sales_details

--==============================================================================

-- Check for Invalid Dates (Order Date > Shipping/Due Date)
-- Expectation: No Result
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
	OR sls_order_dt > sls_due_dt;


-- Check for Invalid Dates
SELECT 
	NULLIF(sls_order_dt, 0) sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 
	OR LEN(sls_order_dt) != 8 
	OR sls_order_dt >= 20500101 
	OR sls_order_dt < 19000101;


-- Check Data Consistency: Sales, Quantity & Price
-- >> Sales = Quantity * Price
-- >> Values must not be Null, zero or negative.

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
	OR sls_sales <= 0 
	OR sls_quantity <= 0 
	OR sls_price <= 0
	OR sls_sales IS NULL 
	OR sls_quantity IS NULL 
	OR sls_price IS NULL
ORDER BY sls_sales, sls_quantity, sls_price;

SELECT *
FROM silver.crm_sales_details;


--==============================================================================

------ Quality Check for silver.erp_cust_az12

--==============================================================================

-- Identify Out-of-Range Dates
-- Expectation: Birthdates between 1926-01-01 and Today
SELECT *
FROM silver.erp_cust_az12
WHERE bdate < '1926-01-01' OR bdate > GETDATE();

----- Data Standardization & Consistency
SELECT DISTINCT
gen
FROM silver.erp_cust_az12;

SELECT *
FROM silver.erp_cust_az12;

--==============================================================================

------ Quality Check for silver.erp_loc_a101

--==============================================================================

----- Data Standardization & Consistency
SELECT DISTINCT 
cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

SELECT *
FROM silver.erp_loc_a101;


--==============================================================================

------ Quality Check for silver.erp_px_cat_g1v2

--==============================================================================

--Data Standardization & Consistency
SELECT DISTINCT cat
FROM silver.erp_px_cat_g1v2;

SELECT DISTINCT subcat
FROM silver.erp_px_cat_g1v2;

SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;


--Check for unwanted spaces
-- Expectation: No Result
SELECT
*
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
	OR subcat != TRIM(subcat) 
	OR maintenance != TRIM(maintenance);
