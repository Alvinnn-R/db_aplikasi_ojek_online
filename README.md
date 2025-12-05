# Database Aplikasi Ojek Online

PostgreSQL database design for ride-hailing application with comprehensive analytics, automated triggers, and real-time tracking features.

## 📋 Soal

Berdasarkan kebutuhan aplikasi ojek online, buatlah desain struktur tabel dan query SQL untuk memenuhi fitur-fitur berikut:

1. Menampilkan total order setiap bulan
2. Menampilkan nama customer yang paling sering melakukan order tiap bulan
3. Menampilkan daerah atau lokasi mana saja yang memiliki jumlah order terbanyak
4. Menampilkan waktu (jam) kapan saja order ramai dan sepi terjadi
5. Menampilkan jumlah customer yang sedang login dan yang sudah logout
6. Menampilkan daftar driver yang paling rajin (paling banyak mengambil order sampai selesai) setiap bulan

## 📁 File Structure

| File                                   | Deskripsi                                |
| -------------------------------------- | ---------------------------------------- |
| `ERD Diagram.png`                      | Entity Relationship Diagram              |
| `ddl_aplikasi_ojek_online.sql`         | Database schema (tables, enums, indexes) |
| `dml_aplikasi_ojek_online.sql`         | Sample data                              |
| `query_semua_fitur.sql`                | Query untuk semua 6 fitur                |
| `triggers_aplikasi_ojek_online.sql`    | Automated triggers                       |
| `backup_db_aplikasi_ojek_online_1.sql` | Database backup                          |

## 🗄️ Database Schema

**Tables:** users, customers, drivers, areas, orders, order_status_history, user_sessions, driver_monthly_stats

**ENUM Types:** user_role, driver_status, order_status

## 🚀 Installation

```sql
-- 1. Create database
CREATE DATABASE db_ojek_online;
\c db_ojek_online

-- 2. Run DDL
\i ddl_aplikasi_ojek_online.sql

-- 3. Insert data
\i dml_aplikasi_ojek_online.sql

-- 4. Install triggers (optional)
\i triggers_aplikasi_ojek_online.sql

-- 5. Run analytics queries
\i query_semua_fitur.sql
```

## 👨‍💻 Author

**Alvin**  
GitHub: [@Alvinnn-R](https://github.com/Alvinnn-R)

---

**Challenge Project** - Golang Intermediate Daytime Class Bootcamp Lumoshive Academy
