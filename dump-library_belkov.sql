--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-03-18 12:14:10

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
-- Name: libraryShema; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA libraryShema;


ALTER SCHEMA libraryShema OWNER TO pg_database_owner;

--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA libraryShema; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA libraryShema IS 'standard library schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: Post; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema."Post" (
    id_post integer NOT NULL,
    post character varying(30),
    salary integer
);


ALTER TABLE libraryShema."Post" OWNER TO postgres;

--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN "Post".post; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema."Post".post IS 'название должности сотрудника';


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN "Post".salary; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema."Post".salary IS 'оклад данной должности';


--
-- TOC entry 218 (class 1259 OID 16465)
-- Name: Post_id_seq; Type: SEQUENCE; Schema: libraryShema; Owner: postgres
--

ALTER TABLE libraryShema."Post" ALTER COLUMN id_post ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema."Post_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16524)
-- Name: author; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.author (
    birth_year integer,
    last_name character varying(50),
    first_name character varying(50),
    country character varying(50),
    id_author integer NOT NULL
);


ALTER TABLE libraryShema.author OWNER TO postgres;

--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE author; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON TABLE libraryShema.author IS 'Таблица авторов книг';


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN author.birth_year; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.author.birth_year IS 'год рождения автора';


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN author.last_name; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.author.last_name IS 'фамилия автора';


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN author.first_name; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.author.first_name IS 'имя автора';


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN author.country; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.author.country IS 'страна происхождения автора';


--
-- TOC entry 230 (class 1259 OID 16724)
-- Name: author_book; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.author_book (
    id_author integer NOT NULL,
    id_book integer NOT NULL
);


ALTER TABLE libraryShema.author_book OWNER TO postgres;

--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE author_book; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON TABLE libraryShema.author_book IS 'таблица соответствий книг и авторов';


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN author_book.id_author; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.author_book.id_author IS 'ссылка на запись об авторе';


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN author_book.id_book; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.author_book.id_book IS 'ссылка на запись о книге';


--
-- TOC entry 225 (class 1259 OID 16628)
-- Name: author_id_author_seq; Type: SEQUENCE; Schema: libraryShema; Owner: postgres
--

ALTER TABLE libraryShema.author ALTER COLUMN id_author ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.author_id_author_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16418)
-- Name: book; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.book (
    book_name character varying(50) NOT NULL,
    genre character varying(50),
    pages_number integer,
    original_language character varying(50),
    writing_year integer,
    id_isbn character varying(30),
    id_book integer NOT NULL
);


ALTER TABLE libraryShema.book OWNER TO postgres;

--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE book; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON TABLE libraryShema.book IS 'Таблица книг, одна значение - конкретное издание книги';


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.book_name; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book.book_name IS 'название книги';


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.genre; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book.genre IS 'жанр';


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.pages_number; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book.pages_number IS 'количество страниц в книге';


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.original_language; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book.original_language IS 'язык оригинала книги';


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.writing_year; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book.writing_year IS 'год написания книги';


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN book.id_isbn; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book.id_isbn IS 'уникальный код хранящий в себе данные о конкретном издании книги';


--
-- TOC entry 227 (class 1259 OID 16694)
-- Name: book_id_book_seq; Type: SEQUENCE; Schema: libraryShema; Owner: postgres
--

ALTER TABLE libraryShema.book ALTER COLUMN id_book ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.book_id_book_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16500)
-- Name: book_list; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.book_list (
    id_entry integer NOT NULL,
    id_book integer NOT NULL,
    returned boolean DEFAULT false,
    return_data date,
    id_book_list integer NOT NULL
);


ALTER TABLE libraryShema.book_list OWNER TO postgres;

--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE book_list; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON TABLE libraryShema.book_list IS 'вспомогательная таблица хранящая соотношения кник к конкретной записи в таблице entry';


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN book_list.id_entry; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book_list.id_entry IS 'номер записи';


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN book_list.id_book; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book_list.id_book IS 'номер книги, которую взяли по записи';


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN book_list.returned; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book_list.returned IS 'метка обозначающая вернули ли книгу по этой записи';


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN book_list.return_data; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.book_list.return_data IS 'дата до которой необходимо вернуть книгу';


