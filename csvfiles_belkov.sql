--очистить таблицу book и установить нумерацию id с 1
truncate book CASCADE;
SELECT pg_catalog.setval('libraryShema.book_id_book_seq', 1, false);


--копирование даных из файла в таблицу book
copy book (book_name,genre,original_language,pages_number,writing_year)
from 'book_csv.csv' -- путь относительно C:\Program Files\PostgreSQL\16\data
with (format csv, header true, encoding 'UTF-8');

--с помощью psql
\copy libraryshema.book (book_name,genre,original_language,pages_number,writing_year) from 'C:\Program Files\PostgreSQL\16\data\book_csv.csv' with (format csv, header true, encoding 'UTF-8');


--расширение file_fdw
create EXTENSION file_fdw;

create server server_csv foreign data wrapper file_fdw;

--создание внешней таблицы по данным из файла
create foreign table book_csv(book_name varchar,genre varchar,original_language varchar,pages_number integer,writing_year integer)
server server_csv
options (filename 'book_csv_3.csv', header 'true', encoding 'UTF-8', delimiter ',');

--вставка данных из сторонней таблицы
insert into book (book_name,genre,original_language,pages_number,writing_year) select * from book_csv;

--заного проставить isbn
update book set id_isbn = (select isbn.id_isbn from isbn where isbn.num = book.id_book);

select * from book;



