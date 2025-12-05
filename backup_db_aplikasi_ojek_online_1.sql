--
-- PostgreSQL database dump
--

\restrict WmDI3OkfgZzcFoIAiMjo05j5eNEccCqxQ8iGbodSgIbEdXy3A8PnOo5q3nCuFwH

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-06 05:59:29

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 870 (class 1247 OID 17822)
-- Name: driver_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.driver_status AS ENUM (
    'available',
    'on_trip',
    'offline'
);


ALTER TYPE public.driver_status OWNER TO postgres;

--
-- TOC entry 873 (class 1247 OID 17830)
-- Name: order_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status AS ENUM (
    'requested',
    'accepted',
    'started',
    'completed',
    'canceled'
);


ALTER TYPE public.order_status OWNER TO postgres;

--
-- TOC entry 867 (class 1247 OID 17814)
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'admin',
    'customer',
    'driver'
);


ALTER TYPE public.user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 17903)
-- Name: areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.areas (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    city character varying(100),
    latitude numeric(10,6),
    longitude numeric(10,6)
);


ALTER TABLE public.areas OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17902)
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.areas_id_seq OWNER TO postgres;

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 225
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.areas_id_seq OWNED BY public.areas.id;


--
-- TOC entry 222 (class 1259 OID 17862)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    profile_photo text,
    rating numeric(3,2) DEFAULT 0.0,
    total_orders integer DEFAULT 0
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17861)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 234 (class 1259 OID 17995)
-- Name: driver_monthly_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_monthly_stats (
    id bigint NOT NULL,
    driver_id bigint NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    total_earning numeric(12,2) DEFAULT 0,
    total_orders integer DEFAULT 0
);


ALTER TABLE public.driver_monthly_stats OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17994)
-- Name: driver_monthly_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.driver_monthly_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.driver_monthly_stats_id_seq OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 233
-- Name: driver_monthly_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.driver_monthly_stats_id_seq OWNED BY public.driver_monthly_stats.id;


--
-- TOC entry 224 (class 1259 OID 17882)
-- Name: drivers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drivers (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    profile_photo text,
    vehicle_type character varying(50),
    vehicle_model character varying(50),
    license_plate character varying(20),
    driver_status public.driver_status DEFAULT 'offline'::public.driver_status,
    rating numeric(3,2) DEFAULT 0.0,
    monthly_completed_count integer DEFAULT 0
);


ALTER TABLE public.drivers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17881)
-- Name: drivers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drivers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.drivers_id_seq OWNER TO postgres;

--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 223
-- Name: drivers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drivers_id_seq OWNED BY public.drivers.id;


--
-- TOC entry 230 (class 1259 OID 17953)
-- Name: order_status_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status_history (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    status public.order_status NOT NULL,
    changed_by_user_id bigint,
    note text,
    changed_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.order_status_history OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17952)
-- Name: order_status_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_status_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_status_history_id_seq OWNER TO postgres;

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 229
-- Name: order_status_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_status_history_id_seq OWNED BY public.order_status_history.id;


--
-- TOC entry 228 (class 1259 OID 17912)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    order_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id bigint NOT NULL,
    driver_id bigint,
    pickup_area_id bigint NOT NULL,
    dropoff_area_id bigint NOT NULL,
    pickup_address text NOT NULL,
    dropoff_address text NOT NULL,
    total_cost numeric(12,2) NOT NULL,
    status public.order_status DEFAULT 'requested'::public.order_status NOT NULL,
    requested_at timestamp with time zone DEFAULT now(),
    accepted_at timestamp with time zone,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    canceled_at timestamp with time zone,
    rating numeric(3,2)
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17911)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 232 (class 1259 OID 17976)
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_sessions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    session_token uuid DEFAULT gen_random_uuid() NOT NULL,
    device_info text,
    ip_address inet,
    login_at timestamp with time zone DEFAULT now(),
    last_activity_at timestamp with time zone,
    logout_at timestamp with time zone
);


ALTER TABLE public.user_sessions OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17975)
-- Name: user_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_sessions_id_seq OWNER TO postgres;