--
-- TOC entry 228 (class 1259 OID 16706)
-- Name: book_list_id_book_list_seq; Type: SEQUENCE; Schema: libraryShema; Owner: postgres
--

ALTER TABLE libraryShema.book_list ALTER COLUMN id_book_list ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.book_list_id_book_list_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16472)
-- Name: employee; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.employee (
    id_post integer,
    id_employee integer NOT NULL
);


ALTER TABLE libraryShema.employee OWNER TO postgres;

--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN employee.id_post; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.employee.id_post IS 'ссылка на должность сотрудника';


--
-- TOC entry 220 (class 1259 OID 16484)
-- Name: record; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.record (
    data timestamp without time zone NOT NULL,
    id_visitor integer NOT NULL,
    id_employee integer NOT NULL,
    id_record integer NOT NULL
);


ALTER TABLE libraryShema.record OWNER TO postgres;

--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN record.data; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.record.data IS 'время когда взяли книги';


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN record.id_visitor; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.record.id_visitor IS 'ссылка на данные посетителя';


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN record.id_employee; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.record.id_employee IS 'ссылка на данные работника библиотека который оформил книги';


--
-- TOC entry 229 (class 1259 OID 16712)
-- Name: entry_id_entry_seq; Type: SEQUENCE; Schema: libraryShema; Owner: postgres
--

ALTER TABLE libraryShema.record ALTER COLUMN id_record ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.entry_id_entry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16548)
-- Name: isbn; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.isbn (
    id_isbn character varying(30) NOT NULL,
    publisher character varying(50),
    country character varying(50),
    language character varying(50),
    publication_year integer,
    num integer
);


ALTER TABLE libraryShema.isbn OWNER TO postgres;

--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN isbn.publisher; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.isbn.publisher IS 'название издателя';


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN isbn.country; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.isbn.country IS 'страна в которой находится издатель';


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN isbn.language; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.isbn.language IS 'язык на который переведена книга в данном издании';


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN isbn.libraryShemaation_year; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.isbn.libraryShemaation_year IS 'год публикации книги';


--
-- TOC entry 224 (class 1259 OID 16595)
-- Name: pasport_details; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.pasport_details (
    series character varying(10),
    number character varying(10),
    departament_code character varying(50),
    id_pasport integer NOT NULL
);


ALTER TABLE libraryShema.pasport_details OWNER TO postgres;

--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE pasport_details; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON TABLE libraryShema.pasport_details IS 'таблица паспортных данных';


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN pasport_details.series; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.pasport_details.series IS 'серия паспорта';


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN pasport_details.number; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.pasport_details.number IS 'номер паспорта';


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN pasport_details.departament_code; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.pasport_details.departament_code IS 'код отдела который выдал паспорт';


--
-- TOC entry 226 (class 1259 OID 16678)
-- Name: pasport_details_id_pasport_seq; Type: SEQUENCE; Schema: libraryShema; Owner: postgres
--

ALTER TABLE libraryShema.pasport_details ALTER COLUMN id_pasport ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.pasport_details_id_pasport_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 16740)
-- Name: person; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.person (
    id_person integer NOT NULL,
    last_name character varying(30),
    first_name character varying(30),
    id_pasport integer,
    birth_data date
);


ALTER TABLE libraryShema.person OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE person; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON TABLE libraryShema.person IS 'таблица персональных данных посетителей и сотрудников';


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN person.last_name; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.person.last_name IS 'фамилия';


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN person.first_name; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.person.first_name IS 'Имя';


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN person.id_pasport; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.person.id_pasport IS 'ссылка на запись с паспортными данными';


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN person.birth_data; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.person.birth_data IS 'Дата рождения';


--
-- TOC entry 231 (class 1259 OID 16739)
-- Name: person_id_person_seq; Type: SEQUENCE; Schema: libraryShema; Owner: postgres
--

ALTER TABLE libraryShema.person ALTER COLUMN id_person ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.person_id_person_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16439)
-- Name: visitor; Type: TABLE; Schema: libraryShema; Owner: postgres
--

