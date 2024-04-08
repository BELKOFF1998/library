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
 
 
 
 
 
 
 
 
 
 
  
  
  
  

