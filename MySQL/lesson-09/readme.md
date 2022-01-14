## Задание 9

### 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа, содержимое поля name.

#### Переключусь на БД shop

~~~
> mysql

USE shop;

EXIT;
~~~

#### Создам таблицу logs

~~~
> mysql

DROP TABLE IF EXISTS logs;
CREATE TABLE IF NOT EXISTS logs (
    `created_at`DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'время и дата создания записи',
    `id` BIGINT(20) NOT NULL COMMENT 'идентификатор первичного ключа',
    `table_name` VARCHAR(64) NOT NULL COMMENT 'название таблицы',
    `name_value` VARCHAR(64) NOT NULL COMMENT 'содержимое поля name'
 ) ENGINE=ARCHIVE DEFAULT CHARSET=UTF8;

EXIT;
~~~

#### Создам однотипные триггеры для таблиц: users, catalogs, products

~~~
> mysql

-- Триггер для таблицы users
DROP TRIGGER IF EXISTS add_user_entry;
DELIMITER //
CREATE TRIGGER add_user_entry AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, id, table_name, name_value)
    VALUES (default, NEW.id, 'users', NEW.name);
END //
DELIMITER ;

-- Триггер для таблицы catalogs
DROP TRIGGER IF EXISTS add_catalog_entry;
DELIMITER //
CREATE TRIGGER add_catalog_entry AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, id, table_name, name_value)
    VALUES (default, NEW.id, 'catalogs', NEW.name);
END //
DELIMITER ;

-- Триггер для таблицы products
DROP TRIGGER IF EXISTS add_product_entry;
DELIMITER //
CREATE TRIGGER add_product_entry AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, id, table_name, name_value)
    VALUES (default, NEW.id, 'products', NEW.name);
END //
DELIMITER ;

EXIT;
~~~

#### Результат задания (проверка работы триггеров)

##### Добавлю записи в таблицу users

~~~
> mysql

INSERT INTO users (name, birthday_at, created_at, updated_at)
VALUES
    ('Петров Семён', '1970-01-05', NOW(), NOW()),
    ('Акимов Павел', '1986-11-13', NOW(), NOW()),
    ('Чернышёв Виктор', '1968-05-01', NOW(), NOW()),
    ('Самойлов Денис', '1997-04-25', NOW(), NOW()),
    ('Симонов Виталий', '1989-08-16', NOW(), NOW());

EXIT;
~~~

##### Результат добавления записей по триггеру `add_user_entry` в таблицу logs

~~~
> mysql

-- shop.users
SELECT * FROM users ORDER BY created_at DESC LIMIT 5;

-- shop.logs
SELECT * FROM logs WHERE table_name = 'users';

EXIT;
~~~

записи таблицы `users`
|`id`|`name`|`birthday_at`|`created_at`|`updated_at`|
|-|-|-|-|-|
|66|Акимов Павел|1986-11-13|2022-01-14 00:41:48|2022-01-14 00:41:48|
|67|Чернышёв Виктор|1968-05-01|2022-01-14 00:41:48|2022-01-14 00:41:48|
|68|Самойлов Денис|1997-04-25|2022-01-14 00:41:48|2022-01-14 00:41:48|
|69|Симонов Виталий|1989-08-16|2022-01-14 00:41:48|2022-01-14 00:41:48|
|65|Петров Семён|1970-01-05|2022-01-14 00:41:48|2022-01-14 00:41:48|

записи таблицы `logs`
|`created_at`|`id`|`table_name`|`name_value`|
|-|-|-|-|
|2022-01-14 00:41:48|65|users,Петров Семён|
|2022-01-14 00:41:48|66|users,Акимов Павел|
|2022-01-14 00:41:48|67|users,Чернышёв Виктор|
|2022-01-14 00:41:48|68|users,Самойлов Денис|
|2022-01-14 00:41:48|69|users,Симонов Виталий|

##### Добавлю записи в таблицу catalogs

~~~
> mysql

INSERT INTO catalogs (name)
VALUES
    ('Принтеры'),
    ('Сканеры'),
    ('Гарнитура'),
    ('Системы охлаждения');

SELECT * FROM catalogs;
SELECT * FROM logs WHERE table_name = 'catalogs';

EXIT;
~~~

##### Результат добавления записей по триггеру `add_catalog_entry` в таблицу logs

~~~
> mysql

-- shop.catalogs
SELECT * FROM catalogs;

-- shop.logs
SELECT * FROM logs WHERE table_name = 'catalogs';

EXIT;
~~~

записи таблицы `catalogs`
|`id`|`name`|
|-|-|
|1|Процессоры|
|2|Мат. платы|
|3|Видеокарты|
|4|Оперативная память|
|5|Мониторы|
|6|Принтеры|
|7|Сканеры|
|8|Гарнитура|
|9|Системы охлаждения|


записи таблицы `logs`
|`created_at`|`id`|`table_name`|`name_value`|
|-|-|-|-|
|2022-01-14 01:41:02|6|catalogs|Принтеры|
|2022-01-14 01:41:02|7|catalogs|Сканеры|
|2022-01-14 01:41:02|8|catalogs|Гарнитура|
|2022-01-14 01:41:02|9|catalogs|Системы охлаждения|

##### Добавлю записи в таблицу products

~~~
> mysql