CREATE TABLE libraryShema.visitor (
    email character varying(50),
    phone_number bigint NOT NULL,
    id_visitor integer NOT NULL
);


ALTER TABLE libraryShema.visitor OWNER TO postgres;

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.email; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.visitor.email IS 'электронная почта посетителя';


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN visitor.phone_number; Type: COMMENT; Schema: libraryShema; Owner: postgres
--

COMMENT ON COLUMN libraryShema.visitor.phone_number IS 'номер телефона посетителя';


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 218
-- Name: Post_id_seq; Type: SEQUENCE SET; Schema: libraryShema; Owner: postgres
--

SELECT pg_catalog.setval('libraryShema."Post_id_seq"', 1, false);


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 225
-- Name: author_id_author_seq; Type: SEQUENCE SET; Schema: libraryShema; Owner: postgres
--

SELECT pg_catalog.setval('libraryShema.author_id_author_seq', 1, false);


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 227
-- Name: book_id_book_seq; Type: SEQUENCE SET; Schema: libraryShema; Owner: postgres
--

SELECT pg_catalog.setval('libraryShema.book_id_book_seq', 1, false);


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 228
-- Name: book_list_id_book_list_seq; Type: SEQUENCE SET; Schema: libraryShema; Owner: postgres
--

SELECT pg_catalog.setval('libraryShema.book_list_id_book_list_seq', 1, false);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 229
-- Name: entry_id_entry_seq; Type: SEQUENCE SET; Schema: libraryShema; Owner: postgres
--

SELECT pg_catalog.setval('libraryShema.entry_id_entry_seq', 1, false);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 226
-- Name: pasport_details_id_pasport_seq; Type: SEQUENCE SET; Schema: libraryShema; Owner: postgres
--

SELECT pg_catalog.setval('libraryShema.pasport_details_id_pasport_seq', 1, false);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 231
-- Name: person_id_person_seq; Type: SEQUENCE SET; Schema: libraryShema; Owner: postgres
--

SELECT pg_catalog.setval('libraryShema.person_id_person_seq', 1, false);


--
-- TOC entry 4703 (class 2606 OID 16775)
-- Name: author_book author_book_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.author_book
    ADD CONSTRAINT author_book_pk PRIMARY KEY (id_author, id_book);


--
-- TOC entry 4697 (class 2606 OID 16633)
-- Name: author author_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.author
    ADD CONSTRAINT author_pk PRIMARY KEY (id_author);


--
-- TOC entry 4695 (class 2606 OID 16711)
-- Name: book_list book_list_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.book_list
    ADD CONSTRAINT book_list_pk PRIMARY KEY (id_book_list);


--
-- TOC entry 4685 (class 2606 OID 16700)
-- Name: book book_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.book
    ADD CONSTRAINT book_pk PRIMARY KEY (id_book);


--
-- TOC entry 4687 (class 2606 OID 16647)
-- Name: book book_unique; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.book
    ADD CONSTRAINT book_unique UNIQUE (id_isbn);


--
-- TOC entry 4691 (class 2606 OID 16758)
-- Name: employee employee_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.employee
    ADD CONSTRAINT employee_pk PRIMARY KEY (id_employee);


--
-- TOC entry 4693 (class 2606 OID 16717)
-- Name: record entry_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.record
    ADD CONSTRAINT entry_pk PRIMARY KEY (id_record);


--
-- TOC entry 4699 (class 2606 OID 16655)
-- Name: isbn isbn_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.isbn
    ADD CONSTRAINT isbn_pk PRIMARY KEY (id_isbn);


--
-- TOC entry 4701 (class 2606 OID 16683)
-- Name: pasport_details pasport_details_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.pasport_details
    ADD CONSTRAINT pasport_details_pk PRIMARY KEY (id_pasport);


--
-- TOC entry 4705 (class 2606 OID 16744)
-- Name: person person_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.person
    ADD CONSTRAINT person_pk PRIMARY KEY (id_person);


--
-- TOC entry 4683 (class 2606 OID 16470)
-- Name: Post post_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema."Post"
    ADD CONSTRAINT post_pk PRIMARY KEY (id_post);


