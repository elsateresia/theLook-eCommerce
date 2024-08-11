CREATE TEMPORARY TABLE `bigquery-public-data.thelook_ecommerce.report_monthly_orders_product_category_agg` AS
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

-- Code & Penjelasan
CREATE TEMPORARY TABLE `bigquery-public-data.thelook_ecommerce.report_monthly_orders_product_category_agg` AS
-- Membuat Tabel Sementara: Baris ini membuat sebuah tabel sementara (temporary table) 
-- bernama report_monthly_orders_product_category_agg di dalam dataset bigquery-public-data.thelook_ecommerce. 
-- Tabel sementara ini hanya akan ada selama sesi saat ini dan akan dihapus secara otomatis setelah sesi berakhir.
WITH category_sales AS (
-- Pendefinisian CTE (Common Table Expression): Bagian ini mendefinisikan sebuah CTE 
-- bernama category_sales yang akan digunakan untuk menyederhanakan kueri utama. 
-- CTE ini digunakan untuk menyusun data penjualan bulanan berdasarkan kategori produk.
    SELECT
        EXTRACT(YEAR FROM oi.created_at) AS order_year,
        FORMAT_TIMESTAMP('%B', oi.created_at) AS order_month,
-- Pengambilan Tahun dan Bulan dari created_at:
-- EXTRACT(YEAR FROM oi.created_at) AS order_year: Mengekstrak tahun dari kolom created_at di tabel order_items dan menamainya order_year.
-- FORMAT_TIMESTAMP('%B', oi.created_at) AS order_month: Memformat timestamp created_at menjadi nama bulan (misalnya, "January", "February") dan menamainya order_month.
        p.category AS product_category,
-- Mengambil Kategori Produk:
-- p.category AS product_category: Mengambil kategori produk dari tabel products dan menamainya product_category.
        COUNT(oi.id) AS qty_sold_of_category,
        SUM(oi.sale_price) AS total_amount_of_category
-- Menghitung Kuantitas Terjual dan Jumlah Penjualan untuk Kategori:
-- COUNT(oi.id) AS qty_sold_of_category: Menghitung frekuensi kategori dalam penjualan dan menamainya qty_sold_of_category.
-- SUM(oi.sale_price) AS total_amount_of_category: Menjumlahkan harga jual (sale_price) untuk produk dalam setiap kategori dan menamainya total_amount_of_category.
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
        order_year, order_month, product_category
)
-- Mengelompokkan Data:
-- GROUP BY order_year, order_month, product_category: Mengelompokkan data berdasarkan tahun pesanan, 
-- bulan pesanan, dan kategori produk untuk mendapatkan agregasi penjualan bulanan per kategori.
SELECT
    order_year,
    order_month,
    product_category,
    qty_sold_of_category,
    total_amount_of_category
FROM
    category_sales;
-- Memilih dan Menampilkan Data dari CTE category_sales:
-- SELECT ... FROM category_sales: Bagian ini mengambil dan menampilkan data dari 
-- CTE category_sales yang telah dihitung dan diolah sebelumnya, sehingga menghasilkan tabel agregasi penjualan bulanan berdasarkan kategori produk.
