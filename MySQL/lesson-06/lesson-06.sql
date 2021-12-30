-- УРОК 6

-- ЗАДАНИЕ 1

-- Задание 1. Создам БД sample
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

-- Задание 1. Создам в БД sample таблицу users
DROP TABLE IF EXISTS sample.users;
CREATE TABLE sample.users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Задание 1. Исходная таблица users БД sample
SELECT * FROM sample.users;

-- Задание 1. Добавлю запись с id = 1 из таблицы shop.users в таблицу sample.users
START TRANSACTION;
    INSERT INTO sample.users
    SELECT * FROM shop.users WHERE id = 1;
COMMIT;

SELECT * FROM shop.users;

-- Задание 1. Результат. Таблица sample.users с записью id = 1.
SELECT * FROM sample.users;


-- ЗАДАНИЕ 2

-- Задание 2. Создам представление по заданию
-- (создать представление, которое выводит название (name) товарной позиции из таблицы products и соответствующее название (name) каталога из таблицы catalogs)
CREATE OR REPLACE VIEW shop.products_names_view (product_id, product_name, catalog_name)
    AS SELECT p.id, p.name, c.name
    FROM shop.products as p
    LEFT JOIN shop.catalogs as c ON p.catalog_id = c.id;

-- Задание 2. Результат
SELECT * FROM shop.products_names_view;


-- ЗАДАНИЕ 3

-- Задание 3. Создам в БД sample таблицу lesson_06_03_some_days
DROP TABLE IF EXISTS sample.lesson_06_03_some_dates;
CREATE TABLE sample.lesson_06_03_some_dates (
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Календарное поле'
) COMMENT = 'Календарные даты';

-- Задание 3. Заполню таблицу lesson_06_calendar_days записями
-- '2018-08-01', '2018-08-04', '2018-08-16' и '2018-08-17'
INSERT INTO sample.lesson_06_03_some_dates
VALUES
    ('2018-08-01'),
    ('2018-08-04'),
    ('2018-08-16'),
    ('2018-08-17');

-- Задание 3. Получу все дни в августе месяце за 2018 год (эталонная таблица дат)
SET @start_date = '2018-08-01';
WITH RECURSIVE `days` AS
(
    SELECT @start_date as `day`
    UNION ALL
    SELECT @start_date := DATE_ADD(@start_date, INTERVAL 1 DAY)
    FROM `days`
    WHERE @start_date < LAST_DAY(@start_date)
)

-- Составлю запрос, что вернёт полный список дат за август 2018 года и столбец содержащий 1/0, где:
-- 1 - если дата из таблицы sample.lesson_06_calendar_days присутствует в эталонной таблице дат
-- 0 - если дата отсутствует

-- Задание 3. Результат
SELECT *, IF(calendar_days.created_at IS NOT NULL, 1, 0) as day_exist
FROM `days` as cte_days
LEFT JOIN sample.lesson_06_03_some_dates as calendar_days ON cte_days.day = calendar_days.created_at;


-- ЗАДАНИЕ 4

-- Задание 4. Создам в БД sample таблицу lesson_06_04_some_days
DROP TABLE IF EXISTS sample.lesson_06_04_some_dates;
CREATE TABLE sample.lesson_06_04_some_dates (
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Календарное поле'
) COMMENT = 'Календарные даты';

-- Задание 4. Заполняю таблицу записями
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

-- Задание 4. Удаляю записи не входящие в выборку первых 5
DELETE FROM lesson_06_04_some_dates
WHERE created_at NOT IN
(
    SELECT created_at
    FROM (SELECT * FROM lesson_06_04_some_dates ORDER BY created_at DESC LIMIT 5) as top5
);

-- Задание 4. Результат
SELECT * FROM sample.lesson_06_04_some_dates;


-- ИЗ УРОКА

