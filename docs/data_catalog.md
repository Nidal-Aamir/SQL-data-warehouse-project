# Data Catalog for the Gold Layer

## Overview
---

The Gold Layer represents business-ready data, organized to support analytical, reporting, and decision-making needs. It consists of 
**dimension tables** that provide descriptive business context, and **fact tables** that capture measurable business events and metrics.

### 1. **gold.dim_customers**

- **Purpose:** Stores customer information enriched with demographic and geographic attributes to support customer analysis and reporting.
- **Columns:**
  

| Column Name     | Data Type    | Description |
|-----------------|--------------|-------------|
| customer_key    | INT          | Surrogate key uniquely identifying each customer record in the dimension table. |
| customer_id     | INT          | Unique numerical identifier assigned to each customer. |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer. |
| first_name      | NVARCHAR(50) | The customer's first name. |
| last_name       | NVARCHAR(50) | The customer's last name or family name. |
| country         | NVARCHAR(50) | The customer's country of residence (e.g., Australia). |
| marital_status  | NVARCHAR(50) | The customer's marital status (e.g., Married, Single). |
| gender          | NVARCHAR(50) | The customer's gender (e.g., Male, Female, n/a). |
| birthdate       | DATE         | The customer's date of birth (YYYY-MM-DD). |
| create_date     | DATE         | The date the customer record was created in the system. |

---

### 2. **gold.dim_products**

- **Purpose:** Provides information about the products and their attributes.
- **Columns:**
  

| Column Name          | Data Type    | Description |
|----------------------|--------------|-------------|
| product_key          | INT          | Surrogate key uniquely identifying each product record in the dimension table. |
| product_id           | INT          | Unique identifier assigned to the product in the source system. |
| product_number       | NVARCHAR(50) | Alphanumeric code used to identify and reference the product. |
| product_name         | NVARCHAR(50) | Descriptive product name, including details such as type, color, or size. |
| category_id          | NVARCHAR(50) | Identifier linking the product to its category. |
| category             | NVARCHAR(50) | High-level product classification, such as Bikes or Components. |
| subcategory          | NVARCHAR(50) | More specific classification of the product within its category. |
| maintenance          | NVARCHAR(50) | Indicates whether the product requires maintenance (e.g., Yes or No). |
| cost                 | INT          | Product cost, expressed in the source system's monetary units. |
| product_line         | NVARCHAR(50) | Product line or series to which the product belongs (e.g., Road or Mountain). |
| start_date           | DATE         | Date from which the product record becomes effective or valid. |

---

### 3. **gold.fact_sales**

- **Purpose:** Stores transactional sales data to support sales performance analysis and business reporting.
- **Columns:**

| Column Name  | Data Type   | Description |
|--------------|-------------|-------------|
| order_number | NVARCHAR(50) | Identifier for the sales order (e.g., SO54496). |
| product_key  | INT          | Foreign key referencing the product dimension table. |
| customer_key | INT          | Foreign key referencing the customer dimension table. |
| order_date   | DATE         | Date when the order was placed. |
| shipping_date | DATE        | Date when the order was shipped to the customer. |
| due_date     | DATE         | Date when payment was due. |
| sales_amount | INT          | Total sales amount for the individual sales line, in whole currency units. |
| quantity     | INT          | Number of product units ordered in the sales line. |
| price        | INT          | Price per unit for the sales line, in whole currency units. |


