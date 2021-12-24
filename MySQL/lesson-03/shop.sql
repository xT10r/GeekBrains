-- Урок 2,
-- DROP DATABASE IF EXISTS shop;
-- CREATE DATABASE shop;

USE shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Раздели интернет-магазина';

-- INSERT INTO catalogs VALUES (NULL, 'Процессоры');
-- INSERT INTO catalogs (id, name) VALUES (NULL, 'Мат. платы');
-- INSERT INTO catalogs VALUES (DEFAULT, 'Видеокарты');

INSERT IGNORE INTO catalogs VALUES -- вставка только уникальных, ошибки дублей игнорируются
    (DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Видеокарты');


/*
UPDATE
    catalogs
SET
    name = 'Процессоры (Intel)';
WHERE
    name = 'Процессоры';*/

-- TRUNCATE catalogs; -- при удалении записей таблицы, "сбросится" счетчик инкремента
-- DELETE FROM catalogs WHERE id > 1 LIMIT 1;
/*
DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Раздели интернет-магазина';
*/
/*
INSERT INTO
    cat
SELECT *
FROM catalogs;
SELECT * FROM catalogs;
SELECT * FROM cat;
*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (id, name, birthday_at) VALUES (1, 'hello', '1979-01-27');
SELECT * FROM users;

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

-- CREATE INDEX index_of_catalog

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
    id SERIAL PRIMARY KEY,
    order_id INT UNSIGNED,
    product_id INT UNSIGNED,
    total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товаров',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    -- KEY order_id(order_id, product_id),
    -- KEY product_id(product_id, order_id)

) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED,
    product_id INT UNSIGNED,
    discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
    started_at DATETIME,
    finished_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id),
    KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
    id SERIAL PRIMARY KEY,
    storehouse_id INT UNSIGNED,
    product_id INT UNSIGNED,
    value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Заказы на складе';





