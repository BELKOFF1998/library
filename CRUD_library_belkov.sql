--создание временной таблицы для использования в генеративных процедурах
--таблица хранит название колонки с первичным ключем и его тип данных для каждой таблицы
create temp table temp_primal_keys as
SELECT   
  pg_class.oid::regclass,
  pg_attribute.attname, 
  format_type(pg_attribute.atttypid, pg_attribute.atttypmod) 
FROM pg_index, pg_class, pg_attribute, pg_namespace 
WHERE   
  indrelid = pg_class.oid AND 
  nspname = 'libraryshema' AND 
  pg_class.relnamespace = pg_namespace.oid AND 
  pg_attribute.attrelid = pg_class.oid AND 
  pg_attribute.attnum = any(pg_index.indkey)
 AND indisprimary;
 
--select * from temp_primal_keys;


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
	if((select count(*) from temp_primal_keys where temp_primal_keys.oid = ('"'||table_name||'"')::regclass)::int = 1) then --если в таблице ключ из 1 значения то
	atr_txt := 'at1 '||(select "format_type" from temp_primal_keys where temp_primal_keys.oid = ('"'||table_name||'"')::regclass); -- в процедуре будет один атрибут
	else 
	atr_txt := 'at1 integer, at2 integer'; -- иначе будет 2 атрибута (например таблица author_book)	
	end if;
	if((select count(*) from temp_primal_keys where temp_primal_keys.oid = ('"'||table_name||'"')::regclass)::int = 1) then --если в таблице ключ из 1 значения то
	where_txt := 'libraryshema.'||table_name||'.'||(select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||table_name||'"')::regclass)||' = ''||at1||'''; -- в процедуре будет одно условие
	else
	where_txt := 'libraryshema.'||table_name||'.'||(select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||table_name||'"')::regclass limit 1)||' = ''||at1||'' AND'||
			     ' libraryshema.'||table_name||'.'||(select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||table_name||'"')::regclass limit 1 offset 1)||' = ''||at2||'';'; -- иначе будет 2 условия (например таблица author_book)
	end if;

	proc_txt := 'CREATE OR REPLACE PROCEDURE pr_schema.p_'||table_name||'_d('||atr_txt||') AS    
					$$ 
					DECLARE
					query_D text;
                    BEGIN
					query_D := ''DELETE from libraryshema.'||table_name||' WHERE '||where_txt||''';
					EXECUTE query_D;
					END
                    $$ LANGUAGE plpgsql;'; --компановка текста запроса
	EXECUTE proc_txt; -- выполнение запроса                    
end 
$BODY$ LANGUAGE plpgsql;

--call pr_schema.p_gen_d('isbn'); --пример вызова процедуры


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
	SELECT ARRAY_AGG(column_name) INTO ar_columns FROM information_schema.columns where information_schema.columns.table_name = t_name and is_identity = 'NO';
		foreach l_column_name in array ar_columns
		loop
			atr_txt := (atr_txt||l_column_name||' '||(select data_type  from information_schema.columns where information_schema.columns.table_name = t_name and column_name = l_column_name)||', ');
			l_values := l_values||' '||l_column_name||',';
		end loop;		
		atr_txt := left(atr_txt,-2);
		l_values := left(l_values,-1);
	
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

--call pr_schema.p_gen_i('visitor');--пример вызова процедуры

--ПРОЦЕДУРА ГЕНЕРИРУЮЩАЯ ПРОЦЕДУРУ UPDATE ДЛЯ ТАБЛИЦЫ
create or replace procedure pr_schema.p_gen_u(t_name text)
as $BODY$
declare
l_column_name text; --переменная для цикла хранящая название колонки
proc_txt text; --текст объявления новой процедуры
atr_txt text := ''; --список атрибутов для новой процедуры
ar_columns text[]; --масив хранящий названия колонок таблицы
l_columns text := ''; -- названия столбцев которые нужно изменить
where_txt text := ''; -- текст условия после where
l_values text :=''; -- текст перечисления новых значений
begin
	SELECT ARRAY_AGG(column_name) INTO ar_columns FROM information_schema.columns where information_schema.columns.table_name = t_name and is_identity = 'NO';
		foreach l_column_name in array ar_columns
		loop
			atr_txt := (atr_txt||'o_'||l_column_name||' '||(select data_type  from information_schema.columns where information_schema.columns.table_name = t_name and column_name = l_column_name)||', ');
			l_values := l_values||' o_'||l_column_name||',';
		    l_columns := l_columns||' '||l_column_name||',';
		end loop;
		if((select count(*) from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass)::int = 1) then --если первичный ключ таблицы это одно значение, то к атрибутам добавляется 1 атрибут
		atr_txt := 'p_'||(select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass)||' '||            --принимающий данные ключа записи которую надо изменить
					(select format_type from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass)||','||
					left(atr_txt,-2);
					where_txt := (select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass)||' = $1';
					
		else
		atr_txt := 'p_'||(select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass limit 1)||' '|| --иначе если первичный ключ составной, добавляется 2 параметра в процедуру
					(select format_type from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass limit 1)||','|| --которые принимают значение ключа записи которую надо изменить
					'p_'||(select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass limit 1 offset 1)||' '||
					(select format_type from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass limit 1 offset 1)||','||
					left(atr_txt,-2);
					where_txt := (select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass limit 1)||' = $1 AND '||
								 (select attname from temp_primal_keys where temp_primal_keys.oid = ('"'||t_name||'"')::regclass limit 1 offset 1)||' = $2';
		end if;
		l_columns := left(l_columns,-1);
	    l_values := left(l_values,-1);
	
		proc_txt := 'CREATE OR REPLACE PROCEDURE pr_schema.p_'||t_name||'_u('||atr_txt||') AS    
					$b$
                    BEGIN
						update "'||t_name||'"
						set ('||l_columns||') = ('||l_values||')
						where '||where_txt||';
					END
                    $b$ LANGUAGE plpgsql;';
                   
        EXECUTE proc_txt;		
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