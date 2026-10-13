/*
======================================================================================
 Quality Checks
======================================================================================
 Script Purpose:
	This script performs data quality checks to verify the integrity, consistency,
	and accuracy of the Gold Layer.
	The checks focus on:
		- Ensuring surrogate keys are unique in dimension tables.
		- Verifying referential integrity between fact and dimension tables.
		- Validate data model relationships to ensure reliable analytical reporting.

	Usage Notes:
		- Investigate and resolve any discrepancies identified during the checks.
======================================================================================
*/

--====================================================================================
------ Checking gold.dim_customers
--====================================================================================

-- Check for uniqueness of Customer Key in gold.dim_customers
-- Expectation: No Result
SELECT 
	customer_key, COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- Data Standardization & Consistency
SELECT DISTINCT gender
FROM gold.dim_customers;


--====================================================================================
------ Checking gold.dim_products
--====================================================================================

-- Check for uniqueness of Product Key in gold.dim_products
-- Expectation: No Result
SELECT 
	product_key, COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


--====================================================================================
------ Checking gold.fact_sales
--====================================================================================

-- Check the data model connectivity between fact and dimensions
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;