INSERT INTO products (name, description, price, catalog_id)
VALUES
    ('Canon Pixma G7020','All-in-one, Color, Ethernet, USB, Wireless, PictBridge, A4', 26024, 6),
    ('CanoScan LIDE 400','A4, 300 pdi, USB Type-C', 8500, 7),
    ('Logitech G G332','20-20000Hz, 39 Ohm, 107 dB, microphone', 4200, 8),
    ('Кулер для процессора ID-COOLING DK-01S','LGA 1151-v2, LGA 1156, LGA 1151, AM4', 399, 9);

EXIT;
~~~

##### Результат добавления записей по триггеру `add_product_entry` в таблицу logs

~~~
> mysql

-- shop.products
SELECT * FROM products ORDER BY created_at DESC LIMIT 5;

-- shop.logs
SELECT * FROM logs WHERE table_name = 'products';

EXIT;
~~~

записи таблицы `products`
|`id`|`name`|`description`|`price`|`catalog_id`|`created_at`|`updated_at`|
|-|-|-|-|-|-|-|
|13|Кулер для процессора ID-COOLING DK-01S|"LGA 1151-v2, LGA 1156, LGA 1151, AM4"|399.00|9|2022-01-14 01:56:28|2022-01-14 01:56:28|
|10|Canon Pixma G7020|"All-in-one, Color, Ethernet, USB, Wireless, PictBridge, A4"|26024.00|6|2022-01-14 01:56:28|2022-01-14 01:56:28|
|11|CanoScan LIDE 400|"A4, 300 pdi, USB Type-C"|8500.00|7|2022-01-14 01:56:28|2022-01-14 01:56:28|
|12|Logitech G G332,"20-20000Hz, 39 Ohm, 107 dB, microphone"|4200.00|8|2022-01-14 01:56:28|2022-01-14 01:56:28|
|9|Radeon™ RX 6900 XT|Enthusiast|146282.00|12|2022-01-09 18:24:42|2022-01-09 18:24:42|


записи таблицы `logs`
|`created_at`|`id`|`table_name`|`name_value`|
|-|-|-|-|
|2022-01-14 01:56:28|10|products|Canon Pixma G7020|
|2022-01-14 01:56:28|11|products|CanoScan LIDE 400|
|2022-01-14 01:56:28|12|products|Logitech G G332|
|2022-01-14 01:56:28|13|products|Кулер для процессора ID-COOLING DK-01S|



### 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

#### Вариант 1. Объединение нескольких операторов SELECT в один результирующий набор через UNION ALL

~~~
> mysql

-- Создание таблицы
DROP TABLE IF EXISTS sample.lesson_09_02_01_numbers;
CREATE TABLE sample.lesson_09_02_01_numbers (`numbers` INT NOT NULL);

-- Вставка значений
INSERT INTO sample.lesson_09_02_01_numbers (numbers)
SELECT a.N + b.N * 10 + c.N * 100 + d.N * 1000 + e.N * 10000 + f.N * 100000 + 1 N
FROM
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) e,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) f;
EXIT;
~~~

#### Вариант 1. Результат задания

~~~
> mysql

SELECT COUNT(*) FROM sample.lesson_09_02_01_numbers;

EXIT;
~~~

|`COUNT(*)`|
|-|
|1000000|

#### Вариант 2. Создание миллиона записей используя CTE

~~~
> mysql

-- Создание таблицы
DROP TABLE IF EXISTS sample.lesson_09_02_02_numbers;
CREATE TABLE sample.lesson_09_02_02_numbers (`numbers` INT NOT NULL);

-- Вставка значений
INSERT INTO sample.lesson_09_02_02_numbers (numbers)
WITH numbers AS (
    SELECT 0 AS d UNION ALL
    SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
    SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL
    SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
seq AS (
    SELECT a.d + (10 * b.d) + (100 * c.d) + (1000 * d.d) + (10000 * e.d) + (100000 * f.d) as num
    FROM
        numbers AS a
        CROSS JOIN numbers AS b
        CROSS JOIN numbers AS c
        CROSS JOIN numbers AS d
        CROSS JOIN numbers AS e
        CROSS JOIN numbers AS f
    ORDER BY 1
)
SELECT seq.num AS `numbers`
from seq;

EXIT;
~~~

#### Вариант 2. Результат задания

~~~
> mysql

SELECT COUNT(*) FROM sample.lesson_09_02_02_numbers;

EXIT;
~~~

|`COUNT(*)`|
|-|
|1000000|

#### Вариант 3. Создание миллиона записей используя CTE (более компактный код)

~~~
> mysql

-- Задам значение максимальной глубины рекурсии по количеству записей таблицы (1 млн)
SET SESSION cte_max_recursion_depth = 1000000;

-- Создание таблицы
DROP TABLE IF EXISTS sample.lesson_09_02_03_numbers;
CREATE TABLE sample.lesson_09_02_03_numbers
WITH RECURSIVE sequence (num) AS
(
  SELECT 0 UNION ALL SELECT num + 1 FROM sequence WHERE num + 1 < 1000000
)
--
SELECT num `number`
-- Можно добавить случайные числа в диапазоне 1 млн
-- SELECT FLOOR(1000000 * RAND()) `number`
FROM sequence;

EXIT;
~~~

#### Вариант 3. Результат задания

~~~
> mysql

SELECT COUNT(*) FROM sample.lesson_09_02_03_numbers;

EXIT;
~~~

|`COUNT(*)`|
|-|
|1000000|