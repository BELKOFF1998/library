--создание временной таблицы для использования в генеративных процедурах
--таблица хранит название колонки с первичным ключем и его тип данных для каждой таблицы
-- так же хранит строку с названиями колонок которые будут изменятся значения которых передаются в параметры процедур insert и update
create view v_temp_primal_keys as
with t_columns as(
SELECT table_name,STRING_AGG(column_name,', ')
 FROM information_schema.columns
 where is_identity = 'NO' and
 table_schema = 'libraryshema'
 group by table_name
 )
SELECT   
  btrim(pg_class.oid::regclass||'','"') as oid,
  pg_attribute.attname, 
  format_type(pg_attribute.atttypid, pg_attribute.atttypmod),
  string_agg
FROM pg_class
join pg_index on  indrelid = pg_class.oid
join pg_attribute on pg_attribute.attrelid = pg_class.oid
join pg_namespace on pg_class.relnamespace = pg_namespace.oid
join t_columns on t_columns.table_name = btrim(pg_class.oid::regclass||'','"')
where 
  pg_attribute.attnum = any(pg_index.indkey)
  AND indisprimary;
 
select * from v_temp_primal_keys;

--создать отдельную схему где будут хранится процедуры
do $$
begin
create schema if not exists pr_schema; --схема хранящая процедуры
end $$;

--процедура генерирующая процедуру DELETE для таблицы 
create or replace procedure pr_schema.p_gen_d(table_name text) AS --входной параметр - название таблицы
$BODY$
DECLARE
proc_txt text; --текст объявления новой процедуры
atr_txt text; --список атрибутов для новой процедуры
where_txt text; -- текст в запросе после WHERE
begin
	atr_txt := (select string_agg('at_'||attname||' '||format_type,', ') from v_temp_primal_keys where  v_temp_primal_keys.oid = table_name); --текст с названиями ключей таблицы для параметров
	
	where_txt := (select attname from v_temp_primal_keys where v_temp_primal_keys.oid = table_name limit 1)||' = ''||$1||'''; --текст проверки ключа после where	
	if ((select count(*) from v_temp_primal_keys where v_temp_primal_keys.oid = table_name)::int = 2) then                                      --если в таблице ключ из 2 значений то 
    where_txt := where_txt||' AND '||(select attname from v_temp_primal_keys where v_temp_primal_keys.oid = table_name limit 1 offset 1)||' = ''||$2||'''; --в where добавляется приверка второго ключа
	end if;

	proc_txt := 'CREATE OR REPLACE PROCEDURE pr_schema.p_'||table_name||'_d('||atr_txt||') AS    
					$$ 
					DECLARE
					query_D text;
                    BEGIN
					query_D := ''DELETE from libraryshema."'||table_name||'" WHERE '||where_txt||''';
					EXECUTE query_D;
					END
                    $$ LANGUAGE plpgsql;'; --компановка текста запроса
	execute proc_txt; -- выполнение запроса                    
end 
$BODY$ LANGUAGE plpgsql;

--ПРОЦЕДУРА ГЕНЕРИРУЮЩАЯ ПРОЦЕДУРУ INSERT ДЛЯ ТАБЛИЦЫ
create or replace procedure pr_schema.p_gen_i(t_name text) AS --входной параметр - название таблицы
$BODY$
declare
l_column_name text; --переменная для цикла хранящая название колонки
proc_txt text; --текст объявления новой процедуры
atr_txt text := ''; --список атрибутов для новой процедуры
ar_columns text[]; --масив хранящий названия колонок таблицы
l_values text := ''; -- текст в запросе после where
begin	
		atr_txt := (select string_agg(column_name||' '||data_type,', ')  from information_schema.columns --строка с перечислением названия колонки и типа через запятую
	                where information_schema.columns.table_name = t_name and is_identity = 'NO');
	               
		l_values := (select STRING_AGG(column_name,', ') FROM information_schema.columns
	                where information_schema.columns.table_name = t_name and is_identity = 'NO'); --строка с перечислением названия колонки через запятую
	
		proc_txt := 'CREATE OR REPLACE PROCEDURE pr_schema.p_'||t_name||'_i('||atr_txt||') AS    
					$$ 
					DECLARE
                    BEGIN
					insert into "'||t_name||'"('||l_values||') values ('||l_values||');
					END
                    $$ LANGUAGE plpgsql;'; --компановка текста запроса
	EXECUTE proc_txt; -- выполнение запроса
