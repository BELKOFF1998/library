--
-- PostgreSQL database dump

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


CREATE SCHEMA libraryShema;
ALTER SCHEMA libraryShema OWNER TO pg_database_owner;

-- создание ролей


CREATE ROLE  employee WITH 
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	NOINHERIT
	LOGIN
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;

CREATE ROLE  guest WITH 
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	NOINHERIT
	LOGIN
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;


SET default_tablespace = '';
SET default_table_access_method = heap;

CREATE TABLE libraryShema."Post" (
    id_post integer NOT NULL,
    post character varying(30),
    salary integer
);


ALTER TABLE libraryShema."Post" OWNER TO postgres;

ALTER TABLE libraryShema."Post" ALTER COLUMN id_post ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema."Post_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE libraryShema.author (
    birth_year integer,
    last_name character varying(50),
    first_name character varying(50),
    country character varying(50),
    id_author integer NOT NULL
);


ALTER TABLE libraryShema.author OWNER TO postgres;

CREATE TABLE libraryShema.author_book (
    id_author integer NOT NULL,
    id_book integer NOT NULL
);

ALTER TABLE libraryShema.author_book OWNER TO postgres;

ALTER TABLE libraryShema.author ALTER COLUMN id_author ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.author_id_author_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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


ALTER TABLE libraryShema.book ALTER COLUMN id_book ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.book_id_book_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE libraryShema.book_list (
    id_entry integer NOT NULL,
    id_book integer NOT NULL,
    returned boolean DEFAULT false,
    return_data date,
    id_book_list integer NOT NULL
);


ALTER TABLE libraryShema.book_list OWNER TO postgres;


ALTER TABLE libraryShema.book_list ALTER COLUMN id_book_list ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.book_list_id_book_list_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE libraryShema.employee (
    id_post integer,
    id_employee integer NOT NULL
);


ALTER TABLE libraryShema.employee OWNER TO postgres;


COMMENT ON COLUMN libraryShema.employee.id_post IS 'ссылка на должность сотрудника';


CREATE TABLE libraryShema.record (
    data timestamp without time zone NOT NULL,
    id_visitor integer NOT NULL,
    id_employee integer NOT NULL,
    id_record integer NOT NULL
);


ALTER TABLE libraryShema.record OWNER TO postgres;




ALTER TABLE libraryShema.record ALTER COLUMN id_record ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.entry_id_entry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE libraryShema.isbn (
    id_isbn character varying(30) NOT NULL,
    publisher character varying(50),
    country character varying(50),
    language character varying(50),
    publication_year integer,
    num integer
);


ALTER TABLE libraryShema.isbn OWNER TO postgres;




CREATE TABLE libraryShema.pasport_details (
    series character varying(10),
    number character varying(10),
    departament_code character varying(50),
    id_pasport integer NOT NULL
);


ALTER TABLE libraryShema.pasport_details OWNER TO postgres;



ALTER TABLE libraryShema.pasport_details ALTER COLUMN id_pasport ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.pasport_details_id_pasport_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE libraryShema.person (
    id_person integer NOT NULL,
    last_name character varying(30),
    first_name character varying(30),
    id_pasport integer,
    birth_data date
);


ALTER TABLE libraryShema.person OWNER TO postgres;



ALTER TABLE libraryShema.person ALTER COLUMN id_person ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME libraryShema.person_id_person_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE libraryShema.visitor (
    email character varying(50),
    phone_number bigint NOT NULL,
    id_visitor integer NOT NULL
);


ALTER TABLE libraryShema.visitor OWNER TO postgres;




SELECT pg_catalog.setval('libraryShema."Post_id_seq"', 1, false);
SELECT pg_catalog.setval('libraryShema.author_id_author_seq', 1, false);
SELECT pg_catalog.setval('libraryShema.book_id_book_seq', 1, false);
SELECT pg_catalog.setval('libraryShema.book_list_id_book_list_seq', 1, false);
SELECT pg_catalog.setval('libraryShema.entry_id_entry_seq', 1, false);
SELECT pg_catalog.setval('libraryShema.pasport_details_id_pasport_seq', 1, false);
SELECT pg_catalog.setval('libraryShema.person_id_person_seq', 1, false);


ALTER TABLE ONLY libraryShema.author_book
    ADD CONSTRAINT author_book_pk PRIMARY KEY (id_author, id_book);

