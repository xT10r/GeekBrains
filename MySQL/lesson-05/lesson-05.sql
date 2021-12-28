-- УРОК 5

USE shop;

-- ЗАДАНИЕ 1

-- Задание 1. Процедура для добавления случайных записей в таблицу заказов с привязкой случайного user_id
DROP PROCEDURE IF EXISTS generate_orders;
CREATE PROCEDURE generate_orders()
BEGIN
  DECLARE num INT;
  SET num = 0;
  WHILE
    num < 20 DO
    INSERT INTO shop.orders (id, user_id, created_at, updated_at)
    VALUES (default, (SELECT id FROM shop.users ORDER BY Rand() LIMIT 1), DATE_ADD(DATE_ADD(NOW(), INTERVAL -ROUND(RAND() * 100, 0) MINUTE ), INTERVAL -ROUND(RAND() * 100, 0) DAY), NOW() );
    SET num = num + 1;
  END WHILE;
END;

-- Задание 1. Обновляю таблицу orders
DROP TABLE IF EXISTS shop.orders;
CREATE TABLE shop.orders (
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

-- Задание 1. Подготовлю записи таблицы orders
CALL generate_orders();

-- Задание 1. Таблица orders со случайными записями
SELECT * FROM shop.orders;

-- Задание 1. Список покупателей сделавших хоть раз заказ в магазине. Вариант 1
SELECT
    u.id as `user_id`,
    count(*) as `order_count`
FROM shop.users as u
INNER JOIN shop.orders as o ON o.user_id = u.id
GROUP BY u.id;

-- Задание 1. Список покупателей сделавших хоть раз заказ в магазине. Вариант 2
SELECT
    o.user_id as `user_id`,
    count(*) as `order_count`
FROM shop.users as u
LEFT JOIN shop.orders as o ON o.user_id = u.id
GROUP BY o.user_id
HAVING `order_count` > 0 AND user_id IS NOT NULL;



-- ЗАДАНИЕ 2

-- Задание 2. Получу список всех товаров таблицы products и разделов таблицы catalogs соответствующим товарам
SELECT *
FROM shop.products as p
INNER JOIN shop.catalogs as c
    ON c.id = p.catalog_id;


-- ЗАДАНИЕ 3

-- Задание 3. Изменю таблицу с которой буду работать (на example)
USE example;

-- Задание 3. Создам таблицу cities
DROP TABLE IF EXISTS example.cities;
CREATE TABLE example.cities (
    label VARCHAR(255),
    name NVARCHAR(255)
) COMMENT = 'Полеты';

-- Задание 3. Добавлю записи в таблицу cities
INSERT INTO example.cities (label, name)
VALUES
    ('Moscow', 'Москва'),
    ('Saint Petersburg', 'Санкт-Петербург'),
    ('Saratov', 'Саратов'),
    ('Chebarkul', 'Чебаркуль'),
    ('Chelyabinsk', 'Челябинск'),
    ('Miass', 'Миасс');

-- Задание 3. Создам таблицу flights
DROP TABLE IF EXISTS example.flights;
CREATE TABLE example.flights (
    `id` SERIAL PRIMARY KEY,
    `from` VARCHAR(255),
    `to` VARCHAR(255)
) COMMENT = 'Полеты';

-- Задание 3. Процедура для генерации маршрутов полетов
DROP PROCEDURE IF EXISTS generate_flights;
CREATE PROCEDURE generate_flights()
BEGIN
    DECLARE n INT;
    DECLARE f, t, ft VARCHAR(255);
    SET n = (SELECT COUNT(*) as count FROM example.cities);
    WHILE n > 0 DO
        SET f = (SELECT label FROM example.cities ORDER BY Rand() LIMIT 1);
        SET t = (SELECT label FROM example.cities ORDER BY Rand() LIMIT 1);
        SET ft = (SELECT count(*) FROM example.flights WHERE `from` = f AND `to` = t LIMIT 1);
        IF (f != t AND ft = 0 ) THEN
            INSERT INTO example.flights (`from`, `to`) VALUES (f, t);
            SET n = n - 1;
        ELSE
            SET n = n - 1;
        END IF;
    END WHILE;
    SELECT * FROM example.flights;
END;

-- Задание 3. Добавлю записи в таблицу flights
CALL generate_flights();

-- Задание 3. Записи таблицы flight
SELECT * FROM example.flights;

-- Задание 3. Список маршрутов с русскими названиями городов
SELECT
    f.id as `flight_id`,
    fc.name as `from`,
    tc.name as `to`
FROM example.flights as f
LEFT JOIN example.cities as fc ON f.`from` = fc.label
LEFT JOIN example.cities as tc ON f.`to` = tc.label;


