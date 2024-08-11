CREATE TEMPORARY TABLE report_monthly_orders_product_category_agg AS
WITH category_sales AS (
    SELECT
        EXTRACT(YEAR FROM oi.created_at) AS order_year,
        FORMAT_TIMESTAMP('%B', oi.created_at) AS order_month,
        p.category AS product_category,
        COUNT(oi.id) AS qty_sold_of_category,
        SUM(oi.sale_price) AS total_amount_of_category
    FROM
        `bigquery-public-data.thelook_ecommerce.order_items` AS oi
    JOIN
        `bigquery-public-data.thelook_ecommerce.products` AS p
    ON
        oi.product_id = p.id
    WHERE
        oi.status = 'Complete'  -- Only include completed orders
    GROUP BY
        order_year, order_month, product_category
)
SELECT
    order_year,
    order_month,
    product_category,
    qty_sold_of_category,
    total_amount_of_category
FROM
    category_sales;