ALTER TABLE ONLY libraryShema.author
    ADD CONSTRAINT author_pk PRIMARY KEY (id_author);

ALTER TABLE ONLY libraryShema.book_list
    ADD CONSTRAINT book_list_pk PRIMARY KEY (id_book_list);

ALTER TABLE ONLY libraryShema.book
    ADD CONSTRAINT book_pk PRIMARY KEY (id_book);

ALTER TABLE ONLY libraryShema.book
    ADD CONSTRAINT book_unique UNIQUE (id_isbn);

ALTER TABLE ONLY libraryShema.employee
    ADD CONSTRAINT employee_pk PRIMARY KEY (id_employee);

ALTER TABLE ONLY libraryShema.record
    ADD CONSTRAINT entry_pk PRIMARY KEY (id_record);

ALTER TABLE ONLY libraryShema.isbn
    ADD CONSTRAINT isbn_pk PRIMARY KEY (id_isbn);

ALTER TABLE ONLY libraryShema.pasport_details
    ADD CONSTRAINT pasport_details_pk PRIMARY KEY (id_pasport);

ALTER TABLE ONLY libraryShema.person
    ADD CONSTRAINT person_pk PRIMARY KEY (id_person);

ALTER TABLE ONLY libraryShema."Post"
    ADD CONSTRAINT post_pk PRIMARY KEY (id_post);

ALTER TABLE ONLY libraryShema.visitor
    ADD CONSTRAINT visitor_pk PRIMARY KEY (id_visitor);

   --ВНЕШНИЕ КЛЮЧИ
   
ALTER TABLE ONLY libraryShema.author_book
    ADD CONSTRAINT author_list_author_fk FOREIGN KEY (id_author) REFERENCES libraryShema.author(id_author);

ALTER TABLE ONLY libraryShema.author_book
    ADD CONSTRAINT author_list_book_fk FOREIGN KEY (id_book) REFERENCES libraryShema.book(id_book);

ALTER TABLE ONLY libraryShema.book
    ADD CONSTRAINT book_isbn_fk FOREIGN KEY (id_isbn) REFERENCES libraryShema.isbn(id_isbn);

ALTER TABLE ONLY libraryShema.book_list
    ADD CONSTRAINT book_list_book_fk FOREIGN KEY (id_book) REFERENCES libraryShema.book(id_book);

ALTER TABLE ONLY libraryShema.book_list
    ADD CONSTRAINT book_list_entry_fk FOREIGN KEY (id_entry) REFERENCES libraryShema.record(id_record);

ALTER TABLE ONLY libraryShema.employee
    ADD CONSTRAINT employee_person_fk FOREIGN KEY (id_employee) REFERENCES libraryShema.person(id_person);

ALTER TABLE ONLY libraryShema.employee
    ADD CONSTRAINT employee_post_fk FOREIGN KEY (id_post) REFERENCES libraryShema."Post"(id_post);

ALTER TABLE ONLY libraryShema.person
    ADD CONSTRAINT person_pasport_details_fk FOREIGN KEY (id_pasport) REFERENCES libraryShema.pasport_details(id_pasport);

ALTER TABLE ONLY libraryShema.record
    ADD CONSTRAINT record_employee_fk FOREIGN KEY (id_employee) REFERENCES libraryShema.employee(id_employee);

ALTER TABLE ONLY libraryShema.record
    ADD CONSTRAINT record_visitor_fk FOREIGN KEY (id_visitor) REFERENCES libraryShema.visitor(id_visitor);

ALTER TABLE ONLY libraryShema.visitor
    ADD CONSTRAINT visitor_person_fk FOREIGN KEY (id_visitor) REFERENCES libraryShema.person(id_person);



GRANT SELECT ON TABLE libraryShema.author TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.author TO employee;
GRANT SELECT ON TABLE libraryShema.author_book TO employee;
GRANT SELECT ON TABLE libraryShema.book TO guest;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE libraryShema.book TO employee;
GRANT SELECT ON TABLE libraryShema.book_list TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.book_list TO employee;
GRANT SELECT ON TABLE libraryShema.employee TO employee;
GRANT SELECT ON TABLE libraryShema.record TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.record TO employee;
GRANT SELECT(id_record) ON TABLE libraryShema.record TO guest;
GRANT SELECT(id_record) ON TABLE libraryShema.record TO employee;
GRANT SELECT ON TABLE libraryShema.isbn TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.isbn TO employee;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.pasport_details TO employee;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.person TO employee;
GRANT SELECT ON TABLE libraryShema.person TO guest;
GRANT SELECT ON TABLE libraryShema.visitor TO guest;
GRANT SELECT,INSERT,UPDATE ON TABLE libraryShema.visitor TO employee;


ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA libraryShema GRANT SELECT ON TABLES TO employee;

