--тригер вызывает ошибку если пытаются взять книгу которую еще не вернули
CREATE OR REPLACE FUNCTION f_trg_book_list_check_prev() RETURNS trigger
   AS $BODY$ BEGIN 
      IF new.id_book not in (select id_book from free_book_id) THEN          
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
  insert into book_list values (1,43,false,null);
 
 
 
 
 --фунция возвращающая данные о записях и книгах для одного человека
 -- входные данные - имя и фамилия посетителя через пробел
 
create or replace function get_book_info(data_name varchar) returns table (Дата_записи date, Дата_возврата date, Возращена bool, Книга varchar)
as $$
declare 
l_name varchar := left(data_name, position(' ' in data_name) - 1);
l_Sname varchar := right(data_name, -position(' ' in data_name));
begin
return query select record."data"::date,book_list.return_data, book_list.returned,book.book_name from record
				join book_list on book_list.id_entry = record.id_record
				join book on book.id_book = book_list.id_book
				join visitor on visitor.id_visitor = record.id_visitor
				join person on person.id_person = visitor.id_visitor
				where person.first_name = l_name and person.last_name = l_Sname;
end $$ LANGUAGE plpgsql;


select * from get_book_info('Артём Жданов');
	
 
 
 

 
  
  
  
  

