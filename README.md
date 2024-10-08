# theLook-eCommerce
## Product Sales Reports

This repository contains SQL scripts to generate product sales reports. The reports are designed to aggregate sales data on a monthly basis, providing insights into product and category-level sales performance.

Reports Overview

### 1. `report_monthly_orders_product_agg.sql`
This report aggregates sales data based on individual products (product_id). It provides a detailed breakdown of sales by product, including the sales frequency and total sales amount.

#### Features of the Table:
- **order_year**: The year when the order was created. (Source: `order_items` table)
- **order_month**: The month when the order was created, represented in full month names (e.g., "January"). (Source: `order_items` table)
- **product_id**: The unique identifier for the product. (Source: `order_items` table)
- **product_name**: The name of the product. (Source: Join between `order_items` and `products` tables)
- **product_category**: The category to which the product belongs. (Source: `products` table)
- **qty_sold_of_product**: The frequency of products sold in orders. (Source: Join  `order_items` and `products` tables)
- **total_amount_of_product**: The total sales amount for the product. (Source: Join  `order_items` and `products` tables)

### 2. `report_monthly_orders_product_category_agg.sql`
This report aggregates sales data based on product categories. It provides a summary of sales at the category level, including the sales frequency and total sales amount for each category.

#### Features of the Table:
- **order_year**: The year when the order was created. (Source: `order_items` table)
- **order_month**: The month when the order was created, represented in full month names (e.g., "January"). (Source: `order_items` table)
- **product_category**: The category to which the product belongs. (Source: `products` table)
- **qty_sold_of_category**: Frequency of categories sold in each order  (Source: Join  `order_items` and `products` tables)
- **total_amount_of_category**: The total sales amount for the category. (Source: Join  `order_items` and `products` tables)