--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 231
-- Name: user_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_sessions_id_seq OWNED BY public.user_sessions.id;


--
-- TOC entry 220 (class 1259 OID 17842)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    role public.user_role NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(20),
    password_hash text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17841)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4910 (class 2604 OID 17906)
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas ALTER COLUMN id SET DEFAULT nextval('public.areas_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 17865)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4920 (class 2604 OID 17998)
-- Name: driver_monthly_stats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_monthly_stats ALTER COLUMN id SET DEFAULT nextval('public.driver_monthly_stats_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 17885)
-- Name: drivers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers ALTER COLUMN id SET DEFAULT nextval('public.drivers_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 17956)
-- Name: order_status_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_history ALTER COLUMN id SET DEFAULT nextval('public.order_status_history_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 17915)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 17979)
-- Name: user_sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions ALTER COLUMN id SET DEFAULT nextval('public.user_sessions_id_seq'::regclass);


--
-- TOC entry 4900 (class 2604 OID 17845)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5117 (class 0 OID 17903)
-- Dependencies: 226
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, name, city, latitude, longitude) FROM stdin;
1	Tegalsari	Surabaya	-7.263100	112.742500
2	Wonokromo	Surabaya	-7.296100	112.736400
3	Rungkut	Surabaya	-7.323900	112.771200
4	Sukolilo	Surabaya	-7.290300	112.787400
5	Genteng	Surabaya	-7.261400	112.744900
6	Sawahan	Surabaya	-7.265800	112.726800
7	Gubeng	Surabaya	-7.274600	112.758600
8	Mulyorejo	Surabaya	-7.280500	112.799300
9	Kenjeran	Surabaya	-7.211000	112.759400
10	Karangpilang	Surabaya	-7.329200	112.690900
11	Tunjungan Plaza	Surabaya	-7.263500	112.737800
12	Grand City Mall	Surabaya	-7.260700	112.749000
13	Galaxy Mall	Surabaya	-7.284100	112.776900
14	Pakuwon Mall	Surabaya	-7.290200	112.659900
15	ITS Sukolilo	Surabaya	-7.281100	112.795700
16	Universitas Airlangga Kampus B	Surabaya	-7.274300	112.758100
17	Pelabuhan Tanjung Perak	Surabaya	-7.207000	112.733800
18	Kebun Binatang Surabaya	Surabaya	-7.296600	112.737100
19	BG Junction Mall	Surabaya	-7.257800	112.731600
20	Lenmarc Mall	Surabaya	-7.295700	112.671200
21	Ciputra World	Surabaya	-7.292500	112.734200
22	Terminal Joyoboyo	Surabaya	-7.296900	112.733400
23	Alun-Alun Sidoarjo	Sidoarjo	-7.447700	112.718300
24	Gading Fajar	Sidoarjo	-7.437200	112.700200
25	Waru	Sidoarjo	-7.357400	112.730600
26	Buduran	Sidoarjo	-7.427100	112.758500
27	Taman	Sidoarjo	-7.366900	112.717300
28	Krian	Sidoarjo	-7.409100	112.582100
29	Terminal Purabaya (Bungurasih)	Sidoarjo	-7.349000	112.731200
\.


--
-- TOC entry 5113 (class 0 OID 17862)
-- Dependencies: 222
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, user_id, profile_photo, rating, total_orders) FROM stdin;
1	1	profile1.jpg	4.80	12
2	2	profile2.jpg	4.50	8
3	3	profile3.jpg	4.90	15
4	7	profile4.jpg	4.40	6
5	8	profile5.jpg	4.70	10
6	10	profile6.jpg	4.60	9
7	13	profile7.jpg	4.90	14
8	14	profile8.jpg	4.60	7
\.


--
-- TOC entry 5125 (class 0 OID 17995)
-- Dependencies: 234
-- Data for Name: driver_monthly_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.driver_monthly_stats (id, driver_id, year, month, total_earning, total_orders) FROM stdin;
1	1	2025	1	34000.00	2
2	2	2025	1	32000.00	2
3	3	2025	1	33000.00	2
4	4	2025	1	20000.00	1
5	5	2025	1	13000.00	1
6	6	2025	1	22000.00	1
7	7	2025	1	17000.00	1
\.


--
-- TOC entry 5115 (class 0 OID 17882)
-- Dependencies: 224
-- Data for Name: drivers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drivers (id, user_id, profile_photo, vehicle_type, vehicle_model, license_plate, driver_status, rating, monthly_completed_count) FROM stdin;
1	4	driver1.jpg	motor	Honda Beat	L 1234 AA	available	4.90	32
2	5	driver2.jpg	motor	Yamaha NMAX	L 2234 BB	available	4.80	28
3	6	driver3.jpg	motor	Honda Vario	L 3234 CC	on_trip	4.70	20
4	9	driver4.jpg	motor	Scoopy Stylish	L 4455 DD	available	4.60	15
5	11	driver5.jpg	motor	Suzuki Nex	L 5566 EE	offline	4.40	10
6	12	driver6.jpg	motor	Aerox 155	L 6677 FF	available	4.70	18
7	15	driver7.jpg	motor	Honda PCX	L 7788 GG	on_trip	4.90	25
\.


--
-- TOC entry 5121 (class 0 OID 17953)
-- Dependencies: 230
-- Data for Name: order_status_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_status_history (id, order_id, status, changed_by_user_id, note, changed_at) FROM stdin;
1	1	requested	1	Order dibuat	2025-12-05 22:21:55.433636+07
2	1	accepted	4	Driver menerima order	2025-12-05 22:21:55.433636+07
3	1	completed	4	Order selesai	2025-12-05 22:21:55.433636+07
4	2	requested	2	Order dibuat	2025-12-05 22:21:55.433636+07
5	2	accepted	5	Driver menerima order	2025-12-05 22:21:55.433636+07
6	2	completed	5	Order selesai	2025-12-05 22:21:55.433636+07
7	8	requested	1	Order dibuat	2025-12-05 22:21:55.433636+07
8	8	accepted	4	Driver menerima order	2025-12-05 22:21:55.433636+07
9	8	canceled	1	Customer membatalkan	2025-12-05 22:21:55.433636+07
\.


--
-- TOC entry 5119 (class 0 OID 17912)
-- Dependencies: 228
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_uuid, customer_id, driver_id, pickup_area_id, dropoff_area_id, pickup_address, dropoff_address, total_cost, status, requested_at, accepted_at, started_at, completed_at, canceled_at, rating) FROM stdin;
1	10784802-ffff-46b1-bae8-7e6a9fe80d4f	1	1	1	2	Jl. Diponegoro 12	Jl. Wonokromo 88	15000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	5.00
2	8d12b390-e10f-4d0c-b7ca-e6d682c129ef	2	2	3	4	Jl. Rungkut Asri 5	Jl. Sukolilo Baru 7	18000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	4.00
3	4664aa13-fee1-4328-8b3a-951c71a0b1bc	3	3	5	6	Jl. Genteng 14	Jl. Sawahan Indah 20	12000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	5.00
4	569f4004-7591-4182-baf3-1d7983fc66e7	4	4	7	8	Jl. Gubeng Kertajaya 30	Jl. Mulyorejo 21	20000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	5.00
5	45687ddd-4039-46a1-9b7c-86da223fb4e8	5	5	2	1	Jl. Wonokromo 45	Jl. Tegalsari 10	13000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	4.00
6	b5a1b169-cc92-429e-8221-c0d38520b2a2	6	6	9	3	Jl. Kenjeran 50	Jl. Rungkut Madya 14	22000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	5.00
7	e23d5a71-0227-4e30-9d35-346ca0bb5631	7	7	4	5	Jl. Sukolilo Asri	Jl. Genteng Besar 33	17000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	5.00
8	81f57814-d8da-4bb2-92f7-13e15b1ae850	1	1	1	3	Jl. Diponegoro 10	Jl. Rungkut 17	19000.00	canceled	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	\N	2025-12-05 22:21:55.433636+07	\N
9	dd096a0f-522a-4cdd-b885-ceb5d7e6c73c	2	2	6	7	Jl. Sawahan Tengah	Jl. Gubeng 55	14000.00	completed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	4.00
10	3f93a009-d736-4bd2-bb28-0caaaa9ebfa0	3	3	8	9	Jl. Mulyorejo Baru	Jl. Kenjeran 99	21000.00	started	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N	\N	\N
\.


--
-- TOC entry 5123 (class 0 OID 17976)
-- Dependencies: 232
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_sessions (id, user_id, session_token, device_info, ip_address, login_at, last_activity_at, logout_at) FROM stdin;
1	1	c579ef96-8696-41f5-97f9-4212277811ec	Android 12 - Xiaomi	103.22.14.55	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
2	2	787634ee-f7b8-4265-9f41-e4a8908e2d53	iPhone 13	103.22.16.11	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
3	3	4e8bab18-10cf-4753-aada-4d4184408524	Windows 10 Chrome	103.22.18.90	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
4	4	8bbb6c96-e538-4779-a857-219d4002bec8	Android 11 - Oppo	103.22.19.45	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
5	5	f2419a50-e731-4606-9a7a-a7e5c110a450	Android - Samsung	103.22.22.77	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
6	6	c54d0bf6-ea0a-4b2b-8849-ae741acb9e4a	Windows 11 Edge	103.22.24.88	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
7	7	608083d1-b0ae-495e-92d1-6b7db6f3d862	iPhone 14	103.22.26.33	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
8	8	724ad528-5820-43d7-b68b-cac1131ab917	Android - Vivo	103.22.28.12	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
9	10	df409922-ae1a-4c12-bf3a-21c2ed6ccea7	Windows 10 Firefox	103.22.29.44	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
10	13	58d3283a-9050-46d2-a964-8603b311975f	iPad Air	103.22.30.55	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07	\N
\.


--
-- TOC entry 5111 (class 0 OID 17842)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, role, email, phone, password_hash, created_at, updated_at) FROM stdin;
1	Alvin Saputra	customer	alvin@example.com	081234567890	9f2caa82d1efbc2a91ed	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
2	Rizky Pratama	customer	rizky@example.com	081223344556	a12fbe902c1d98ab77c4	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
3	Dewi Lestari	customer	dewi@example.com	081298765432	cfa02ee3b19f11cc8aa2	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
4	Budi Santoso	driver	budi.driver@example.com	081355667788	81cd99af27ab01ddc331	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
5	Raka Firmansyah	driver	raka.driver@example.com	081366778899	7bb129f3dca981eeac01	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
6	Siti Mawar	driver	siti.driver@example.com	081377889900	d912fa70be22c90aa911	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
7	Aditya Putra	customer	aditya@example.com	081212122233	bd1198c0ea83bc772e48	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
8	Nadia Ayu	customer	nadia@example.com	081288899900	c02bc717df00991afde1	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
9	Vina Melati	driver	vina.driver@example.com	081244556677	ef22a981cd78bc1299aa	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
10	Farhan Dwi	customer	farhan@example.com	081297643210	aa33bc19ef01da77be21	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
11	Joko Widodo	driver	joko.driver@example.com	081311112222	f1019ab33cd092aa1fb0	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
12	Tono Prayitno	driver	tono.driver@example.com	081344455566	cb9912fa10bb88ca7711	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
13	Aulia Rahma	customer	aulia@example.com	081299887766	bb1988aacd01ef22cc0f	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
14	Denny Mahendra	customer	denny@example.com	081277712345	dcaa91771ef00bc39a1b	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
15	Lina Agustina	driver	lina.driver@example.com	081288899911	aa01cd9988ef123bb77c	2025-12-05 22:21:55.433636+07	2025-12-05 22:21:55.433636+07
\.


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 225
-- Name: areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.areas_id_seq', 29, true);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 8, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 233
-- Name: driver_monthly_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.driver_monthly_stats_id_seq', 7, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 223
-- Name: drivers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.drivers_id_seq', 7, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 229
-- Name: order_status_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_status_history_id_seq', 9, true);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 10, true);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 231
-- Name: user_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_sessions_id_seq', 10, true);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 15, true);


