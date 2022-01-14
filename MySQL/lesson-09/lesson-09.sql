-- УРОК 9

USE shop;

-- ЗАДАНИЕ 1
-- Создайте таблицу logs типа Archive.
-- Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается:
--   время и дата создания записи,
--   название таблицы,
--   идентификатор первичного ключа
--   содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE IF NOT EXISTS logs (
    `created_at`DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'время и дата создания записи',
    `id` BIGINT(20) NOT NULL COMMENT 'идентификатор первичного ключа',
    `table_name` VARCHAR(64) NOT NULL COMMENT 'название таблицы',
    `name_value` VARCHAR(64) NOT NULL COMMENT 'содержимое поля name'
 ) ENGINE=ARCHIVE DEFAULT CHARSET=UTF8;

-- Задание 2. Триггер для таблицы users
DROP TRIGGER IF EXISTS add_user_entry;
DELIMITER //
CREATE TRIGGER add_user_entry AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, id, table_name, name_value)
    VALUES (default, NEW.id, 'users', NEW.name);
END //
DELIMITER ;

-- Задание 2. Триггер для таблицы catalogs
DROP TRIGGER IF EXISTS add_catalog_entry;
DELIMITER //
CREATE TRIGGER add_catalog_entry AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, id, table_name, name_value)
    VALUES (default, NEW.id, 'catalogs', NEW.name);
END //
DELIMITER ;

-- Задание 2. Триггер для таблицы products
DROP TRIGGER IF EXISTS add_product_entry;
DELIMITER //
CREATE TRIGGER add_product_entry AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs (created_at, id, table_name, name_value)
    VALUES (default, NEW.id, 'products', NEW.name);
END //
DELIMITER ;

-- Задание 2. Проверка триггера для таблицы users
INSERT INTO users (name, birthday_at, created_at, updated_at)
VALUES
    ('Петров Семён', '1970-01-05', NOW(), NOW()),
    ('Акимов Павел', '1986-11-13', NOW(), NOW()),
    ('Чернышёв Виктор', '1968-05-01', NOW(), NOW()),
    ('Самойлов Денис', '1997-04-25', NOW(), NOW()),
    ('Симонов Виталий', '1989-08-16', NOW(), NOW());

-- shop.users
SELECT * FROM users ORDER BY created_at DESC LIMIT 5;
-- shop.logs
SELECT * FROM logs WHERE table_name = 'users';

-- Задание 2. Проверка триггера для таблицы catalogs
INSERT INTO catalogs (name)
VALUES
    ('Принтеры'),
    ('Сканеры'),
    ('Гарнитура'),
    ('Системы охлаждения');

-- shop.catalogs
SELECT * FROM catalogs;
-- shop.logs
SELECT * FROM logs WHERE table_name = 'catalogs';

-- Задание 2. Проверка триггера для таблицы products
INSERT INTO products (name, description, price, catalog_id)
VALUES
    ('Canon Pixma G7020','All-in-one, Color, Ethernet, USB, Wireless, PictBridge, A4', 26024, 6),
    ('CanoScan LIDE 400','A4, 300 pdi, USB Type-C', 8500, 7),
    ('Logitech G G332','20-20000Hz, 39 Ohm, 107 dB, microphone', 4200, 8),
    ('Кулер для процессора ID-COOLING DK-01S','LGA 1151-v2, LGA 1156, LGA 1151, AM4', 399, 9);

-- shop.products
SELECT * FROM products ORDER BY created_at DESC LIMIT 5;
-- shop.logs
SELECT * FROM logs WHERE table_name = 'products';

-- ЗАДАНИЕ 2
-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- ЗАДАНИЕ 2. ВАРИАНТ 1. Объединение нескольких операторов SELECT в один результирующий набор через UNION ALL
-- Создание таблицы
DROP TABLE IF EXISTS sample.lesson_09_02_numbers;
CREATE TABLE sample.lesson_09_02_numbers (`numbers` INT NOT NULL);

-- Вставка значений
INSERT INTO sample.lesson_09_02_numbers (numbers)
SELECT a.N + b.N * 10 + c.N * 100 + d.N * 1000 + e.N * 10000 + f.N * 100000 + 1 N
FROM
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) e,
    (SELECT 0 as N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) f;

-- Результат задания
SELECT COUNT(*) FROM sample.lesson_09_02_numbers;

-- ЗАДАНИЕ 2. ВАРИАНТ 2. Создание миллиона записей используя CTE
-- Создание таблицы
DROP TABLE IF EXISTS sample.lesson_09_02_numbers;
CREATE TABLE sample.lesson_09_02_numbers (`numbers` INT NOT NULL);

-- Вставка значений
INSERT INTO sample.lesson_09_02_numbers (numbers)
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

-- Результат задания
SELECT COUNT(*) FROM sample.lesson_09_02_numbers;

-- ЗАДАНИЕ 2. ВАРИАНТ 3. Создание миллиона записей используя CTE
-- Задам значение максимальной глубины рекурсии по количеству записей таблицы (1 млн)
SET SESSION cte_max_recursion_depth = 1000000;

-- Создание таблицы
DROP TABLE IF EXISTS sample.lesson_09_02_numbers;
CREATE TABLE sample.lesson_09_02_numbers
WITH RECURSIVE sequence (num) AS
(
  SELECT 0 UNION ALL SELECT num + 1 FROM sequence WHERE num + 1 < 1000000
)
--
SELECT num `number`
-- Можно добавить случайные числа в диапазоне 1 млн
-- SELECT FLOOR(1000000 * RAND()) `number`
FROM sequence;

SELECT COUNT(*) FROM sample.lesson_09_02_numbers;


/*
-- ИЗ УРОКА

-- Путь к каталогу данных
SHOW VARIABLES LIKE 'datadir';
SHOW ENGINES\G;

-- Посмотреть объём выделенной опертивной памяти под кэш MyISAM индексов
SHOW VARIABLES LIKE 'Key%';

-- Оценить эффективность данного кэша можно при помощи команды:
SHOW STATUS LIKE 'Key%';

-- Посмотреть объём буфера выделенного под InnoDB можно при помощи команды:
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';

-- ! Под пул буферов рекомендуется выделять 50~80% оперативной памяти

-- Оценить эффективность кэша InnoDB можно при помощи команды:
SHOW STATUS LIKE 'Innodb_buffer_pool_%';

SHOW TABLES;

-- Оптимизация запроса начинается с отказа от '*' в SELECT

-- Основной способ узнать какие решения принимает оптимизатор это использование команды EXPLAIN
-- EXPLAIN применяется только к запросам SELECT

SELECT id, name FROM catalogs ORDER BY id;
EXPLAIN SELECT id, name FROM catalogs ORDER BY id;



*/