-- =====================================================
-- QUERY ANALISIS APLIKASI OJEK ONLINE
-- File ini berisi query untuk menjawab soal analisis data
-- =====================================================

-- 1. Menampilkan total order setiap bulan
SELECT 
    EXTRACT(MONTH FROM requested_at) AS bulan,
    TO_CHAR(requested_at, 'Month YYYY') AS periode,
    COUNT(*) AS total_order,
    COUNT(CASE WHEN status = 'completed' THEN 1 END) AS completed,
    COUNT(CASE WHEN status = 'canceled' THEN 1 END) AS canceled,
    COUNT(CASE WHEN status = 'started' THEN 1 END) AS ongoing
FROM orders
GROUP BY 
    EXTRACT(MONTH FROM requested_at),
    TO_CHAR(requested_at, 'Month YYYY')
ORDER BY bulan DESC;


-- 2. Menampilkan nama customer yang paling sering melakukan order tiap bulan

WITH monthly AS (
    SELECT
        DATE_TRUNC('month', o.requested_at) AS bulan,
        u.name AS customer_name,
        COUNT(*) AS total_order,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_TRUNC('month', o.requested_at)
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM orders o
    JOIN customers c ON o.customer_id = c.id
    JOIN users u ON c.user_id = u.id
    GROUP BY 1, u.name
)
SELECT bulan, customer_name, total_order
FROM monthly
WHERE rn <= 3
ORDER BY bulan DESC;

-- 3. Menampilkan daerah atau lokasi mana saja yang memiliki jumlah order terbanyak
-- Berdasarkan pickup location (lokasi penjemputan)
SELECT 
    a.name AS area_name,
    a.city,
    COUNT(*) AS total_pickup,
FROM orders o
JOIN areas a ON o.pickup_area_id = a.id
GROUP BY a.id, a.name, a.city
ORDER BY total_pickup DESC
LIMIT 10;

-- Berdasarkan dropoff location (lokasi tujuan)
SELECT 
    a.name AS area_name,
    a.city,
    COUNT(*) AS total_dropoff,
FROM orders o
JOIN areas a ON o.dropoff_area_id = a.id
GROUP BY a.id, a.name, a.city
ORDER BY total_dropoff DESC
LIMIT 10;

-- 4. Menampilkan waktu (jam) kapan saja order ramai dan sepi terjadi
-- Waktu Order Paling Ramai
SELECT
    EXTRACT(HOUR FROM requested_at) AS jam,
    COUNT(*) AS total_order
FROM orders
GROUP BY 1
ORDER BY jam DESC;

-- Waktu Order Paling Sepi
SELECT 
    EXTRACT(HOUR FROM requested_at) AS jam,
    COUNT(*) AS total_order
FROM orders
GROUP BY 1
ORDER BY total_order ASC;

SELECT 
    EXTRACT(HOUR FROM requested_at) AS jam,
    LPAD(EXTRACT(HOUR FROM requested_at)::TEXT, 2, '0') || ':00 - ' || 
    LPAD(EXTRACT(HOUR FROM requested_at)::TEXT, 2, '0') || ':59' AS rentang_waktu,
    COUNT(*) AS total_order,
    'JAM RAMAI' AS kategori
FROM orders
GROUP BY EXTRACT(HOUR FROM requested_at)
ORDER BY total_order DESC
LIMIT 5;

-- 5. Menampilkan jumlah customer yang sedang login dan yang sudah logout

SELECT 
    COUNT(DISTINCT CASE WHEN logout_at IS NULL THEN user_id END) AS customer_online,
    COUNT(DISTINCT CASE WHEN logout_at IS NOT NULL THEN user_id END) AS customer_offline,
    COUNT(DISTINCT user_id) AS total_customer_pernah_login
FROM user_sessions
WHERE user_id IN (SELECT user_id FROM customers);

-- Detail customer yang sedang online
SELECT 
    u.id,
    u.name,
    u.email,
    us.device_info,
    us.login_at,
    us.last_activity_at
FROM user_sessions us
JOIN users u ON us.user_id = u.id
JOIN customers c ON u.id = c.user_id
WHERE us.logout_at IS NULL
ORDER BY us.last_activity_at DESC;

-- Detail customer yang sudah logout
SELECT 
    u.id,
    u.name,
    u.email,
    us.login_at,
    us.logout_at
FROM user_sessions us
JOIN users u ON us.user_id = u.id
JOIN customers c ON u.id = c.user_id
WHERE us.logout_at IS NOT NULL
ORDER BY us.logout_at DESC;

-- 6. Menampilkan daftar driver yang paling rajin (paling banyak mengambil order sampai selesai) setiap bulan

WITH driver_monthly_performance AS (
    SELECT 
        DATE_TRUNC('month', o.requested_at) AS bulan,
        u.name AS driver_name,
        COUNT(*) FILTER (WHERE o.status = 'completed') AS completed_order,
        COUNT(*) AS total_order,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_TRUNC('month', o.requested_at)
            ORDER BY COUNT(*) FILTER (WHERE o.status = 'completed') DESC
        ) AS rn
    FROM orders o
    JOIN drivers d ON o.driver_id = d.id
    JOIN users u ON d.user_id = u.id
    GROUP BY 1, u.name
)
SELECT bulan, driver_name, completed_order, total_order
FROM driver_monthly_performance
WHERE rn = 1
ORDER BY bulan DESC;