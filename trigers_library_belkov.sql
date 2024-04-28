--тригер вызывает ошибку если пытаются взять книгу которую еще не вернули
CREATE OR REPLACE FUNCTION f_trg_book_list_check_prev() RETURNS trigger
   AS $BODY$ BEGIN 
      IF not exists (select id_book from free_book_id a where a.id_book = new.id_book) THEN          
         RAISE SQLSTATE 'ER001' USING message = format('Книгу %s еще не вернули!',
         (SELECT book_name FROM book WHERE id_book = NEW.id_book));
      ELSE 
         RETURN NEW;
      END IF;
   END $BODY$ LANGUAGE plpgsql;
  
 --тригер срабатывает до операции вставки в book_list
   CREATE OR REPLACE TRIGGER trg_book_list_check_prev
   BEFORE INSERT ON book_list FOR EACH ROW
   EXECUTE FUNCTION f_trg_book_list_check_prev();
  
--проверка тригера
  select b.id_book, book_name from free_book_id a right join book b on a.id_book = b.id_book  where a.id_book is NULL; --книги которые не вернули
  insert into book_list values (1,43,false,null); --попытка создать запись о взятии занятой книги(id записи, id книги, флаг возврата, дата возврата)
 
 
 
 
 --фунция возвращающая данные о записях и книгах для одного человека
 -- входные данные - имя и фамилия посетителя через пробел
 
create or replace function f_get_book_info(l_data_name varchar) returns table (Дата_записи date, Дата_возврата date, Возращена bool, Книга varchar)
as $$
declare 
l_name varchar := left(l_data_name, position(' ' in l_data_name) - 1);
l_Sname varchar := right(l_data_name, -position(' ' in l_data_name));
begin
return query select record."data"::date,book_list.return_data, book_list.returned,book.book_name from record
				join book_list on book_list.id_entry = record.id_record
				join book on book.id_book = book_list.id_book
				join visitor on visitor.id_visitor = record.id_visitor
				join person on person.id_person = visitor.id_visitor
				where person.first_name = l_name and person.last_name = l_Sname;
end $$ LANGUAGE plpgsql;


select * from f_get_book_info('Артём Жданов');



----процедура добавления книги с обработкой исключения
create or replace procedure p_add_book(
	l_book_name varchar,
	l_genre varchar,
	l_pages_number integer,
	l_original_language varchar,
	l_writing_year integer,
	l_id_isbn varchar
	)
AS $$
begin
	 
     insert into book values (l_book_name, l_genre, l_pages_number, l_original_language, l_writing_year, l_id_isbn);
 	 raise notice 'Книга % успешно добавлена', l_book_name;
 		EXCEPTION when unique_violation then
 		raise notice 'Книга с таким ISBN уже есть: %, %', (select book_name from book where id_isbn = l_id_isbn),  l_id_isbn;
end
$$ language PLPGSQL;

----процедура добавления  книги автору с обработкой исключения
create or replace procedure p_add_book_to_author(
	l_id_author integer,
	l_id_book integer
	)
AS $body$
declare 
l_author record;
l_book record;
begin
	select * into l_author  from author where id_author = l_id_author;
	select * into l_book from book where id_book = l_id_book;
	if (l_book.writing_year < l_author.birth_year) then 
		raise exception 'Invalid values'
		using hint = format ('%s %s не мог написать книгу %s в %s году, так как родился только в %s году', 
		l_author.first_name,
		l_author.last_name,
		l_book.book_name,
		l_book.writing_year,
		l_author.birth_year);
	else
 		insert into author_book values ( l_id_author,l_id_book);
 	end if;
end
$body$ language PLPGSQL;

select id_isbn from book limit 1;-- ISBN который уже есть
select id_isbn from isbn;
--попытка добавить книгу с ISBN который уже есть
call p_add_book('Вечер в Мытищах', 'Философия', 322, 'Русский', 2019, 'ISBN 256-3-7880-7142-9');

--попытка добавить книгу с годом написания раньше чем год рождения автора
call p_add_book_to_author(24,16);





	
 
 
 

 
  
  
  
  

