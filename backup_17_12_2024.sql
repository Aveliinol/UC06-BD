--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2024-12-17 13:55:52

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
-- TOC entry 228 (class 1259 OID 24668)
-- Name: chamados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chamados (
    id integer NOT NULL,
    cliente_id integer,
    tecnico_id integer,
    servico_id integer,
    data_chamado date NOT NULL,
    status character varying(20) NOT NULL,
    descricao text NOT NULL,
    CONSTRAINT chamados_status_check CHECK (((status)::text = ANY ((ARRAY['Pendente'::character varying, 'Em andamento'::character varying, 'Finalizado'::character varying])::text[])))
);


ALTER TABLE public.chamados OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24667)
-- Name: chamados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chamados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chamados_id_seq OWNER TO postgres;

--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 227
-- Name: chamados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chamados_id_seq OWNED BY public.chamados.id;


--
-- TOC entry 226 (class 1259 OID 24657)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    telefone character varying(20) NOT NULL,
    data_cadastro date NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24656)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_seq OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 225
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- TOC entry 220 (class 1259 OID 16405)
-- Name: filmes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filmes (
    id integer NOT NULL,
    nome character varying(60) NOT NULL,
    id_genero integer NOT NULL
);


ALTER TABLE public.filmes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16404)
-- Name: filmes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filmes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filmes_id_seq OWNER TO postgres;

--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 219
-- Name: filmes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filmes_id_seq OWNED BY public.filmes.id;


--
-- TOC entry 218 (class 1259 OID 16396)
-- Name: genero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genero (
    id integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.genero OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16395)
-- Name: genero_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genero_id_seq OWNER TO postgres;

--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 217
-- Name: genero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genero_id_seq OWNED BY public.genero.id;


--
-- TOC entry 230 (class 1259 OID 24730)
-- Name: pagamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamentos (
    id integer NOT NULL,
    cliente_id integer,
    chamados_id integer,
    valor_pago numeric(10,2) NOT NULL,
    data_pagamento date NOT NULL,
    forma_de_pagamento character varying(50) NOT NULL,
    CONSTRAINT pagamentos_valor_pago_check CHECK ((valor_pago > (0)::numeric))
);


ALTER TABLE public.pagamentos OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24729)
-- Name: pagamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagamentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagamentos_id_seq OWNER TO postgres;

--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 229
-- Name: pagamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagamentos_id_seq OWNED BY public.pagamentos.id;


--
-- TOC entry 222 (class 1259 OID 24580)
-- Name: servicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicos (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text NOT NULL,
    preco numeric(10,2) NOT NULL,
    tipo_servico character varying(50) NOT NULL
);


ALTER TABLE public.servicos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24579)
-- Name: servicos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicos_id_seq OWNER TO postgres;

--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 221
-- Name: servicos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicos_id_seq OWNED BY public.servicos.id;


--
-- TOC entry 224 (class 1259 OID 24630)
-- Name: tecnico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tecnico (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    especialidade character varying(50) NOT NULL,
    data_contraracao date NOT NULL
);


ALTER TABLE public.tecnico OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24629)
-- Name: tecnico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tecnico_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tecnico_id_seq OWNER TO postgres;

--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 223
-- Name: tecnico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tecnico_id_seq OWNED BY public.tecnico.id;


--
-- TOC entry 4730 (class 2604 OID 24671)
-- Name: chamados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chamados ALTER COLUMN id SET DEFAULT nextval('public.chamados_id_seq'::regclass);


--
-- TOC entry 4729 (class 2604 OID 24660)
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 4726 (class 2604 OID 16408)
-- Name: filmes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmes ALTER COLUMN id SET DEFAULT nextval('public.filmes_id_seq'::regclass);


--
-- TOC entry 4725 (class 2604 OID 16399)
-- Name: genero id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero ALTER COLUMN id SET DEFAULT nextval('public.genero_id_seq'::regclass);


--
-- TOC entry 4731 (class 2604 OID 24733)
-- Name: pagamentos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos ALTER COLUMN id SET DEFAULT nextval('public.pagamentos_id_seq'::regclass);


--
-- TOC entry 4727 (class 2604 OID 24583)
-- Name: servicos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicos ALTER COLUMN id SET DEFAULT nextval('public.servicos_id_seq'::regclass);


--
-- TOC entry 4728 (class 2604 OID 24633)
-- Name: tecnico id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tecnico ALTER COLUMN id SET DEFAULT nextval('public.tecnico_id_seq'::regclass);


--
-- TOC entry 4918 (class 0 OID 24668)
-- Dependencies: 228
-- Data for Name: chamados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chamados (id, cliente_id, tecnico_id, servico_id, data_chamado, status, descricao) FROM stdin;
7	4	1	1	2023-06-01	Pendente	Fiação da casa queimada
8	5	2	2	2023-07-10	Em andamento	Vazamento na tubulação
9	6	3	3	2023-08-05	Finalizado	Reparação no ar-condicionado
10	7	1	2	2023-09-20	Pendente	Manutenção no servidor
11	8	2	1	2023-10-15	Finalizado	Suporte para software
12	4	1	1	2023-06-01	Pendente	Fiação da casa queimada
13	5	2	2	2023-07-10	Em andamento	Vazamento na tubulação
14	6	3	3	2023-08-05	Finalizado	Reparação no ar-condicionado
15	7	1	2	2023-09-20	Pendente	Manutenção no servidor
16	8	2	1	2023-10-15	Finalizado	Suporte para software
\.


