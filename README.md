# Тема – Библиотека 
 Предметной областью описанной логической моделью является электронный документооборот в библиотеке.
Цель системы – структурирование и упорядочивание хранимых данных об отпускаемых посетителям книгах.
# Объекты предметной области:
#### Запись
Центральный объект системы. Хранит данных о времени получения книги, получателе и работнике библиотеки, который зарегистрировал действие, а также информацию о том были ли возвращены книги. Данные для данного объекта хранятся в таблице Entry. Содержит следующие поля:
#####  таблица Entry:
-	ID_entry – первичный ключ записи
-	data – дата и время выдачи книг
-	id_visitor – внешний ключ ссылающийся на запись в таблице с данными о посетителях
-	id_emloyee – внешний ключ ведущий на запись в таблице с данными о работнике который выдал книги

Для хранения данных о работнике используется таблица Employee. В будущем возможно использование данных из таблицы в отделе бухгалтерии или в системе учета сотрудников. В данной схеме это не рассматривается. 
##### таблица Employee.
-	Id_employee – первичный ключ
-	birth_data – дата рождения
-	last_name – фамилия работника
-	first_name – имя работника
-	id_post – внешний ключ ссылающийся на запись с должностью работника в вспомогательной таблице
-	id_passport – внешний ключ на таблицу хранящую паспортные данные посетителей и работников

Для хранения названия должностей есть отдельная таблица. Это реализовано в целях оптимизации памяти, так как должности могут повторятся, и лучше будет хранить их в отдельной таблице в записи с типом данных varchar(30) и ссылаться из основной таблицы из записи с типо INTEGER которая занимает меньше памяти. 
##### вспомогательная таблица Post 
-	ID_post – первичный ключ
-	Post – название должности
-	Salary – оклад должности

Паспортные данные как сотрудников так и посетителей хранятся в таблице Pasport_details 
##### таблица Pasport_details 
-	ID_pasport– первичный ключ
-	series – серия паспорта
-	number – номер паспорта
-	department_code – код отделения выдавшего паспорт

Для хранения данных о книгах используется таблица Book. В одной записи о выдаче книг может быть несколько книг, так и к одной книге может относится несколько записей о выдаче в разное время. На таблицу Book ссылается таблица записей посредством связи многие-ко-многим. 
##### таблица Book:
-	Id_book – первичный ключ
-	id_author – внешний ключ ссылающийся на таблицу с данными о авторах книг
-	book_name – название книги
-	genre – жанр книги
-	pages_number – количество страниц
-	original_language – язык оригинала на котором была написана книга
-	writing_year – год написания книги
-	id_ISBN – код издания книги, внешний ключ на таблицу хранящую данных о изданиях книг

Связь таблиц организована через дополнительную таблицу Book__list которая хранит ссылки на записи из таблицы записей выдачи и соответствующие им записи из таблицы книг.
##### таблица Book_list:
-	Id_book_list – первичный ключ
-	ID_entry – внешний ключ на таблицу Entry
-	ID_book – внешний ключ на таблицу Book
-	returned - метка обозначающая вернули ли книгу по этой записи
-	return_data - дата до какого числа была выдана книга, при продлении данные обновляются

Данные о авторах книг хранятся в отдельной таблице Author. Одному автору может сответствовать несколько книг, по этому связь таблиц книг и авторов имеет вид "многие к одному".
##### таблица Author:
-	Id_author – первичный ключ
-	birth_year– год рождения автора
-	last_name – фамилия автора
-	first_name – имя автора
-	country – страна рождения автора

таблица ISBN хранит данные о издании книги. ISBN - уникальный международный код книг хранящий информацию о конкретном издании книги. Для каждого существующего издания книги существует свой код ISBN. 
##### таблица ISBN
-	Id_ISBN – первичный ключ
-	publisher– название издания книги
-	publication_year - год издания
-	country – страна издательства
-	language – язык на который переведена книга в данном издании


Для хранения данных о посетителях библиотеки выделена таблица Visitor. В ней хранятся личных данных для каждого посетителя и контактные данных для того что бы связаться в случае невозврата книги в срок.
##### таблица Visitor:
-	Id_visitor – первичный ключ
-	birth_data – дата рождения
-	last_name – фамилия посетителя
-	first_name – имя посетителя
-	Email – электронная почта
-	phone_number – личный телефонный номер
-	id_passport – внешний ключ на таблицу хранящую паспортные данные посетителей и работников

Построение схемы велось в. [lucid.app]
Первичные ключи – `PK`
Внешние ключи – `FK`

[![N|Solid](https://i.ibb.co/mb9VJZq/Library-belkov.png)](https://i.ibb.co/mb9VJZq/Library-belkov.png)


   [lucid.app]:https://lucid.app/
  