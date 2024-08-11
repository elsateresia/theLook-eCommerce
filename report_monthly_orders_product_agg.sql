-- Code
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

-- Code & Penjelasan
CREATE TEMPORARY TABLE `bigquery-public-data.thelook_ecommerce.report_monthly_orders_product_agg` AS
-- Membuat Tabel Sementara: Baris ini membuat sebuah tabel sementara (temporary table) bernama 
-- report_monthly_orders_product_agg di dalam dataset bigquery-public-data.thelook_ecommerce. 
-- Tabel sementara ini hanya akan ada selama sesi tertentu.
WITH product_sales AS (
-- Pendefinisian CTE (Common Table Expression): Bagian ini mendefinisikan sebuah CTE bernama product_sales yang akan 
-- digunakan untuk menyederhanakan kueri utama. Tujuan CTE ini untuk menyusun data penjualan produk bulanan.
    SELECT
        EXTRACT(YEAR FROM oi.created_at) AS order_year,
        FORMAT_TIMESTAMP('%B', oi.created_at) AS order_month,
-- Pengambilan Tahun dan Bulan dari created_at:
-- EXTRACT(YEAR FROM oi.created_at) AS order_year: Mengekstrak tahun dari kolom created_at di tabel order_items dan menamainya order_year.
-- FORMAT_TIMESTAMP('%B', oi.created_at) AS order_month: Memformat timestamp created_at menjadi nama bulan 
-- (misalnya, "January", "February") dan menamainya order_month.
        p.id AS product_id,
        p.name AS product_name,
        p.category AS product_category,
-- Mengambil Informasi Produk:
-- p.id AS product_id: Mengambil id produk dari tabel products dan menamainya product_id.
-- p.name AS product_name: Mengambil name produk dari tabel products dan menamainya product_name.
-- p.category AS product_category: Mengambil category produk dari tabel products dan menamainya product_category.
        COUNT(oi.id) AS qty_sold_of_product,
        SUM(oi.sale_price) AS total_amount_of_product
-- Menghitung Kuantitas Terjual dan Jumlah Penjualan:
-- COUNT(oi.id) AS qty_sold_of_product: Menghitung frekuensi produk  terjual (frekuensi) dalam setiap bulan dan menamainya qty_sold_of_product.
-- SUM(oi.sale_price) AS total_amount_of_product: Menjumlahkan harga jual (sale_price) untuk produk tersebut dalam setiap bulan dan menamainya total_amount_of_product.
    FROM
        `bigquery-public-data.thelook_ecommerce.order_items` AS oi
    JOIN
        `bigquery-public-data.thelook_ecommerce.products` AS p
    ON
        oi.product_id = p.id
-- Melakukan Join pada Tabel order_items dan products:
-- FROM 'order_items' AS oi: Mengambil data dari tabel order_items dengan alias oi.
-- JOIN 'products' AS p ON oi.product_id = p.id: Melakukan join antara tabel order_items dan products berdasarkan product_id.
    WHERE
        oi.status = 'Complete'  -- Only include completed orders
-- Menyaring Data Berdasarkan Status Pesanan:
-- WHERE oi.status = 'Complete': Menyaring data untuk hanya menyertakan pesanan dengan status 'Complete'.
    GROUP BY
        order_year, order_month, product_id, product_name, product_category
-- Mengelompokkan Data:
-- GROUP BY order_year, order_month, product_id, product_name, product_category: 
-- Mengelompokkan data berdasarkan tahun pesanan, bulan pesanan, ID produk, nama produk, dan kategori produk untuk mendapatkan agregasi penjualan.
-- )
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
-- Memilih dan Menampilkan Data dari CTE product_sales:
-- SELECT ... FROM product_sales: Bagian ini mengambil dan menampilkan data dari 
-- CTE product_sales yang telah dihitung dan diolah sebelumnya, sehingga menghasilkan tabel agregasi penjualan produk bulanan.
