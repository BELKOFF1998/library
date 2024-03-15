--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-03-14 14:19:17

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
-- TOC entry 4869 (class 0 OID 0)
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
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN "Post".post; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Post".post IS 'название должности сотрудника';


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN "Post".salary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Post".salary IS 'оклад данной должности';


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
-- TOC entry 217 (class 1259 OID 16439)
-- Name: visitor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitor (
    id_visitor integer NOT NULL,
    birth_data date,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    email character varying(50),
    phone_number integer NOT NULL,
    id_pasport integer
);


ALTER TABLE public.visitor OWNER TO postgres;

--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.birth_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.birth_data IS 'дата рождения посетителя';


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.last_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.last_name IS 'Фамилия посетителя';


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.first_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.first_name IS 'имя посетителя';


--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.email IS 'электронная почта посетителя';


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.phone_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.phone_number IS 'номер телефона посетителя';


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.id_pasport; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.visitor.id_pasport IS 'ссылка на запись с паспортными данными';


--
-- TOC entry 227 (class 1259 OID 16639)
-- Name: Visitor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.visitor ALTER COLUMN id_visitor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Visitor_id_seq"
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
    birth_year integer,
    last_name character varying(50),
    first_name character varying(50),
    country character varying(50),
    id_author integer NOT NULL
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE author; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.author IS 'Таблица авторов книг';


--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN author.birth_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.author.birth_year IS 'год рождения автора';


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN author.last_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.author.last_name IS 'фамилия автора';


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN author.first_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.author.first_name IS 'имя автора';


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN author.country; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.author.country IS 'страна происхождения автора';


--
-- TOC entry 226 (class 1259 OID 16628)
-- Name: author_id_author_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.author ALTER COLUMN id_author ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.author_id_author_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16418)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    id_author integer,
    book_name character varying(50) NOT NULL,
    genre character varying(50),
    pages_number integer,
    original_language character varying(50),
    writing_year integer,
    id_isbn character varying(30),
    id_book integer NOT NULL
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE book; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.book IS 'Таблица книг, одна значение - конкретное издание книги';


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.id_author; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.id_author IS 'ссылка на данные об авторе';


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.book_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.book_name IS 'название книги';


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.genre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.genre IS 'жанр';


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.pages_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.pages_number IS 'количество страниц в книге';


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.original_language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.original_language IS 'язык оригинала книги';


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.writing_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.writing_year IS 'год написания книги';


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.id_isbn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book.id_isbn IS 'уникальный код хранящий в себе данные о конкретном издании книги';


--
-- TOC entry 229 (class 1259 OID 16694)
-- Name: book_id_book_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book ALTER COLUMN id_book ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_id_book_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16500)
-- Name: book_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_list (
    id_entry integer NOT NULL,
    id_book integer NOT NULL,
    returned boolean DEFAULT false,
    return_data date NOT NULL,
    id_book_list integer NOT NULL
);


ALTER TABLE public.book_list OWNER TO postgres;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE book_list; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.book_list IS 'вспомогательная таблица хранящая соотношения кник к конкретной записи в таблице entry';


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN book_list.id_entry; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book_list.id_entry IS 'номер записи';


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN book_list.id_book; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book_list.id_book IS 'номер книги, которую взяли по записи';


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN book_list.returned; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book_list.returned IS 'метка обозначающая вернули ли книгу по этой записи';


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN book_list.return_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.book_list.return_data IS 'дата до которой необходимо вернуть книгу';


--
-- TOC entry 230 (class 1259 OID 16706)
-- Name: book_list_id_book_list_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.book_list ALTER COLUMN id_book_list ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.book_list_id_book_list_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16472)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id_employee integer NOT NULL,
    birth_data character varying,
    last_name character varying(50),
    first_name character varying(50),
    id_post integer,
    id_pasport integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN employee.birth_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.employee.birth_data IS 'дата рождения сотрудника';


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN employee.last_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.employee.last_name IS 'фамилия сотрудника';


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN employee.first_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.employee.first_name IS 'имя сотрудника';


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN employee.id_post; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.employee.id_post IS 'ссылка на должность сотрудника';


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN employee.id_pasport; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.employee.id_pasport IS 'ссылка на паспортные данные сотрудника';


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
    data timestamp without time zone NOT NULL,
    id_visitor integer NOT NULL,
    id_employee integer NOT NULL,
    id_entry integer NOT NULL
);


