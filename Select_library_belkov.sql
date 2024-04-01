--1) Вывести все наименования книг, которые должны вернуть в условный день N.
-- N - в формате даты
create function books_return(in N date, out varchar(50))
AS
'select book_name from book_list
join
book ON book.id_book = book_list.id_book where book_list.return_data = N'
language SQL;

--посмотреть все даты для книг
--select * from book_list;

select books_return('2015-04-26');

-- 2) вывести все книги из Book, которые брали в библиотеке больше одного раза, и у которых 1 автор.
select book_name as название_книги, A1.reserved_count as количество_записей, A2.author_count as количество_авторов  from (
		select book_list.id_book, count(book_list.id_book) as reserved_count from book_list
		group by book_list.id_book
		having count(book_list.id_book) > 1
	) A1 
	join(
		select author_book.id_book, count(author_book.id_book) as author_count from author_book
		group by author_book.id_book
		having count(author_book.id_book) = 1
	) A2
	on A1.id_book = A2.id_book
	join book
	on A1.id_book = book.id_book;


--3) найти Имя Employee для записи из record по конкретному Visitor на конкретный день, где паспорт Visitor = M.
create function employee_of(in N varchar, in M varchar, in D date, out varchar)
as
'select first_name as имя_сотрудника from person
where id_person =
(select id_employee from record
join 
person on record.id_visitor = person.id_person
join
pasport_details on pasport_details.id_pasport = person.id_pasport
where number = N and series = M and data::date = D)'
language SQL;

--посмотреть все даты записей и паспортные данные посетителей для них
select data as дата_записи, pasport_details."number" as номер_пас_посетит, pasport_details.series as сер_пас_посетит from record
join 
person on record.id_visitor = person.id_person
join
pasport_details on pasport_details.id_pasport = person.id_pasport;

select employee_of('6048','21-18','2010-02-08');


--4) в таблице author для каждой страны вывести самого младшего и самого старшего автора (использовать аналитические функции)
select distinct 
	country,
	first_value(first_name||' '||last_name) OVER (
        PARTITION BY country ORDER BY birth_year ASC) as старший_автор,
    first_value(birth_year) OVER (
        PARTITION BY country ORDER BY birth_year ASC) as год_старший_автор,    
    first_value(first_name||' '||last_name) OVER (
        PARTITION BY country ORDER BY birth_year DESC) as младший_автор,
    first_value(birth_year) OVER (
        PARTITION BY country ORDER BY birth_year DESC) as год_младший_автор
    from author;


--5) вывести все книги из Book, для которых не существует записей в таблице Book_list. (exists, not exists, in, not in, count - нельзя использовать)
 
  
SELECT book.book_name from book
left join book_list
on book.id_book = book_list.id_book 
where book_list.id_book is null;