--
-- TOC entry 4938 (class 2606 OID 17910)
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- TOC entry 4930 (class 2606 OID 17873)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 17875)
-- Name: customers customers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_user_id_key UNIQUE (user_id);


--
-- TOC entry 4951 (class 2606 OID 18006)
-- Name: driver_monthly_stats driver_monthly_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_monthly_stats
    ADD CONSTRAINT driver_monthly_stats_pkey PRIMARY KEY (id);


--
-- TOC entry 4934 (class 2606 OID 17894)
-- Name: drivers drivers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_pkey PRIMARY KEY (id);


--
-- TOC entry 4936 (class 2606 OID 17896)
-- Name: drivers drivers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_user_id_key UNIQUE (user_id);


--
-- TOC entry 4946 (class 2606 OID 17964)
-- Name: order_status_history order_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_history
    ADD CONSTRAINT order_status_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4943 (class 2606 OID 17931)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4949 (class 2606 OID 17988)
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 17858)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4926 (class 2606 OID 17860)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 4928 (class 2606 OID 17856)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4952 (class 1259 OID 18017)
-- Name: idx_driver_monthly_stats_driver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_monthly_stats_driver ON public.driver_monthly_stats USING btree (driver_id);


--
-- TOC entry 4944 (class 1259 OID 18015)
-- Name: idx_order_status_history_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_status_history_order_id ON public.order_status_history USING btree (order_id);