ALTER TABLE public.entry OWNER TO postgres;

--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN entry.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.entry.data IS 'время когда взяли книги';


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN entry.id_visitor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.entry.id_visitor IS 'ссылка на данные посетителя';


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN entry.id_employee; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.entry.id_employee IS 'ссылка на данные работника библиотека который оформил книги';


--
-- TOC entry 231 (class 1259 OID 16712)
-- Name: entry_id_entry_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.entry ALTER COLUMN id_entry ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.entry_id_entry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16548)
-- Name: isbn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.isbn (
    id_isbn character varying(30) NOT NULL,
    publisher character varying(50),
    country character varying(50),
    language character varying(50),
    publication_year integer
);


ALTER TABLE public.isbn OWNER TO postgres;

--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN isbn.publisher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.isbn.publisher IS 'название издателя';


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN isbn.country; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.isbn.country IS 'страна в которой находится издатель';


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN isbn.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.isbn.language IS 'язык на который переведена книга в данном издании';


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN isbn.publication_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.isbn.publication_year IS 'год публикации книги';


--
-- TOC entry 225 (class 1259 OID 16595)
-- Name: pasport_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasport_details (
    series character varying(10),
    number character varying(10),
    departament_code character varying(50),
    id_pasport integer NOT NULL
);


ALTER TABLE public.pasport_details OWNER TO postgres;

--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE pasport_details; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.pasport_details IS 'таблица паспортных данных';


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN pasport_details.series; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pasport_details.series IS 'серия паспорта';


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN pasport_details.number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pasport_details.number IS 'номер паспорта';


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN pasport_details.departament_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pasport_details.departament_code IS 'код отдела который выдал паспорт';


--
-- TOC entry 228 (class 1259 OID 16678)
-- Name: pasport_details_id_pasport_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pasport_details ALTER COLUMN id_pasport ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pasport_details_id_pasport_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4847 (class 0 OID 16399)
-- Dependencies: 215
-- Data for Name: Post; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4855 (class 0 OID 16524)
-- Dependencies: 223
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4848 (class 0 OID 16418)
-- Dependencies: 216
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4854 (class 0 OID 16500)
-- Dependencies: 222
-- Data for Name: book_list; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4852 (class 0 OID 16472)
-- Dependencies: 220
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4853 (class 0 OID 16484)
-- Dependencies: 221
-- Data for Name: entry; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4856 (class 0 OID 16548)
-- Dependencies: 224
-- Data for Name: isbn; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4857 (class 0 OID 16595)
-- Dependencies: 225
-- Data for Name: pasport_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4849 (class 0 OID 16439)
-- Dependencies: 217
-- Data for Name: visitor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 218
-- Name: Post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Post_id_seq"', 1, false);


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 227
-- Name: Visitor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Visitor_id_seq"', 1, false);


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 226
-- Name: author_id_author_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.author_id_author_seq', 1, false);


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 229
-- Name: book_id_book_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_id_book_seq', 1, false);


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 230
-- Name: book_list_id_book_list_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_list_id_book_list_seq', 1, false);


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 219
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_id_seq', 1, false);


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 231
-- Name: entry_id_entry_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entry_id_entry_seq', 1, false);


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 228
-- Name: pasport_details_id_pasport_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pasport_details_id_pasport_seq', 1, false);


--
-- TOC entry 4690 (class 2606 OID 16633)
-- Name: author author_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pk PRIMARY KEY (id_author);


--
-- TOC entry 4688 (class 2606 OID 16711)
-- Name: book_list book_list_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_list
    ADD CONSTRAINT book_list_pk PRIMARY KEY (id_book_list);


--
-- TOC entry 4678 (class 2606 OID 16700)
-- Name: book book_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pk PRIMARY KEY (id_book);


