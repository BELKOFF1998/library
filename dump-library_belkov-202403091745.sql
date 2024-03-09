--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-03-09 17:45:02

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: Post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Post" (
    id_post integer NOT NULL,
    post character varying(30),
    salary integer
);


ALTER TABLE public."Post" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16465)
-- Name: Post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Post" ALTER COLUMN id_post ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Post_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16524)
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    id_author integer NOT NULL,
    birth_year integer,
    last_name character varying(50),
    first_name character varying(50),
    country character varying(50)
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE author; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.author IS 'Таблица авторов книг';


--
-- TOC entry 216 (class 1259 OID 16418)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    id_book integer NOT NULL,
    author integer,
    book_name character varying(50),
    genre character varying(50),
    pages_number integer,
    original_language character varying(50),
    writing_year integer,
    isbn integer NOT NULL
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE book; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.book IS 'Таблица книг, одна значение - конкретное издание книги';


--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.isbn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.isbn IS 'уникальный код хранящий в себе данные о конкретном издании книги';


--
-- TOC entry 222 (class 1259 OID 16500)
-- Name: book_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_list (
    id_book_list integer NOT NULL,
    entry_id integer,
    book_id integer
);


ALTER TABLE public.book_list OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16472)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id_employee integer NOT NULL,
    birth_data character varying,
    last_name character varying(50),
    first_name character varying(50),
    post integer,
    pasport_details integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16471)
-- Name: employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employee ALTER COLUMN id_employee ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16484)
-- Name: entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entry (
    id_entry integer NOT NULL,
    data timestamp without time zone,
    recipient integer,
    returned boolean DEFAULT false,
    librarian integer
);


ALTER TABLE public.entry OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16548)
-- Name: isbn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.isbn (
    id_isbn integer NOT NULL,
    publisher character varying(50),
    country character varying(50),
    language character varying(50)
);


ALTER TABLE public.isbn OWNER TO postgres;

--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN isbn.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.isbn.language IS 'язык на который переведена книга в данном издании';


--
-- TOC entry 225 (class 1259 OID 16595)
-- Name: pasport_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasport_details (
    id_pasport integer NOT NULL,
    series integer,
    number integer,
    departament_code character varying(50)
);


ALTER TABLE public.pasport_details OWNER TO postgres;

--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE pasport_details; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.pasport_details IS 'таблица паспортных данных';


--
-- TOC entry 217 (class 1259 OID 16439)
-- Name: visitor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitor (
    id_visitor integer NOT NULL,
    birth_data character varying,
    last_name character varying(50),
    first_name character varying(50),
    email character varying(50),
    phone_number integer,
    pasport_details integer
);


ALTER TABLE public.visitor OWNER TO postgres;

--
-- TOC entry 4840 (class 0 OID 16399)
-- Dependencies: 215
-- Data for Name: Post; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4848 (class 0 OID 16524)
-- Dependencies: 223
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4841 (class 0 OID 16418)
-- Dependencies: 216
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4847 (class 0 OID 16500)
-- Dependencies: 222
-- Data for Name: book_list; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4845 (class 0 OID 16472)
-- Dependencies: 220
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4846 (class 0 OID 16484)
-- Dependencies: 221
-- Data for Name: entry; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4849 (class 0 OID 16548)
-- Dependencies: 224
-- Data for Name: isbn; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4850 (class 0 OID 16595)
-- Dependencies: 225
-- Data for Name: pasport_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4842 (class 0 OID 16439)
-- Dependencies: 217
-- Data for Name: visitor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 218
-- Name: Post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Post_id_seq"', 1, false);


--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 219
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_id_seq', 1, false);


--
-- TOC entry 4683 (class 2606 OID 16528)
-- Name: author author_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pk PRIMARY KEY (id_author);


--
-- TOC entry 4681 (class 2606 OID 16576)
-- Name: book_list book_list_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_list
    ADD CONSTRAINT book_list_pk PRIMARY KEY (id_book_list);


--
-- TOC entry 4671 (class 2606 OID 16564)
-- Name: book book_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pk PRIMARY KEY (id_book);


--
-- TOC entry 4673 (class 2606 OID 16530)
-- Name: book book_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_unique UNIQUE (isbn);


--
-- TOC entry 4677 (class 2606 OID 16579)
-- Name: employee employee_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pk PRIMARY KEY (id_employee);


--
-- TOC entry 4679 (class 2606 OID 16489)
-- Name: entry entry_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entry
    ADD CONSTRAINT entry_pk PRIMARY KEY (id_entry);


--
-- TOC entry 4685 (class 2606 OID 16552)
-- Name: isbn isbn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.isbn
    ADD CONSTRAINT isbn_pk PRIMARY KEY (id_isbn);


--
-- TOC entry 4687 (class 2606 OID 16599)
-- Name: pasport_details pasport_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasport_details
    ADD CONSTRAINT pasport_details_pk PRIMARY KEY (id_pasport);


--
-- TOC entry 4669 (class 2606 OID 16470)
-- Name: Post post_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT post_pk PRIMARY KEY (id_post);


--
-- TOC entry 4675 (class 2606 OID 16445)
-- Name: visitor visitor_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor
    ADD CONSTRAINT visitor_pk PRIMARY KEY (id_visitor);


--
-- TOC entry 4688 (class 2606 OID 16558)
-- Name: book book_author_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_author_fk FOREIGN KEY (author) REFERENCES public.author(id_author);


--
-- TOC entry 4689 (class 2606 OID 16570)
-- Name: book book_isbn_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_isbn_fk FOREIGN KEY (isbn) REFERENCES public.isbn(id_isbn);


--
-- TOC entry 4695 (class 2606 OID 16590)
-- Name: book_list book_list_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_list
    ADD CONSTRAINT book_list_book_fk FOREIGN KEY (book_id) REFERENCES public.book(id_book);


--
-- TOC entry 4696 (class 2606 OID 16585)
-- Name: book_list book_list_entry_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_list
    ADD CONSTRAINT book_list_entry_fk FOREIGN KEY (entry_id) REFERENCES public.entry(id_entry);


--
-- TOC entry 4691 (class 2606 OID 16605)
-- Name: employee employee_pasport_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pasport_details_fk FOREIGN KEY (pasport_details) REFERENCES public.pasport_details(id_pasport);


--
-- TOC entry 4692 (class 2606 OID 16515)
-- Name: employee employee_post_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_post_fk FOREIGN KEY (post) REFERENCES public."Post"(id_post);


--
-- TOC entry 4693 (class 2606 OID 16580)
-- Name: entry entry_employee_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entry
    ADD CONSTRAINT entry_employee_fk FOREIGN KEY (librarian) REFERENCES public.employee(id_employee);


--
-- TOC entry 4694 (class 2606 OID 16490)
-- Name: entry entry_visitor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entry
    ADD CONSTRAINT entry_visitor_fk FOREIGN KEY (recipient) REFERENCES public.visitor(id_visitor);


--
-- TOC entry 4690 (class 2606 OID 16600)
-- Name: visitor visitor_pasport_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor
    ADD CONSTRAINT visitor_pasport_details_fk FOREIGN KEY (pasport_details) REFERENCES public.pasport_details(id_pasport);


-- Completed on 2024-03-09 17:45:02

--
-- PostgreSQL database dump complete
--

