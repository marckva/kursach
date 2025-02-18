--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.1

-- Started on 2025-02-11 21:25:08

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

-- Completed on 2025-02-11 21:25:09

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect pharmacy

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.1

-- Started on 2025-02-11 21:25:09

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 16437)
-- Name: basket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.basket (
    basketid bigint NOT NULL,
    quantity integer NOT NULL,
    clientid bigint NOT NULL,
    productid bigint NOT NULL
);


ALTER TABLE public.basket OWNER TO admin;

--
-- TOC entry 222 (class 1259 OID 16434)
-- Name: basket_basketid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.basket_basketid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.basket_basketid_seq OWNER TO admin;

--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 222
-- Name: basket_basketid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.basket_basketid_seq OWNED BY public.basket.basketid;


--
-- TOC entry 223 (class 1259 OID 16435)
-- Name: basket_clientid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.basket_clientid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.basket_clientid_seq OWNER TO admin;

--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 223
-- Name: basket_clientid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.basket_clientid_seq OWNED BY public.basket.clientid;


--
-- TOC entry 224 (class 1259 OID 16436)
-- Name: basket_productid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.basket_productid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.basket_productid_seq OWNER TO admin;

--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 224
-- Name: basket_productid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.basket_productid_seq OWNED BY public.basket.productid;


--
-- TOC entry 221 (class 1259 OID 16425)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    clientid bigint NOT NULL,
    surname character varying,
    name character varying NOT NULL,
    patronymic character varying,
    address character varying,
    phone character varying,
    email character varying,
    userid bigint NOT NULL
);


ALTER TABLE public.client OWNER TO admin;

--
-- TOC entry 219 (class 1259 OID 16423)
-- Name: client_clientid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_clientid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_clientid_seq OWNER TO admin;

--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 219
-- Name: client_clientid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_clientid_seq OWNED BY public.client.clientid;


--
-- TOC entry 220 (class 1259 OID 16424)
-- Name: client_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_userid_seq OWNER TO admin;

--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 220
-- Name: client_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_userid_seq OWNED BY public.client.userid;


--
-- TOC entry 227 (class 1259 OID 16457)
-- Name: infoorder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.infoorder (
    infoorderid bigint NOT NULL,
    quantity integer NOT NULL,
    orderid bigint NOT NULL,
    productid bigint NOT NULL
);


ALTER TABLE public.infoorder OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 16450)
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    orderid bigint NOT NULL,
    address character varying NOT NULL,
    phone character varying NOT NULL,
    email character varying,
    cost numeric NOT NULL,
    clientid bigint NOT NULL
);


ALTER TABLE public."order" OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 16415)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    productid bigint NOT NULL,
    productname character varying NOT NULL,
    description character varying,
    quantity integer NOT NULL,
    price numeric NOT NULL,
    photo character varying
);


ALTER TABLE public.product OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 16414)
-- Name: product_productid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_productid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_productid_seq OWNER TO admin;

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 217
-- Name: product_productid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_productid_seq OWNED BY public.product.productid;


--
-- TOC entry 228 (class 1259 OID 24687)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public."user" OWNER TO admin;

--
-- TOC entry 229 (class 1259 OID 24700)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO admin;

--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 229
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 4739 (class 2604 OID 16440)
-- Name: basket basketid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket ALTER COLUMN basketid SET DEFAULT nextval('public.basket_basketid_seq'::regclass);


--
-- TOC entry 4740 (class 2604 OID 16441)
-- Name: basket clientid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket ALTER COLUMN clientid SET DEFAULT nextval('public.basket_clientid_seq'::regclass);


