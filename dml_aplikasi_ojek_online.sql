TRUNCATE TABLE users, customers, drivers, areas, orders, order_status_history, user_sessions, driver_monthly_stats RESTART IDENTITY CASCADE;

-- 1. Insert Users (Harus pertama karena referenced oleh customers & drivers)
INSERT INTO users (name, role, email, phone, password_hash, created_at, updated_at) VALUES
('Alvin Saputra', 'customer', 'alvin@example.com', '081234567890', '9f2caa82d1efbc2a91ed', NOW(), NOW()),
('Rizky Pratama', 'customer', 'rizky@example.com', '081223344556', 'a12fbe902c1d98ab77c4', NOW(), NOW()),
('Dewi Lestari', 'customer', 'dewi@example.com', '081298765432', 'cfa02ee3b19f11cc8aa2', NOW(), NOW()),
('Budi Santoso', 'driver', 'budi.driver@example.com', '081355667788', '81cd99af27ab01ddc331', NOW(), NOW()),
('Raka Firmansyah', 'driver', 'raka.driver@example.com', '081366778899', '7bb129f3dca981eeac01', NOW(), NOW()),
('Siti Mawar', 'driver', 'siti.driver@example.com', '081377889900', 'd912fa70be22c90aa911', NOW(), NOW()),
('Aditya Putra', 'customer', 'aditya@example.com', '081212122233', 'bd1198c0ea83bc772e48', NOW(), NOW()),
('Nadia Ayu', 'customer', 'nadia@example.com', '081288899900', 'c02bc717df00991afde1', NOW(), NOW()),
('Vina Melati', 'driver', 'vina.driver@example.com', '081244556677', 'ef22a981cd78bc1299aa', NOW(), NOW()),
('Farhan Dwi', 'customer', 'farhan@example.com', '081297643210', 'aa33bc19ef01da77be21', NOW(), NOW()),
('Joko Widodo', 'driver', 'joko.driver@example.com', '081311112222', 'f1019ab33cd092aa1fb0', NOW(), NOW()),
('Tono Prayitno', 'driver', 'tono.driver@example.com', '081344455566', 'cb9912fa10bb88ca7711', NOW(), NOW()),
('Aulia Rahma', 'customer', 'aulia@example.com', '081299887766', 'bb1988aacd01ef22cc0f', NOW(), NOW()),
('Denny Mahendra', 'customer', 'denny@example.com', '081277712345', 'dcaa91771ef00bc39a1b', NOW(), NOW()),
('Lina Agustina', 'driver', 'lina.driver@example.com', '081288899911', 'aa01cd9988ef123bb77c', NOW(), NOW());

-- 2. Insert Customers (Setelah users ada)
-- customer_id akan menjadi 1,2,3,4,5,6,7 sesuai urutan insert
INSERT INTO customers (user_id, profile_photo, rating, total_orders) VALUES
(1, 'profile1.jpg', 4.8, 12),
(2, 'profile2.jpg', 4.5, 8),
(3, 'profile3.jpg', 4.9, 15),
(7, 'profile4.jpg', 4.4, 6),
(8, 'profile5.jpg', 4.7, 10),
(10, 'profile6.jpg', 4.6, 9),
(13, 'profile7.jpg', 4.9, 14),
(14, 'profile8.jpg', 4.6, 7);

-- 3. Insert Drivers (Setelah users ada)
INSERT INTO drivers (user_id, profile_photo, vehicle_type, vehicle_model, license_plate, driver_status, rating, monthly_completed_count) VALUES
(4, 'driver1.jpg', 'motor', 'Honda Beat', 'L 1234 AA', 'available', 4.9, 32),
(5, 'driver2.jpg', 'motor', 'Yamaha NMAX', 'L 2234 BB', 'available', 4.8, 28),
(6, 'driver3.jpg', 'motor', 'Honda Vario', 'L 3234 CC', 'on_trip', 4.7, 20),
(9, 'driver4.jpg', 'motor', 'Scoopy Stylish', 'L 4455 DD', 'available', 4.6, 15),
(11, 'driver5.jpg', 'motor', 'Suzuki Nex', 'L 5566 EE', 'offline', 4.4, 10),
(12, 'driver6.jpg', 'motor', 'Aerox 155', 'L 6677 FF', 'available', 4.7, 18),
(15, 'driver7.jpg', 'motor', 'Honda PCX', 'L 7788 GG', 'on_trip', 4.9, 25);

-- 4. Insert Areas (Independen, bisa kapan saja)
INSERT INTO areas (name, city, latitude, longitude) VALUES
('Tegalsari', 'Surabaya', -7.2631, 112.7425),
('Wonokromo', 'Surabaya', -7.2961, 112.7364),
('Rungkut', 'Surabaya', -7.3239, 112.7712),
('Sukolilo', 'Surabaya', -7.2903, 112.7874),
('Genteng', 'Surabaya', -7.2614, 112.7449),
('Sawahan', 'Surabaya', -7.2658, 112.7268),
('Gubeng', 'Surabaya', -7.2746, 112.7586),
('Mulyorejo', 'Surabaya', -7.2805, 112.7993),
('Kenjeran', 'Surabaya', -7.2110, 112.7594),
('Karangpilang', 'Surabaya', -7.3292, 112.6909),
('Tunjungan Plaza', 'Surabaya', -7.2635, 112.7378),
('Grand City Mall', 'Surabaya', -7.2607, 112.7490),
('Galaxy Mall', 'Surabaya', -7.2841, 112.7769),
('Pakuwon Mall', 'Surabaya', -7.2902, 112.6599),
('ITS Sukolilo', 'Surabaya', -7.2811, 112.7957),
('Universitas Airlangga Kampus B', 'Surabaya', -7.2743, 112.7581),
('Pelabuhan Tanjung Perak', 'Surabaya', -7.2070, 112.7338),
('Kebun Binatang Surabaya', 'Surabaya', -7.2966, 112.7371),
('BG Junction Mall', 'Surabaya', -7.2578, 112.7316),
('Lenmarc Mall', 'Surabaya', -7.2957, 112.6712),
('Ciputra World', 'Surabaya', -7.2925, 112.7342),
('Terminal Joyoboyo', 'Surabaya', -7.2969, 112.7334),
('Alun-Alun Sidoarjo', 'Sidoarjo', -7.4477, 112.7183),
('Gading Fajar', 'Sidoarjo', -7.4372, 112.7002),
('Waru', 'Sidoarjo', -7.3574, 112.7306),
('Buduran', 'Sidoarjo', -7.4271, 112.7585),
('Taman', 'Sidoarjo', -7.3669, 112.7173),
('Krian', 'Sidoarjo', -7.4091, 112.5821),
('Terminal Purabaya (Bungurasih)', 'Sidoarjo', -7.3490, 112.7312);