--
-- TOC entry 4689 (class 2606 OID 16751)
-- Name: visitor visitor_pk; Type: CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.visitor
    ADD CONSTRAINT visitor_pk PRIMARY KEY (id_visitor);


--
-- TOC entry 4714 (class 2606 OID 16729)
-- Name: author_book author_list_author_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.author_book
    ADD CONSTRAINT author_list_author_fk FOREIGN KEY (id_author) REFERENCES libraryShema.author(id_author);


--
-- TOC entry 4715 (class 2606 OID 16734)
-- Name: author_book author_list_book_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.author_book
    ADD CONSTRAINT author_list_book_fk FOREIGN KEY (id_book) REFERENCES libraryShema.book(id_book);


--
-- TOC entry 4706 (class 2606 OID 16660)
-- Name: book book_isbn_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.book
    ADD CONSTRAINT book_isbn_fk FOREIGN KEY (id_isbn) REFERENCES libraryShema.isbn(id_isbn);


--
-- TOC entry 4712 (class 2606 OID 16701)
-- Name: book_list book_list_book_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.book_list
    ADD CONSTRAINT book_list_book_fk FOREIGN KEY (id_book) REFERENCES libraryShema.book(id_book);


--
-- TOC entry 4713 (class 2606 OID 16718)
-- Name: book_list book_list_entry_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.book_list
    ADD CONSTRAINT book_list_entry_fk FOREIGN KEY (id_entry) REFERENCES libraryShema.record(id_record);


--
-- TOC entry 4708 (class 2606 OID 16759)
-- Name: employee employee_person_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.employee
    ADD CONSTRAINT employee_person_fk FOREIGN KEY (id_employee) REFERENCES libraryShema.person(id_person);


--
-- TOC entry 4709 (class 2606 OID 16515)
-- Name: employee employee_post_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.employee
    ADD CONSTRAINT employee_post_fk FOREIGN KEY (id_post) REFERENCES libraryShema."Post"(id_post);


--
-- TOC entry 4716 (class 2606 OID 16745)
-- Name: person person_pasport_details_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.person
    ADD CONSTRAINT person_pasport_details_fk FOREIGN KEY (id_pasport) REFERENCES libraryShema.pasport_details(id_pasport);


--
-- TOC entry 4710 (class 2606 OID 16769)
-- Name: record record_employee_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.record
    ADD CONSTRAINT record_employee_fk FOREIGN KEY (id_employee) REFERENCES libraryShema.employee(id_employee);


--
-- TOC entry 4711 (class 2606 OID 16764)
-- Name: record record_visitor_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.record
    ADD CONSTRAINT record_visitor_fk FOREIGN KEY (id_visitor) REFERENCES libraryShema.visitor(id_visitor);


--
-- TOC entry 4707 (class 2606 OID 16752)
-- Name: visitor visitor_person_fk; Type: FK CONSTRAINT; Schema: libraryShema; Owner: postgres
--

ALTER TABLE ONLY libraryShema.visitor
    ADD CONSTRAINT visitor_person_fk FOREIGN KEY (id_visitor) REFERENCES libraryShema.person(id_person);


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE author; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.author TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.author TO employee;


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE author_book; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.author_book TO employee;


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE book; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.book TO guest;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE libraryShema.book TO employee;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE book_list; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.book_list TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.book_list TO employee;


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE employee; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.employee TO employee;


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE record; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.record TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.record TO employee;


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 220 4915
-- Name: COLUMN record.id_record; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT(id_record) ON TABLE libraryShema.record TO guest;
GRANT SELECT(id_record) ON TABLE libraryShema.record TO employee;


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE isbn; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.isbn TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.isbn TO employee;


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE pasport_details; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.pasport_details TO employee;


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE person; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.person TO employee;
GRANT SELECT ON TABLE libraryShema.person TO guest;


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE visitor; Type: ACL; Schema: libraryShema; Owner: postgres
--

GRANT SELECT ON TABLE libraryShema.visitor TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.visitor TO employee;


--
-- TOC entry 2084 (class 826 OID 16676)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: libraryShema; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA libraryShema GRANT SELECT ON TABLES TO employee;


-- Completed on 2024-03-18 12:14:11

--
-- PostgreSQL database dump complete
--