--
-- TOC entry 4741 (class 2604 OID 16442)
-- Name: basket productid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket ALTER COLUMN productid SET DEFAULT nextval('public.basket_productid_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 16428)
-- Name: client clientid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN clientid SET DEFAULT nextval('public.client_clientid_seq'::regclass);


--
-- TOC entry 4738 (class 2604 OID 16429)
-- Name: client userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN userid SET DEFAULT nextval('public.client_userid_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 16418)
-- Name: product productid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN productid SET DEFAULT nextval('public.product_productid_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 24701)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 4918 (class 0 OID 16437)
-- Dependencies: 225
-- Data for Name: basket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.basket (basketid, quantity, clientid, productid) FROM stdin;
\.


--
-- TOC entry 4914 (class 0 OID 16425)
-- Dependencies: 221
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (clientid, surname, name, patronymic, address, phone, email, userid) FROM stdin;
4	\N	ar	\N	\N	\N	\N	1
\.


--
-- TOC entry 4920 (class 0 OID 16457)
-- Dependencies: 227
-- Data for Name: infoorder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infoorder (infoorderid, quantity, orderid, productid) FROM stdin;
\.


--
-- TOC entry 4919 (class 0 OID 16450)
-- Dependencies: 226
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (orderid, address, phone, email, cost, clientid) FROM stdin;
\.


--
-- TOC entry 4911 (class 0 OID 16415)
-- Dependencies: 218
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (productid, productname, description, quantity, price, photo) FROM stdin;
\.


--
-- TOC entry 4921 (class 0 OID 24687)
-- Dependencies: 228
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, password) FROM stdin;
1	ar	scrypt:32768:8:1$szne3qfV3r966f9v$e5c36ed507f87c64d266f51fdcc5b8cd3a75e8a31342e6ea4b3c93654792e5aac733a27045299e7308f28fa9c7b138d4de96b9ed544671d50d59f1c009eaa4ff
\.


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 222
-- Name: basket_basketid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.basket_basketid_seq', 8, true);


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 223
-- Name: basket_clientid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.basket_clientid_seq', 1, false);


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 224
-- Name: basket_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.basket_productid_seq', 1, false);


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 219
-- Name: client_clientid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_clientid_seq', 4, true);


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 220
-- Name: client_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_userid_seq', 1, false);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 217
-- Name: product_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_productid_seq', 4, true);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 229
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- TOC entry 4749 (class 2606 OID 16444)
-- Name: basket basket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT basket_pkey PRIMARY KEY (basketid);


--
-- TOC entry 4746 (class 2606 OID 16433)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (clientid);


--
-- TOC entry 4756 (class 2606 OID 16461)
-- Name: infoorder infoorder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infoorder
    ADD CONSTRAINT infoorder_pkey PRIMARY KEY (infoorderid);


--
-- TOC entry 4752 (class 2606 OID 16456)
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (orderid);


--
-- TOC entry 4744 (class 2606 OID 16422)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (productid);


--
-- TOC entry 4758 (class 2606 OID 24693)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 4750 (class 1259 OID 24671)
-- Name: fki_clientidOrd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_clientidOrd_fkey" ON public."order" USING btree (clientid);


--
-- TOC entry 4753 (class 1259 OID 24677)
-- Name: fki_orderidInf_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_orderidInf_fkey" ON public.infoorder USING btree (orderid);


--
-- TOC entry 4754 (class 1259 OID 24683)
-- Name: fki_productidInf_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_productidInf_fkey" ON public.infoorder USING btree (productid);


--
-- TOC entry 4747 (class 1259 OID 24699)
-- Name: fki_userid_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_userid_fkey ON public.client USING btree (userid);


--
-- TOC entry 4760 (class 2606 OID 24656)
-- Name: basket clientidB_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT "clientidB_fkey" FOREIGN KEY (clientid) REFERENCES public.client(clientid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4762 (class 2606 OID 24666)
-- Name: order clientidOrd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "clientidOrd_fkey" FOREIGN KEY (clientid) REFERENCES public.client(clientid);


--
-- TOC entry 4763 (class 2606 OID 24672)
-- Name: infoorder orderidInf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infoorder
    ADD CONSTRAINT "orderidInf_fkey" FOREIGN KEY (orderid) REFERENCES public."order"(orderid);


--
-- TOC entry 4761 (class 2606 OID 24661)
-- Name: basket productidB_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT "productidB_fkey" FOREIGN KEY (productid) REFERENCES public.product(productid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4764 (class 2606 OID 24678)
-- Name: infoorder productidInf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.infoorder
    ADD CONSTRAINT "productidInf_fkey" FOREIGN KEY (productid) REFERENCES public.product(productid);


--
-- TOC entry 4759 (class 2606 OID 24694)
-- Name: client userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT userid_fkey FOREIGN KEY (userid) REFERENCES public."user"(id);


-- Completed on 2025-02-11 21:25:09

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-02-11 21:25:09

--
-- PostgreSQL database cluster dump complete
--