--
-- TOC entry 4939 (class 1259 OID 18012)
-- Name: idx_orders_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_customer_id ON public.orders USING btree (customer_id);


--
-- TOC entry 4940 (class 1259 OID 18013)
-- Name: idx_orders_driver_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_driver_id ON public.orders USING btree (driver_id);


--
-- TOC entry 4941 (class 1259 OID 18014)
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- TOC entry 4947 (class 1259 OID 18016)
-- Name: idx_user_sessions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_sessions_user_id ON public.user_sessions USING btree (user_id);


--
-- TOC entry 4953 (class 2606 OID 17876)
-- Name: customers customers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4962 (class 2606 OID 18007)
-- Name: driver_monthly_stats driver_monthly_stats_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_monthly_stats
    ADD CONSTRAINT driver_monthly_stats_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.drivers(id) ON DELETE CASCADE;


--
-- TOC entry 4954 (class 2606 OID 17897)
-- Name: drivers drivers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4959 (class 2606 OID 17970)
-- Name: order_status_history order_status_history_changed_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_history
    ADD CONSTRAINT order_status_history_changed_by_user_id_fkey FOREIGN KEY (changed_by_user_id) REFERENCES public.users(id);


--
-- TOC entry 4960 (class 2606 OID 17965)
-- Name: order_status_history order_status_history_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_history
    ADD CONSTRAINT order_status_history_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4955 (class 2606 OID 17932)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- TOC entry 4956 (class 2606 OID 17937)
-- Name: orders orders_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.drivers(id) ON DELETE SET NULL;


--
-- TOC entry 4957 (class 2606 OID 17947)
-- Name: orders orders_dropoff_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_dropoff_area_id_fkey FOREIGN KEY (dropoff_area_id) REFERENCES public.areas(id);


--
-- TOC entry 4958 (class 2606 OID 17942)
-- Name: orders orders_pickup_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_area_id_fkey FOREIGN KEY (pickup_area_id) REFERENCES public.areas(id);


--
-- TOC entry 4961 (class 2606 OID 17989)
-- Name: user_sessions user_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-12-06 05:59:29

--
-- PostgreSQL database dump complete
--

\unrestrict WmDI3OkfgZzcFoIAiMjo05j5eNEccCqxQ8iGbodSgIbEdXy3A8PnOo5q3nCuFwH

