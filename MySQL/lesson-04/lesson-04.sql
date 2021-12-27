-- УРОК 4

USE shop;

/*
-- ИЗ УРОКА

-- Обновление таблицы products
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    description TEXT COMMENT 'Описание',
    price DECIMAL (11,2) COMMENT 'Цена',
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

-- Исходные записи в таблице products (пусто)
SELECT * FROM products;

INSERT INTO products (name, description, price, catalog_id)
VALUES
    ('Intel Core i3-8100', 'Процессор Intel', 7890.00, 1),
    ('Intel Core i5-7400', 'Процессор Intel', 12700.00, 1),
    ('AMD FX-8320E', 'Процессор AMD', 4780.00, 1),
    ('AMD FX-8320', 'Процессор AMD', 7120.00, 1),
    ('ASUS ROG MAXIMUS X HERO', 'Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
    ('Gigabyte H310M S2H', 'H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
    ('MSI B250M GAMING PRO', 'B250, Socket 1151, DDR4, mATX', 5060.00, 2),
    ('Intel Core i3-8100', 'Процессор Intel', 7890.00, 1),
    ('Intel Core i5-7400', 'Процессор Intel', 12700.00, 1),
    ('AMD FX-8320E', 'Процессор AMD', 4780.00, 1),
    ('AMD FX-8320', 'Процессор AMD', 7120.00, 1),
    ('ASUS ROG MAXIMUS X HERO', 'Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
    ('Gigabyte H310M S2H', 'H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
    ('MSI B250M GAMING PRO', 'B250, Socket 1151, DDR4, mATX', 5060.00, 2);

-- Записи в таблице products (после добавления новых)
SELECT * FROM products;

-- Выберу уникальные записи из таблицы products
SELECT name, description, price, catalog_id
FROM products
GROUP BY name, description, price, catalog_id;

-- Обновление таблицы products_new
DROP TABLE IF EXISTS products_new;
CREATE TABLE products_new (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    description TEXT COMMENT 'Описание',
    price DECIMAL (11,2) COMMENT 'Цена',
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

-- Решим проблему с дублями через промежуточную таблицу products_new
INSERT INTO products_new
SELECT NULL, name, description, price, catalog_id, NOW(), NOW()
FROM products
GROUP BY name, description, price, catalog_id;

-- Содержимое промежуточной таблицы products_new
SELECT name, description, price, catalog_id
FROM products_new;

-- Удаляем таблицу products
DROP TABLE  products;

-- Переименовываем таблицу products_new в products
ALTER TABLE products_new RENAME products;

-- Посмотрим на таблицы в БД shop
SHOW TABLES;
--
*/



-- ЗАДАНИЕ 1

-- Задание 1. Исходные записи таблицы users
SELECT * FROM users;

-- Задание 1. Среднее значение возраста покупателей
SELECT ROUND(AVG(timestampdiff(YEAR, birthday_at, NOW())), 0) as `average age`
FROM users;




-- ЗАДАНИЕ 2

-- Задание 2. Количество дней рождений покупателей в разрезе дней недели (раница в годах)
SELECT
    DAYNAME(DATE_ADD(birthday_at, INTERVAL (YEAR(NOW())-YEAR(birthday_at)) YEAR)) as `week_day_name`,
    COUNT(*) as `count`
FROM users
GROUP BY
    week_day_name
ORDER BY
	`count` DESC;

-- Задание 2. Количество дней рождений покупателей в разрезе дней недели (составная дата из строки)
SELECT
    DAYNAME(STR_TO_DATE(CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at)), '%Y-%m-%d')) as `week_day_name`,
    COUNT(*) as `count`
FROM users
GROUP BY
    week_day_name
ORDER BY
	`count` DESC;




-- ЗАДАНИЕ 3

-- Задание 3. Первым делом подготовлю таблицу для хранения значений _some_values
DROP TABLE IF EXISTS `lesson_04_values`;
CREATE TABLE `lesson_04_values`(
    value SERIAL PRIMARY KEY
);

INSERT INTO `lesson_04_values` VALUES
    (default),
    (default),
    (default),
    (default),
    (default);

-- Задание 3. Исходные записи таблицы `lesson_04_values`
SELECT * FROM lesson_04_values;

-- Задание 3. Подсчет суммы всех значений

SELECT ROUND(EXP(SUM(LN(value))),0) AS values_sum FROM `lesson_04_values`;

-- Задание 3. Удаляю таблицу lesson_04_values (т.к. она была нужна только в рамках заданий урока 4)
DROP TABLE  lesson_04_values;