COMMENT ON TABLE libraryShema.person IS 'таблица персональных данных посетителей и сотрудников';
COMMENT ON COLUMN libraryShema.person.last_name IS 'фамилия';
COMMENT ON COLUMN libraryShema.person.first_name IS 'Имя';
COMMENT ON COLUMN libraryShema.person.id_pasport IS 'ссылка на запись с паспортными данными';
COMMENT ON COLUMN libraryShema.person.birth_data IS 'Дата рождения';
COMMENT ON TABLE libraryShema.pasport_details IS 'таблица паспортных данных';
COMMENT ON COLUMN libraryShema.pasport_details.series IS 'серия паспорта';
COMMENT ON COLUMN libraryShema.pasport_details.number IS 'номер паспорта';
COMMENT ON COLUMN libraryShema.pasport_details.departament_code IS 'код отдела который выдал паспорт';
COMMENT ON COLUMN libraryShema.isbn.publisher IS 'название издателя';
COMMENT ON COLUMN libraryShema.isbn.country IS 'страна в которой находится издатель';
COMMENT ON COLUMN libraryShema.isbn.language IS 'язык на который переведена книга в данном издании';
COMMENT ON COLUMN libraryShema.isbn.publication_year IS 'год публикации книги';
COMMENT ON COLUMN libraryShema.record.data IS 'время когда взяли книги';
COMMENT ON COLUMN libraryShema.record.id_visitor IS 'ссылка на данные посетителя';
COMMENT ON COLUMN libraryShema.record.id_employee IS 'ссылка на данные работника библиотека который оформил книги';
COMMENT ON TABLE libraryShema.book_list IS 'вспомогательная таблица хранящая соотношения кник к конкретной записи в таблице entry';
COMMENT ON COLUMN libraryShema.book_list.id_entry IS 'номер записи';
COMMENT ON COLUMN libraryShema.book_list.id_book IS 'номер книги, которую взяли по записи';
COMMENT ON COLUMN libraryShema.book_list.returned IS 'метка обозначающая вернули ли книгу по этой записи';
COMMENT ON COLUMN libraryShema.book_list.return_data IS 'дата до которой необходимо вернуть книгу';
COMMENT ON TABLE libraryShema.book IS 'Таблица книг, одна значение - конкретное издание книги';
COMMENT ON COLUMN libraryShema.book.book_name IS 'название книги';
COMMENT ON COLUMN libraryShema.book.genre IS 'жанр';
COMMENT ON COLUMN libraryShema.book.pages_number IS 'количество страниц в книге';
COMMENT ON COLUMN libraryShema.book.original_language IS 'язык оригинала книги';
COMMENT ON COLUMN libraryShema.book.writing_year IS 'год написания книги';
COMMENT ON COLUMN libraryShema.book.id_isbn IS 'уникальный код хранящий в себе данные о конкретном издании книги';
COMMENT ON COLUMN libraryShema.visitor.email IS 'электронная почта посетителя';
COMMENT ON COLUMN libraryShema.visitor.phone_number IS 'номер телефона посетителя';
COMMENT ON TABLE libraryShema.author IS 'Таблица авторов книг';
COMMENT ON COLUMN libraryShema.author.birth_year IS 'год рождения автора';
COMMENT ON COLUMN libraryShema.author.last_name IS 'фамилия автора';
COMMENT ON COLUMN libraryShema.author.first_name IS 'имя автора';
COMMENT ON COLUMN libraryShema.author.country IS 'страна происхождения автора';
COMMENT ON SCHEMA libraryShema IS 'БИБЛИОТЕКА';
COMMENT ON COLUMN libraryShema."Post".post IS 'название должности сотрудника';
COMMENT ON COLUMN libraryShema."Post".salary IS 'оклад данной должности';
COMMENT ON TABLE libraryShema.author_book IS 'таблица соответствий книг и авторов';
COMMENT ON COLUMN libraryShema.author_book.id_author IS 'ссылка на запись об авторе';
COMMENT ON COLUMN libraryShema.author_book.id_book IS 'ссылка на запись о книге';