--
-- TOC entry 4916 (class 0 OID 24657)
-- Dependencies: 226
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id, nome, email, telefone, data_cadastro) FROM stdin;
4	João Silva	joao@email.com	(11) 98765-4321	2023-01-15
5	Maria Oliveira	maria@email.com	(31) 99654- 3210	2023-02-20
6	Pedro Souza	pedro@email.com	(31) 99765- 1234	2023-03-10
7	Ana Costa	ana@email.com	(41) 98888-9999	2023-04-25
8	Lucas almeida	lucas@email.com	(61) 99123-4567	2023-05-30
\.


--
-- TOC entry 4910 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: filmes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filmes (id, nome, id_genero) FROM stdin;
37	it a coisa	2
38	moana	1
42	jhgfjhgf	1
43	pato donald	1
\.


--
-- TOC entry 4908 (class 0 OID 16396)
-- Dependencies: 218
-- Data for Name: genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genero (id, nome) FROM stdin;
1	Animação
2	Terror
3	Ação
4	Drama
5	Comedia
6	Ducumentario
7	suspense
\.


--
-- TOC entry 4920 (class 0 OID 24730)
-- Dependencies: 230
-- Data for Name: pagamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagamentos (id, cliente_id, chamados_id, valor_pago, data_pagamento, forma_de_pagamento) FROM stdin;
9	4	7	350.00	2023-06-15	Cartão de Crédito
10	5	8	450.00	2023-07-15	Cartão de Crédito
11	6	9	600.00	2023-08-10	Cartão de Crédito
12	7	10	300.00	2023-09-25	Cartão de Crédito
\.


--
-- TOC entry 4912 (class 0 OID 24580)
-- Dependencies: 222
-- Data for Name: servicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servicos (id, nome, descricao, preco, tipo_servico) FROM stdin;
1	Consultoria em TI	Consultoria especializada em infraestrutura de TI	500.00	Consultoria
2	Manutenção de Equipamentos	Manutenção preventiva e corretiva de equipamentos	300.00	Manutenção
3	Suporte Técnico	Suporte remoto e presencial para empresas	200.00	Suporte
\.


--
-- TOC entry 4914 (class 0 OID 24630)
-- Dependencies: 224
-- Data for Name: tecnico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tecnico (id, nome, especialidade, data_contraracao) FROM stdin;
1	Carlos Oliveira	Consultoria TI	2022-10-10
2	Fernanda Souza	Manutenção	2021-06-15
3	Roberto Costa	Suporte Técnico	2020-08-20
\.


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 227
-- Name: chamados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chamados_id_seq', 16, true);


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 225
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_seq', 8, true);


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 219
-- Name: filmes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filmes_id_seq', 45, true);


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 217
-- Name: genero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genero_id_seq', 11, true);


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 229
-- Name: pagamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagamentos_id_seq', 12, true);


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 221
-- Name: servicos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicos_id_seq', 3, true);


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 223
-- Name: tecnico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tecnico_id_seq', 3, true);


--
-- TOC entry 4753 (class 2606 OID 24676)
-- Name: chamados chamados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chamados
    ADD CONSTRAINT chamados_pkey PRIMARY KEY (id);


--
-- TOC entry 4747 (class 2606 OID 24664)
-- Name: cliente cliente_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_email_key UNIQUE (email);


--
-- TOC entry 4749 (class 2606 OID 24662)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 24666)
-- Name: cliente cliente_telefone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_telefone_key UNIQUE (telefone);


--
-- TOC entry 4739 (class 2606 OID 16410)
-- Name: filmes filmes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmes
    ADD CONSTRAINT filmes_pkey PRIMARY KEY (id);


--
-- TOC entry 4735 (class 2606 OID 16403)
-- Name: genero genero_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_nome_key UNIQUE (nome);


--
-- TOC entry 4737 (class 2606 OID 16401)
-- Name: genero genero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_pkey PRIMARY KEY (id);


--
-- TOC entry 4741 (class 2606 OID 16417)
-- Name: filmes nome_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmes
    ADD CONSTRAINT nome_unique UNIQUE (nome);


--
-- TOC entry 4755 (class 2606 OID 24736)
-- Name: pagamentos pagamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT pagamentos_pkey PRIMARY KEY (id);


--
-- TOC entry 4743 (class 2606 OID 24587)
-- Name: servicos servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_pkey PRIMARY KEY (id);


--
-- TOC entry 4745 (class 2606 OID 24635)
-- Name: tecnico tecnico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tecnico
    ADD CONSTRAINT tecnico_pkey PRIMARY KEY (id);


--
-- TOC entry 4760 (class 2606 OID 24742)
-- Name: pagamentos fk_chamados; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT fk_chamados FOREIGN KEY (chamados_id) REFERENCES public.chamados(id) ON DELETE CASCADE;


--
-- TOC entry 4757 (class 2606 OID 24677)
-- Name: chamados fk_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chamados
    ADD CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(id) ON DELETE CASCADE;


--
-- TOC entry 4761 (class 2606 OID 24737)
-- Name: pagamentos fk_cliente_pagamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT fk_cliente_pagamento FOREIGN KEY (cliente_id) REFERENCES public.cliente(id) ON DELETE CASCADE;


--
-- TOC entry 4756 (class 2606 OID 16411)
-- Name: filmes fk_genero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmes
    ADD CONSTRAINT fk_genero FOREIGN KEY (id_genero) REFERENCES public.genero(id);


--
-- TOC entry 4758 (class 2606 OID 24687)
-- Name: chamados fk_servico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chamados
    ADD CONSTRAINT fk_servico FOREIGN KEY (servico_id) REFERENCES public.servicos(id) ON DELETE CASCADE;


--
-- TOC entry 4759 (class 2606 OID 24682)
-- Name: chamados fk_tecnico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chamados
    ADD CONSTRAINT fk_tecnico FOREIGN KEY (tecnico_id) REFERENCES public.tecnico(id) ON DELETE CASCADE;


-- Completed on 2024-12-17 13:55:52

--
-- PostgreSQL database dump complete
--

