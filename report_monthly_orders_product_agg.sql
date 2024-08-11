
CREATE TEMPORARY TABLE `bigquery-public-data.thelook_ecommerce.report_monthly_orders_product_agg` AS
WITH product_sales AS (
    SELECT
        EXTRACT(YEAR FROM oi.created_at) AS order_year,
        FORMAT_TIMESTAMP('%B', oi.created_at) AS order_month,
        p.id AS product_id,
        p.name AS product_name,
        p.category AS product_category,
        COUNT(oi.id) AS qty_sold_of_product,
        SUM(oi.sale_price) AS total_amount_of_product
    FROM
        `bigquery-public-data.thelook_ecommerce.order_items` AS oi
    JOIN
        `bigquery-public-data.thelook_ecommerce.products` AS p
    ON
        oi.product_id = p.id
    WHERE
        oi.status = 'Complete'  -- Only include completed orders
    GROUP BY
        order_year, order_month, product_id, product_name, product_category
)
SELECT
    order_year,
    order_month,
    product_id,
    product_name,
    product_category,
    qty_sold_of_product,
    total_amount_of_product
FROM
    product_sales;