-- 5. Insert Orders (Setelah customers, drivers, areas ada)
INSERT INTO orders (
    order_uuid, customer_id, driver_id,
    pickup_area_id, dropoff_area_id,
    pickup_address, dropoff_address,
    total_cost, status,
    requested_at, accepted_at, started_at, completed_at, canceled_at, rating
) VALUES
(gen_random_uuid(), 1, 1, 1, 2, 'Jl. Diponegoro 12', 'Jl. Wonokromo 88', 15000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 5),

(gen_random_uuid(), 2, 2, 3, 4, 'Jl. Rungkut Asri 5', 'Jl. Sukolilo Baru 7', 18000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 4),

(gen_random_uuid(), 3, 3, 5, 6, 'Jl. Genteng 14', 'Jl. Sawahan Indah 20', 12000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 5),

(gen_random_uuid(), 4, 4, 7, 8, 'Jl. Gubeng Kertajaya 30', 'Jl. Mulyorejo 21', 20000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 5),

(gen_random_uuid(), 5, 5, 2, 1, 'Jl. Wonokromo 45', 'Jl. Tegalsari 10', 13000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 4),

(gen_random_uuid(), 6, 6, 9, 3, 'Jl. Kenjeran 50', 'Jl. Rungkut Madya 14', 22000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 5),

(gen_random_uuid(), 7, 7, 4, 5, 'Jl. Sukolilo Asri', 'Jl. Genteng Besar 33', 17000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 5),

(gen_random_uuid(), 1, 1, 1, 3, 'Jl. Diponegoro 10', 'Jl. Rungkut 17', 19000, 'canceled',
 NOW(), NOW(), NULL, NULL, NOW(), NULL),

(gen_random_uuid(), 2, 2, 6, 7, 'Jl. Sawahan Tengah', 'Jl. Gubeng 55', 14000, 'completed',
 NOW(), NOW(), NOW(), NOW(), NULL, 4),

(gen_random_uuid(), 3, 3, 8, 9, 'Jl. Mulyorejo Baru', 'Jl. Kenjeran 99', 21000, 'started',
 NOW(), NOW(), NOW(), NULL, NULL, NULL);

-- 6. Insert Order Status History (Setelah orders ada)
INSERT INTO order_status_history (order_id, status, changed_by_user_id, note, changed_at) VALUES
(1, 'requested', 1, 'Order dibuat', NOW()),
(1, 'accepted', 4, 'Driver menerima order', NOW()),
(1, 'completed', 4, 'Order selesai', NOW()),

(2, 'requested', 2, 'Order dibuat', NOW()),
(2, 'accepted', 5, 'Driver menerima order', NOW()),
(2, 'completed', 5, 'Order selesai', NOW()),

(8, 'requested', 1, 'Order dibuat', NOW()),
(8, 'accepted', 4, 'Driver menerima order', NOW()),
(8, 'canceled', 1, 'Customer membatalkan', NOW());


INSERT INTO driver_monthly_stats (driver_id, year, month, total_earning, total_orders) VALUES
(1, 2025, 1, 34000, 2),
(2, 2025, 1, 32000, 2),
(3, 2025, 1, 33000, 2),
(4, 2025, 1, 20000, 1),
(5, 2025, 1, 13000, 1),
(6, 2025, 1, 22000, 1),
(7, 2025, 1, 17000, 1);

-- 8. Insert User Sessions (Setelah users ada)
INSERT INTO user_sessions (user_id, session_token, device_info, ip_address, login_at, last_activity_at) VALUES
(1, gen_random_uuid(), 'Android 12 - Xiaomi', '103.22.14.55', NOW(), NOW()),
(2, gen_random_uuid(), 'iPhone 13', '103.22.16.11', NOW(), NOW()),
(3, gen_random_uuid(), 'Windows 10 Chrome', '103.22.18.90', NOW(), NOW()),
(4, gen_random_uuid(), 'Android 11 - Oppo', '103.22.19.45', NOW(), NOW()),
(5, gen_random_uuid(), 'Android - Samsung', '103.22.22.77', NOW(), NOW()),
(6, gen_random_uuid(), 'Windows 11 Edge', '103.22.24.88', NOW(), NOW()),
(7, gen_random_uuid(), 'iPhone 14', '103.22.26.33', NOW(), NOW()),
(8, gen_random_uuid(), 'Android - Vivo', '103.22.28.12', NOW(), NOW()),
(10, gen_random_uuid(), 'Windows 10 Firefox', '103.22.29.44', NOW(), NOW()),
(13, gen_random_uuid(), 'iPad Air', '103.22.30.55', NOW(), NOW());