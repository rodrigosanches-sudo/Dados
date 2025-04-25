--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Postgres.app)
-- Dumped by pg_dump version 16.2 (Postgres.app)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: tbl_cliente_contatos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_cliente_contatos (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    tipo_contato_id integer NOT NULL,
    contato character varying(255) NOT NULL
);


ALTER TABLE public.tbl_cliente_contatos OWNER TO postgres;

--
-- Name: tbl_cliente_contatos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_cliente_contatos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_cliente_contatos_id_seq OWNER TO postgres;

--
-- Name: tbl_cliente_contatos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_cliente_contatos_id_seq OWNED BY public.tbl_cliente_contatos.id;


--
-- Name: tbl_cliente_contratos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_cliente_contratos (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    plano_id integer NOT NULL,
    dia_vencimento integer NOT NULL,
    isento boolean DEFAULT false NOT NULL,
    endereco_logradouro character varying(255) NOT NULL,
    endereco_numero character varying(15),
    endereco_bairro character varying(255) NOT NULL,
    endereco_cidade character varying(255) NOT NULL,
    endereco_complemento character varying(500),
    endereco_cep character varying(9) NOT NULL,
    endereco_uf character varying(2) NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.tbl_cliente_contratos OWNER TO postgres;

--
-- Name: tbl_cliente_contratos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_cliente_contratos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_cliente_contratos_id_seq OWNER TO postgres;

--
-- Name: tbl_cliente_contratos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_cliente_contratos_id_seq OWNED BY public.tbl_cliente_contratos.id;


--
-- Name: tbl_clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_clientes (
    id bigint NOT NULL,
    nome_razao_social character varying(255) NOT NULL,
    nome_fantasia character varying(255),
    cpf_cnpj character varying(18) NOT NULL,
    data_nascimento date,
    data_cadastro timestamp without time zone
);


ALTER TABLE public.tbl_clientes OWNER TO postgres;

--
-- Name: tbl_clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_clientes_id_seq OWNER TO postgres;

--
-- Name: tbl_clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_clientes_id_seq OWNED BY public.tbl_clientes.id;


--
-- Name: tbl_planos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_planos (
    id integer NOT NULL,
    descricao character varying(255) NOT NULL,
    valor numeric(15,2) NOT NULL
);


ALTER TABLE public.tbl_planos OWNER TO postgres;

--
-- Name: tbl_planos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_planos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_planos_id_seq OWNER TO postgres;

--
-- Name: tbl_planos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_planos_id_seq OWNED BY public.tbl_planos.id;


--
-- Name: tbl_status_contrato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_status_contrato (
    id integer NOT NULL,
    status character varying(50) NOT NULL
);


ALTER TABLE public.tbl_status_contrato OWNER TO postgres;

--
-- Name: tbl_status_contrato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_status_contrato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_status_contrato_id_seq OWNER TO postgres;

--
-- Name: tbl_status_contrato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_status_contrato_id_seq OWNED BY public.tbl_status_contrato.id;


--
-- Name: tbl_tipos_contato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_tipos_contato (
    id integer NOT NULL,
    tipo_contato character varying(50) NOT NULL
);


ALTER TABLE public.tbl_tipos_contato OWNER TO postgres;

--
-- Name: tbl_tipos_contato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_tipos_contato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_tipos_contato_id_seq OWNER TO postgres;

--
-- Name: tbl_tipos_contato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_tipos_contato_id_seq OWNED BY public.tbl_tipos_contato.id;

-- Data for tbl_cliente_contatos
COPY public.tbl_cliente_contatos (id, cliente_id, tipo_contato_id, contato) FROM stdin;

-- Data for tbl_cliente_contratos
COPY public.tbl_cliente_contratos (id, cliente_id, plano_id, dia_vencimento, isento, endereco_logradouro, endereco_numero, endereco_bairro, endereco_cidade, endereco_complemento, endereco_cep, endereco_uf, status_id) FROM stdin;

-- Data for tbl_clientes
COPY public.tbl_clientes (id, nome_razao_social, nome_fantasia, cpf_cnpj, data_nascimento, data_cadastro) FROM stdin;

-- Data for tbl_planos
COPY public.tbl_planos (id, descricao, valor) FROM stdin;

-- Data for tbl_status_contrato
COPY public.tbl_status_contrato (id, status) FROM stdin;

-- Data for tbl_tipos_contato
COPY public.tbl_tipos_contato (id, tipo_contato) FROM stdin;

-- Define sequences to be reset
SELECT pg_catalog.setval('public.tbl_cliente_contatos_id_seq', 1, false);
SELECT pg_catalog.setval('public.tbl_cliente_contratos_id_seq', 1, false);
SELECT pg_catalog.setval('public.tbl_clientes_id_seq', 1, false);
SELECT pg_catalog.setval('public.tbl_planos_id_seq', 1, false);
SELECT pg_catalog.setval('public.tbl_status_contrato_id_seq', 4, true);
SELECT pg_catalog.setval('public.tbl_tipos_contato_id_seq', 3, true);

-- Define constraints
ALTER TABLE ONLY public.tbl_cliente_contatos
    ADD CONSTRAINT tbl_cliente_contatos_cliente_id_tipo_contato_id_contato_key UNIQUE (cliente_id, tipo_contato_id, contato);
ALTER TABLE ONLY public.tbl_cliente_contatos
    ADD CONSTRAINT tbl_cliente_contatos_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tbl_cliente_contratos
    ADD CONSTRAINT tbl_cliente_contratos_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tbl_clientes
    ADD CONSTRAINT tbl_clientes_cpf_cnpj_key UNIQUE (cpf_cnpj);
ALTER TABLE ONLY public.tbl_clientes
    ADD CONSTRAINT tbl_clientes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tbl_planos
    ADD CONSTRAINT tbl_planos_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tbl_status_contrato
    ADD CONSTRAINT tbl_status_contrato_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.tbl_tipos_contato
    ADD CONSTRAINT tbl_tipos_contato_pkey PRIMARY KEY (id);
