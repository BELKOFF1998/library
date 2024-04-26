-- liquibase formatted sql

-- changeset dmitry:CREATING_FREE_BOOK_ID_VIEW runOnChange:true
CREATE OR REPLACE VIEW libraryschema."free_book_id" AS SELECT libraryschema.book.id_book
   FROM libraryschema.book
EXCEPT
 SELECT libraryschema.book_list.id_book
   FROM libraryschema.book_list
  WHERE (libraryschema.book_list.returned = false);

-- changeset dmitry:CREATING_FREE_BOOK_VIEW runOnChange:true
CREATE  OR REPLACE VIEW libraryschema."free_book" AS SELECT libraryschema.book.book_name,
    libraryschema.book.genre,
    libraryschema.book.pages_number,
    libraryschema.book.original_language,
    libraryschema.book.writing_year,
    libraryschema.book.id_isbn,
    libraryschema.book.id_book
   FROM (libraryschema.book
     RIGHT JOIN libraryschema.free_book_id ON (libraryschema.book.id_book = libraryschema.free_book_id.id_book));