--
-- TOC entry 4680 (class 2606 OID 16647)
-- Name: book book_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_unique UNIQUE (id_isbn);


--
-- TOC entry 4684 (class 2606 OID 16579)
-- Name: employee employee_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pk PRIMARY KEY (id_employee);


--
-- TOC entry 4686 (class 2606 OID 16717)
-- Name: entry entry_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entry
    ADD CONSTRAINT entry_pk PRIMARY KEY (id_entry);


--
-- TOC entry 4692 (class 2606 OID 16655)
-- Name: isbn isbn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.isbn
    ADD CONSTRAINT isbn_pk PRIMARY KEY (id_isbn);


--
-- TOC entry 4694 (class 2606 OID 16683)
-- Name: pasport_details pasport_details_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasport_details
    ADD CONSTRAINT pasport_details_pk PRIMARY KEY (id_pasport);


--
-- TOC entry 4676 (class 2606 OID 16470)
-- Name: Post post_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT post_pk PRIMARY KEY (id_post);


--
-- TOC entry 4682 (class 2606 OID 16445)
-- Name: visitor visitor_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor
    ADD CONSTRAINT visitor_pk PRIMARY KEY (id_visitor);


--
-- TOC entry 4695 (class 2606 OID 16634)
-- Name: book book_author_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_author_fk FOREIGN KEY (id_author) REFERENCES public.author(id_author);


--
-- TOC entry 4696 (class 2606 OID 16660)
-- Name: book book_isbn_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_isbn_fk FOREIGN KEY (id_isbn) REFERENCES public.isbn(id_isbn);


--
-- TOC entry 4702 (class 2606 OID 16701)
-- Name: book_list book_list_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_list
    ADD CONSTRAINT book_list_book_fk FOREIGN KEY (id_book) REFERENCES public.book(id_book);


--
-- TOC entry 4703 (class 2606 OID 16718)
-- Name: book_list book_list_entry_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_list
    ADD CONSTRAINT book_list_entry_fk FOREIGN KEY (id_entry) REFERENCES public.entry(id_entry);


--
-- TOC entry 4698 (class 2606 OID 16689)
-- Name: employee employee_pasport_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pasport_details_fk FOREIGN KEY (id_pasport) REFERENCES public.pasport_details(id_pasport);


--
-- TOC entry 4699 (class 2606 OID 16515)
-- Name: employee employee_post_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_post_fk FOREIGN KEY (id_post) REFERENCES public."Post"(id_post);


--
-- TOC entry 4700 (class 2606 OID 16580)
-- Name: entry entry_employee_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entry
    ADD CONSTRAINT entry_employee_fk FOREIGN KEY (id_employee) REFERENCES public.employee(id_employee);


--
-- TOC entry 4701 (class 2606 OID 16490)
-- Name: entry entry_visitor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entry
    ADD CONSTRAINT entry_visitor_fk FOREIGN KEY (id_visitor) REFERENCES public.visitor(id_visitor);


--
-- TOC entry 4697 (class 2606 OID 16684)
-- Name: visitor visitor_pasport_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor
    ADD CONSTRAINT visitor_pasport_details_fk FOREIGN KEY (id_pasport) REFERENCES public.pasport_details(id_pasport);


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE visitor; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.visitor TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE public.visitor TO employee;


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE author; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.author TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE public.author TO employee;


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE book; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.book TO guest;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.book TO employee;


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE book_list; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.book_list TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE public.book_list TO employee;


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE employee; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.employee TO employee;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE entry; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.entry TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE public.entry TO employee;


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 221 4909
-- Name: COLUMN entry.id_entry; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT(id_entry) ON TABLE public.entry TO guest;
GRANT SELECT(id_entry) ON TABLE public.entry TO employee;


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE isbn; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.isbn TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE public.isbn TO employee;


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE pasport_details; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.pasport_details TO employee;


--
-- TOC entry 2077 (class 826 OID 16676)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT ON TABLES TO employee;


-- Completed on 2024-03-14 14:19:17

--
-- PostgreSQL database dump complete
--

