CREATE TYPE user_role AS ENUM (
    'admin',
    'customer',
    'driver'
);


CREATE TYPE driver_status AS ENUM (
    'available',
    'on_trip',
    'offline'
);


CREATE TYPE order_status AS ENUM (
    'requested',
    'accepted',
    'started',
    'completed',
    'canceled'
);

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role user_role NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    profile_photo TEXT,
    rating NUMERIC(3,2) DEFAULT 0.0,
    total_orders INTEGER DEFAULT 0
);

CREATE TABLE drivers (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    profile_photo TEXT,
    vehicle_type VARCHAR(50),
    vehicle_model VARCHAR(50),
    license_plate VARCHAR(20),
    driver_status driver_status DEFAULT 'offline',
    rating NUMERIC(3,2) DEFAULT 0.0,
    monthly_completed_count INTEGER DEFAULT 0
);

CREATE TABLE areas (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    latitude NUMERIC(10,6),
    longitude NUMERIC(10,6)
);


CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    order_uuid UUID NOT NULL DEFAULT gen_random_uuid(),
    customer_id BIGINT NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    driver_id BIGINT REFERENCES drivers(id) ON DELETE SET NULL,
    pickup_area_id BIGINT NOT NULL REFERENCES areas(id),
    dropoff_area_id BIGINT NOT NULL REFERENCES areas(id),
    pickup_address TEXT NOT NULL,
    dropoff_address TEXT NOT NULL,
    total_cost NUMERIC(12,2) NOT NULL,
    status order_status NOT NULL DEFAULT 'requested',

    requested_at TIMESTAMPTZ DEFAULT NOW(),
    accepted_at TIMESTAMPTZ,
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    canceled_at TIMESTAMPTZ,

    rating NUMERIC(3,2)
);


CREATE TABLE order_status_history (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    status order_status NOT NULL,
    changed_by_user_id BIGINT REFERENCES users(id),
    note TEXT,
    changed_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE user_sessions (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_token UUID NOT NULL DEFAULT gen_random_uuid(),
    device_info TEXT,
    ip_address INET,
    login_at TIMESTAMPTZ DEFAULT NOW(),
    last_activity_at TIMESTAMPTZ,
    logout_at TIMESTAMPTZ
);

CREATE TABLE driver_monthly_stats (
    id BIGSERIAL PRIMARY KEY,
    driver_id BIGINT NOT NULL REFERENCES drivers(id) ON DELETE CASCADE,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    total_earning NUMERIC(12,2) DEFAULT 0,
    total_orders INTEGER DEFAULT 0
);

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_driver_id ON orders(driver_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_order_status_history_order_id ON order_status_history(order_id);
CREATE INDEX idx_user_sessions_user_id ON user_sessions(user_id);
CREATE INDEX idx_driver_monthly_stats_driver ON driver_monthly_stats(driver_id);