/*
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id INT,
    total DECIMAL (11,2) COMMENT 'Счет',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Счета пользователей/покупателей и интернет магазина';

INSERT INTO accounts (user_id, total) VALUES
    (4, 5000.0),
    (3, 0.0),
    (2, 200.0),
    (NULL, 25000.0);

SELECT * FROM accounts;

-- Танзакция
START TRANSACTION;
SELECT total FROM accounts WHERE user_id = 4;
-- Можно использовать точку сохранения/отката
SAVEPOINT accounts_4;
UPDATE accounts SET total = total + 2000 WHERE user_id is NULL;
SELECT * FROM accounts;
COMMIT; -- ROLLBACK TO SAVEPOINT accounts_4;

-- Чтобы отключить режим "автозавершения транзакций" нужно использовать команду
-- SET AUTOCOMMIT = 0; -- SET AUTOCOMMIT = 1;

-- Изменение уровня изоляций транзакции
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Запрос парамтеров журнала транзакций
-- SHOW VARIABLES LIKE 'innodb_log_%';

-- Запрос каталога данных MySQL
-- SHOW VARIABLES LIKE 'datadir';

-- Управление режимом сохранения журнала транзакций
-- innodb_flush_log_at_trx_commit
-- 0 - сохранение журнала раз в секунду
-- 1 - сохранение после каждой транзакции
-- 2 - сохранение журнала раз в секунду и после каждой транзакции

-- Установим сохранение журанала транзакций 'раз в секунду'
-- SHOW VARIABLES LIKE 'innodb_flush_log_at_trx_commit';
-- SET GLOBAL innodb_flush_log_at_trx_commit = 0;

-- Переменные SQL (работа в рамках ондой сессии)
-- SELECT @total := COUNT(*) FROM shop.products;

-- Позиция с самой высокой ценой
-- SELECT @price := MAX(price) FROM shop.products;
-- SELECT * FROM shop.products WHERE price = @price;
-- mysql> SELECT * FROM shop.products WHERE price = @price\G; -- вывод в вертикальном режиме

-- SELECT @id := id FROM shop.products;
-- 'SET' не выводит задаваемое значение переменной
-- SET @last = NOW() - INTERVAL 7 DAY;
-- SELECT @last;

-- Можно нумеровать строки "вручную"
-- DROP TABLE IF EXISTS example.tbl1;
-- CREATE TABLE example.tbl1 (value VARCHAR(255));
-- INSERT INTO example.tbl1 (value) VALUES ('str1'), ('str2'), ('str3'), ('str4'), ('str5');
-- SET @start := 0;
-- SELECT @start := @start + 1 AS id, value FROM example.tbl1;

-- Для просмотра переменных использую команду
-- SHOW VARIABLES;
-- mysql > SHOW VARIABLES\G;
-- SHOW VARIABLES LIKE 'read_buffer_size';

-- Использование глобальных переменных
-- SET GLOBAL read_buffer_size = 2097152;
-- SET @@global.read_buffer_size = 2097152;

-- Использование сессионных переменных
-- SET SESSION read_buffer_size = 2097152;
-- SET @@session.read_buffer_size = 2097152;

-- Установка локальной переменной значения от глобальной
-- SET read_buffer_size = DEFAULT;

-- Временные таблицы
-- DROP TABLE IF EXISTS temp;
-- CREATE TEMPORARY TABLE temp (id INT, name VARCHAR(255));
-- SHOW TABLES; -- Таблица temp будет отсутствовать в списке таблиц БД
-- DESCRIBE temp; -- Но по прежнему можно смотреть структура таблицы temp

-- Динамические запросы
-- PREPARE ver FROM 'SELECT VERSION()'; -- работает в рамках сессии
-- Динамический запрос извлекающий товарные позиции только одного из разделов интернет-магазина
-- PREPARE prd FROM 'SELECT id, name, price FROM shop.products WHERE catalog_id = ?';
-- SET @catalog_id = 1;
-- EXECUTE prd USING @catalog_id;
-- Динамический запрос может иметь более одного параметра. В этом случае параметры будут перечислены после слова USING через запятую

-- Представления
-- Создам представление для таблицы catalogs
USE shop;
CREATE OR REPLACE VIEW catalogs_reverse_view
    AS SELECT * FROM catalogs ORDER BY name;
SELECT * FROM catalogs_view;
SHOW TABLES;

CREATE OR REPLACE VIEW catalogs_reverse_view (catalog, catalog_id)
    AS SELECT name, id FROM catalogs;
SELECT * FROM catalogs_reverse_view;

CREATE OR REPLACE  VIEW namecat (id, name, total)
    AS SELECT id, name, LENGTH(name) FROM catalogs;
SELECT * FROM namecat;

-- Алгоритм формирования конечного запроса (MERGE, TEMPTABLE, UNDEFINED)
CREATE ALGORITHM = TEMPTABLE VIEW cat2
    AS SELECT * FROM catalogs;

DESCRIBE products;

CREATE OR REPLACE VIEW products_view
    AS SELECT id, name, price, catalog_id
    FROM products
    ORDER BY catalog_id, name;
SELECT * FROM products_view;

-- Представление из таблицы products только процессоров
CREATE OR REPLACE VIEW products_processors_view
    AS SELECT id, name, price, catalog_id
    FROM products
    WHERE catalog_id = 1;
SELECT * FROM products_processors_view;

-- Создание и редактирование представления. Вариант 1
CREATE OR REPLACE VIEW v1
    AS SELECT *
    FROM example.tbl1
    WHERE value < 'str5';

-- Редактирование представления. Вариант 2
ALTER VIEW v1
    AS SELECT *
    FROM tbl1
    WHERE value > 'str4';

-- Удаление представления (если есть)
DROP VIEW IF EXISTS
    v1,
    namecat,
    products_view,
    products_processors_view,
    catalogs_view,
    shop.catalogs_reverse_view;

*/