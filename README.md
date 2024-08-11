# theLook-eCommerce
## Product Sales Reports

This repository contains SQL scripts to generate product sales reports. The reports are designed to aggregate sales data on a monthly basis, providing insights into product and category-level sales performance.

Reports Overview
1. report_monthly_orders_product_agg.sql
This report aggregates sales data based on individual products (product_id). It provides a detailed breakdown of sales by product, including the quantity sold and total sales amount.
Features of the Table:
  a. order_year: The year when the order was created. (Source: order_items table)
  b. order_month: The month when the order was created, represented in full month names (e.g., "January"). (Source: order_items table)
  c. product_id: The unique identifier for the product. (Source: order_items table)
  d. product_name: The name of the product. (Source: Join between order_items and products tables.)
  e. product_category: The category to which the product belongs. (Source: products table)
  f. qty_sold_of_product: The frequency (quantity) of the product sold in each order. (Source: Join between order_items and products tables.)
  g. total_amount_of_product: The total sales amount for the product. (Source: Join between order_items and products tables.)

2. report_monthly_orders_product_category_agg.sql
This report aggregates sales data based on product categories. It provides a summary of sales at the category level, including the quantity sold and total sales amount for each category.
Features of the Table:
  a. order_year: The year when the order was created. (Source: order_items table)
  b. order_month: The month when the order was created, represented in full month names (e.g., "January"). (Source: order_items table)
  c. product_category: The category to which the product belongs. (Source: products table)
  d. qty_sold_of_category: The frequency (quantity) of products sold within each category. (Source: Join between order_items and products tables.)
  e. total_amount_of_category: The total sales amount for the category. (Source: Join between order_items and products tables.)
