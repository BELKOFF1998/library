--1) Вывести все наименования книг, которые должны вернуть в условный день N.
-- N - в формате даты
create function books_return(in N date, out varchar(50))
AS
'select book_name from book
right join
book_list ON book.id_book = book_list.id_book where book_list.return_data = N'
language SQL;

--посмотреть все даты для книг
--select * from book_list;

select books_return('2015-04-26');

-- 2) вывести все книги из Book, которые брали в библиотеке больше одного раза, и у которых 1 автор.
select book_name as название_книги, A3.reserved_count as количество_записей, A3.author_count as количество_авторов  from book
right join(
	select A1.id_book, A1.reserved_count, A2.author_count  from (
		select book_list.id_book, count(book_list.id_book) as reserved_count from book_list
		group by book_list.id_book
	) A1
	left join(
		select author_book.id_book, count(author_book.id_book) as author_count from author_book
		group by author_book.id_book
	) A2
	on A1.id_book = A2.id_book
	where reserved_count > 1 and author_count = 1
) A3
on A3.id_book = book.id_book;


--3) найти Имя Employee для записи из record по конкретному Visitor на конкретный день, где паспорт Visitor = M.
create function employee_of(in N varchar, in M varchar, in D date, out varchar)
as
'select first_name as имя_сотрудника from person
where id_person =
(select id_employee from record
left join 
person on record.id_visitor = person.id_person
left join
pasport_details on pasport_details.id_pasport = person.id_pasport
where number = N and series = M and data::date = D)'
language SQL;

--посмотреть все даты записей и паспортные данные посетителей для них
select data as дата_записи, pasport_details."number" as номер_пас_посетит, pasport_details.series as сер_пас_посетит from record
left join 
person on record.id_visitor = person.id_person
left join
pasport_details on pasport_details.id_pasport = person.id_pasport;

select employee_of('6048','21-18','2010-02-08');


--4) в таблице author для каждой страны вывести самого младшего и самого старшего автора (использовать аналитические функции)
select A2.country, A2.first_name||' '||A2.last_name as старший_автор, A2.birth_year, A3.first_name||' '||A3.last_name as младший_автор, A3.birth_year from author as A3
right join
(select A1.country, first_name, last_name, birth_year, A1.max_date from author as A2
	right join(
		select A1.country, min(birth_year) as min_date, max(birth_year) as max_date from author as A1
				group by country
			) A1
	on A1.min_date=A2.birth_year and A1.country = A2.country) A2
on A2.max_date = A3.birth_year and A2.country = A3.country;