end 
$BODY$ LANGUAGE plpgsql;

--ПРОЦЕДУРА ГЕНЕРИРУЮЩАЯ ПРОЦЕДУРУ UPDATE ДЛЯ ТАБЛИЦЫ
create or replace procedure pr_schema.p_gen_u(t_name text)
as $BODY$
declare
proc_txt text; --текст объявления новой процедуры
atr_txt text := ''; --список атрибутов для новой процедуры
l_columns text := ''; -- названия столбцев которые нужно изменить
where_txt text := ''; -- текст условия после where
l_values text :=''; -- текст перечисления новых значений
begin
	atr_txt := (select string_agg('o_'||column_name||' '||data_type,', ')  from information_schema.columns --строка с перечислением названия колонки и типа через запятую
	                where information_schema.columns.table_name = t_name and is_identity = 'NO');          --перед названиями колонок которые надо менять будет приписка "о_"
	                
	l_values := (select STRING_AGG('o_'||column_name,', ') FROM information_schema.columns --строка с перечислением только названия колонки через запятую
	                where information_schema.columns.table_name = t_name and is_identity = 'NO'); --перед названиями колонок которые надо менять будет приписка "о_"
	                
	l_columns :=  (select STRING_AGG(column_name,', ') FROM information_schema.columns
	                where information_schema.columns.table_name = t_name and is_identity = 'NO'); --строка с перечислением названия колонки через запятую      
	         
	atr_txt := (select string_AGG('p_'||attname||' '||format_type||', ','') from v_temp_primal_keys where v_temp_primal_keys.oid = t_name)||atr_txt; --добавляет к списку аргументов названия первичных ключей

	where_txt := (select attname from v_temp_primal_keys where v_temp_primal_keys.oid = t_name limit 1)||' = $1'; --текст проверки ключа после where

	if ((select count(*) from v_temp_primal_keys where v_temp_primal_keys.oid = t_name)::int = 2) then                                      --если в таблице ключ из 2 значений то 
    where_txt := where_txt||' AND '||(select attname from v_temp_primal_keys where v_temp_primal_keys.oid = t_name limit 1 offset 1)||' = $2'; --в where добавляется приверка второго ключа
	end if;
	
		proc_txt := 'CREATE OR REPLACE PROCEDURE pr_schema.p_'||t_name||'_u('||atr_txt||') AS    
					$b$
                    BEGIN
						update "'||t_name||'"
						set ('||l_columns||') = ('||l_values||')
						where '||where_txt||';
					END
                    $b$ LANGUAGE plpgsql;';
                   
       EXECUTE proc_txt; -- выполнение запроса
end 
$BODY$ LANGUAGE plpgsql;

--цикл создает 3 процедуры для каждой таблицы в схеме libraryshema
do $$
declare
ar_tables text[];
l_table_name text;
begin
	SELECT ARRAY_AGG(tablename) INTO ar_tables FROM pg_tables where schemaname = 'libraryshema' and hasindexes is true;
	foreach l_table_name in array ar_tables
	loop
	call pr_schema.p_gen_u(l_table_name);
	call pr_schema.p_gen_d(l_table_name);
	call pr_schema.p_gen_i(l_table_name);	
	end loop;	
end $$;

--проверка получившихся процедур

--самые проблемные таблицы:
-- Post из-за ключевого слова в названии
-- Author_book из за составного первичного ключа

call pr_schema.p_Post_i(44412,'Главный библиотекарь'); --вставка
select * from "Post";
call pr_schema.p_Post_u(8,45500,'иблеограф'); --изменение (сначала первичный ключ)
select * from "Post";
call pr_schema.p_post_d(8); --удаление
select * from "Post";


call pr_schema.p_author_book_i(8,54); --вставка
select * from author_book;
call pr_schema.p_author_book_u(8,54,8,55); --изменение (сначала первичный ключ из 2 значений)
select * from author_book;
call pr_schema.p_author_book_d(8,55); --удаление
select * from author_book;