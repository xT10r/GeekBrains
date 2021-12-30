## Задание 6

### 1. В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

#### Создам БД sample
~~~
> mysql

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

EXIT;
~~~

#### Создам таблицу users
~~~
> mysql

DROP TABLE IF EXISTS sample.users;
CREATE TABLE sample.users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

EXIT;
~~~

#### Исходная таблица shop.users
|`id`|`name`|`birthday_at`|`created_at`|`updated_at`|
|-|-|-|-|-|
|1|user-af8718d0-51|1977-01-30|2021-12-24 16:50:55|2021-12-24 16:50:55|
|2|user-af871d73-91|1987-02-27|2021-12-24 16:51:05|2021-12-24 16:51:05|
|3|user-af873ba0-61|1997-01-24|2021-12-24 16:51:05|2021-12-24 16:51:05|
|4|user-af87473b-2|1987-08-26|2021-12-24 16:50:57|2021-12-24 16:50:57|
|5|user-af875492-53|2003-03-27|2021-12-24 16:51:00|2021-12-24 16:51:00|
|...|...|...|...|...|

#### Добавлю запись в таблицу users используя транзакцию
~~~
> mysql

START TRANSACTION;
    INSERT INTO sample.users
    SELECT * FROM shop.users WHERE id = 1;
COMMIT;

EXIT;
~~~

#### Результат задания 1. Таблица sample.users

|`id`|`name`|`birthday_at`|`created_at`|`updated_at`|
|-|-|-|-|-|
|1|user-af8718d0-51|1977-01-30|2021-12-24 16:50:55|2021-12-24 16:50:55|




### 2. Создайте представление, которое выводит название (name) товарной позиции из таблицы products и соответствующее название (name) каталога из таблицы catalogs.

#### Получу список всех товаров таблицы products и разделов таблицы catalogs соответствующим товарам

~~~
> mysql

CREATE OR REPLACE VIEW shop.products_names_view (product_id, product_name, catalog_name)
    AS SELECT p.id, p.name, c.name
    FROM shop.products as p
    LEFT JOIN shop.catalogs as c ON p.catalog_id = c.id;

EXIT;
~~~

#### Результат задания 2

~~~
> mysql

SELECT * FROM shop.products_names_view;

EXIT;
~~~

|`product_id`|`product_name`|`catalog_name`|
|-|-|-|
|1|Intel Core i3-8100|Процессоры|
|2|Intel Core i5-7400|Процессоры|
|3|AMD FX-8320E|Процессор AMD|Процессоры|
|4|AMD FX-8320|Процессор AMD|Процессоры|
|5|ASUS ROG MAXIMUS X HERO|Мат. платы|
|6|Gigabyte H310M S2H|Мат. платы|
|7|MSI B250M GAMING PRO|Мат. платы|



### 3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженные календарные записи за август 2018 года '2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

#### Создам таблицу lesson_06_03_some_dates в БД sample и добавлю в неё записи

~~~
> mysql

DROP TABLE IF EXISTS sample.lesson_06_03_some_dates;
CREATE TABLE sample.lesson_06_03_some_dates (
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Календарное поле'
) COMMENT = 'Календарные даты';


INSERT INTO sample.lesson_06_03_some_dates
VALUES
    ('2018-08-01'),
    ('2018-08-04'),
    ('2018-08-16'),
    ('2018-08-17');

EXIT;
~~~

#### Значения таблицы lesson_06_03_some_dates

~~~
> mysql

SELECT * FROM sample.lesson_06_03_some_dates;

EXIT;
~~~

|`created_at`|
|-|
|2018-08-01 00:00:00|
|2018-08-04 00:00:00|
|2018-08-16 00:00:00|
|2018-08-17 00:00:00|

#### Результат задания 3

~~~
> mysql

SET @start_date = '2018-08-01';
WITH RECURSIVE `days` AS
(
    SELECT @start_date as `day`
    UNION ALL
    SELECT @start_date := DATE_ADD(@start_date, INTERVAL 1 DAY)
    FROM `days`
    WHERE @start_date < LAST_DAY(@start_date)
)

SELECT *, IF(calendar_days.created_at IS NOT NULL, 1, 0) as day_exist
FROM `days` as cte_days
LEFT JOIN sample.lesson_06_03_some_dates as calendar_days ON cte_days.day = calendar_days.created_at

EXIT;
~~~

|`day`|`created_at`|`day_exist`|
|-|-|-|
|2018-08-01|2018-08-01 00:00:00|1|
|2018-08-02||0|
|2018-08-03||0|
|2018-08-04|2018-08-04 00:00:00|1|
|2018-08-05||0|
|2018-08-06||0|
|2018-08-07||0|
|2018-08-08||0|
|2018-08-09||0|
|2018-08-10||0|
|2018-08-11||0|
|2018-08-12||0|
|2018-08-13||0|
|2018-08-14||0|
|2018-08-15||0|
|2018-08-16|2018-08-16 00:00:00|1|
|2018-08-17|2018-08-17 00:00:00|1|
|2018-08-18||0|
|2018-08-19||0|
|2018-08-20||0|
|2018-08-21||0|
|2018-08-22||0|
|2018-08-23||0|
|2018-08-24||0|
|2018-08-25||0|
|2018-08-26||0|
|2018-08-27||0|
|2018-08-28||0|
|2018-08-29||0|
|2018-08-30||0|
|2018-08-31||0|

### 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

#### Создам таблицу lesson_06_04_some_dates в БД sample и добавлю в неё записи из услучайно выбранного месяца от текущей даты

~~~
> mysql

DROP TABLE IF EXISTS sample.lesson_06_04_some_dates;
CREATE TABLE sample.lesson_06_04_some_dates (
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Календарное поле'
) COMMENT = 'Календарные даты';

SET @first_date = DATE_ADD(DATE_SUB(LAST_DAY(NOW()), INTERVAL DAY(LAST_DAY(NOW())) -1 DAY), INTERVAL -(ROUND(RAND()*10,0)) MONTH);
INSERT INTO sample.lesson_06_04_some_dates (created_at)
WITH RECURSIVE `days` AS
(
    SELECT @first_date as `day`
    UNION ALL
    SELECT @first_date := DATE_ADD(@first_date, INTERVAL 1 DAY)
    FROM `days`
    WHERE @first_date < LAST_DAY(@first_date)
)
SELECT *
FROM `days` as cte_days;

EXIT;
~~~

#### Удалю записи из таблицы, за исключением 5 свежих записей 

~~~
> mysql

DELETE FROM lesson_06_04_some_dates
WHERE created_at NOT IN
(
    SELECT created_at
    FROM (SELECT * FROM lesson_06_04_some_dates ORDER BY created_at DESC LIMIT 5) as top5
);

EXIT;
~~~

##### Результат задания 4 (на примере дат за ноябрь месяц 2021 года)

~~~
> mysql

SELECT * FROM lesson_06_04_some_dates 

EXIT;
~~~

|`created_ad`|
|-|
|2021-11-26 00:00:00|
|2021-11-27 00:00:00|
|2021-11-28 00:00:00|
|2021-11-29 00:00:00|
|2021-11-30 00:00:00|
