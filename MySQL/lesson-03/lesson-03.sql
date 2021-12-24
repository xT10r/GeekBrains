-- УРОК 3

USE shop;



-- ЗАДАНИЕ 1

-- Задание 1. Первым делом создам заново таблицу users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Задание 1. Добавлю (более-менее) случайные записи
INSERT INTO users (id, name, birthday_at, created_at, updated_at) VALUES
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -10 SECOND), DATE_ADD(NOW(), INTERVAL -10 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -8 SECOND), DATE_ADD(NOW(), INTERVAL -8 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -5 SECOND), DATE_ADD(NOW(), INTERVAL -5 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -3 SECOND), DATE_ADD(NOW(), INTERVAL -3 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -1 SECOND), DATE_ADD(NOW(), INTERVAL -1 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -3 SECOND), DATE_ADD(NOW(), INTERVAL -3 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -1 SECOND), DATE_ADD(NOW(), INTERVAL -1 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -3 SECOND), DATE_ADD(NOW(), INTERVAL -3 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -1 SECOND), DATE_ADD(NOW(), INTERVAL -1 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_ADD(NOW(), INTERVAL -3 SECOND), DATE_ADD(NOW(), INTERVAL -3 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   null, null);

-- Задание 1. Исходные записи таблицы users
SELECT * FROM users;

-- Задание 1. Обновление записей таблицы users
UPDATE users
SET created_at = NOW(), updated_at = NOW()
WHERE created_at IS NULL and updated_at IS NULL;

-- Задание 1. Обновленные записи таблицы users (результат)
SELECT * FROM users;




-- ЗАДАНИЕ 2

-- Задание 2. Изменю тип колонок дат с 'date' на 'varchar(255)'
ALTER TABLE users MODIFY created_at VARCHAR(255);
ALTER TABLE users MODIFY updated_at VARCHAR(255);

-- Задание 2. Добавлю записи с датами формата '%d-%m-%Y %H:%i' / '20.10.2021 8:10'
-- * Записи с таким форматом не будут иметь секунд при преобразовании в формат 'date'!
INSERT INTO users (id, name, birthday_at, created_at, updated_at) VALUES

    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i')),

    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i')),

    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'));

-- Задание 2. Исходные записи таблицы users
SELECT * FROM users;

-- Задание 2. Конвертирую (и обновляю) записи с датами формата '%d-%m-%Y %H:%i' / '20.10.2021 8:10'
UPDATE IGNORE users as t
INNER JOIN (SELECT * FROM (
    SELECT
        id,
        STR_TO_DATE(created_at, '%d-%m-%Y %H:%i') as created_at,
        STR_TO_DATE(updated_at, '%d-%m-%Y %H:%i') as updated_at
    FROM users
    WHERE STR_TO_DATE(created_at, '%d-%m-%Y %H:%i') IS NOT NULL AND STR_TO_DATE(updated_at, '%d-%m-%Y %H:%i') IS NOT NULL) as s) as s
ON t.id = s.id
SET t.created_at = s.created_at, t.updated_at = s.updated_at;

-- Задание 2. Обновленные записи таблицы users (результат)
SELECT * FROM users;



-- ЗАДАНИЕ 3

-- Задание 3. Первым делом создам заново таблицу storehouses_products
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
    id SERIAL PRIMARY KEY,
    storehouse_id INT UNSIGNED,
    product_id INT UNSIGNED,
    value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Заказы на складе';

-- Задание 3. Добавлю записи в таблицу storehouses_products
INSERT INTO storehouses_products (id, storehouse_id, product_id, value)
VALUES
    (default, 1, 1, FLOOR ( (RAND( ) * 100))),
    (default, 1, 2, FLOOR ( (RAND( ) * 100))),
    (default, 1, 3, FLOOR ( (RAND( ) * 100))),
    (default, 2, 4, FLOOR ( (RAND( ) * 100))),
    (default, 2, 3, 0),
    (default, 2, 5, FLOOR ( (RAND( ) * 100))),
    (default, 3, 7, 12),
    (default, 4, 8, 0);

-- Задание 3. Исходные записи таблицы storehouses_products
SELECT * FROM storehouses_products;

-- Задание 3. Сортировка значений (результат)
SELECT value
FROM storehouses_products
ORDER BY IF(value > 0, 0, 1), value;


-- ЗАДАНИЕ 4

-- Задание 4. Предварительно добавлю в таблицу пользователей в датами рождения в "Мае" и "Августе"
INSERT INTO users (id, name, birthday_at, created_at, updated_at) VALUES
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   '1972-05-12',  DATE_ADD(NOW(), INTERVAL -1 SECOND), DATE_ADD(NOW(), INTERVAL -1 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   '1972-08-03',  DATE_ADD(NOW(), INTERVAL -1 SECOND), DATE_ADD(NOW(), INTERVAL -1 SECOND));

-- Задание 4. Извлечение пользователей по выбранным месяцам из даты рождения (результат)
SELECT *, LOWER(MONTHNAME(birthday_at)) as month
FROM users
WHERE LOWER(MONTHNAME(birthday_at)) like 'may' OR LOWER(MONTHNAME(birthday_at)) like 'august'



-- ЗАДАНИЕ 5

-- Задание 5. Первым делом создам заново таблицу catalogs
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Раздели интернет-магазина';

-- Задание 5. Добавлю записи
INSERT IGNORE INTO catalogs (id, name) VALUES -- вставка только уникальных, ошибки дублей игнорируются
    (DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Видеокарты'),
    (DEFAULT, null),
    (DEFAULT, null),
    (DEFAULT, null),
    (DEFAULT, null),
    (DEFAULT, null);

-- Задание 5. Исходные записи таблицы catalogs
SELECT * FROM catalogs;

-- Задание 5. Выполю упорядочивание значений столбца id в заданной последовательности (результат)
SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);