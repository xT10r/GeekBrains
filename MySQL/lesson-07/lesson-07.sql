-- УРОК 7

-- ЗАДАНИЕ 1
-- Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

-- Задание 1. Создам пользователей
-- Удаление ранее созданных пользователей можно опустить, но в рамках задания буду его использовать для удобства
DROP USER IF EXISTS shop_read, shop_admin;
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'pa$$w0rd';
CREATE USER shop_admin IDENTIFIED WITH sha256_password BY 'pa$$w0rd';

-- Задание 1. Выдам пользователю 1 права на чтение данных и выполнение запросов
GRANT SELECT ON shop.* TO shop_read;

-- Задание 1. Выдам пользователю 2 права на любые операции в пределах БД shop
GRANT ALL ON shop.* TO shop_admin;

-- Задание 1. "Сброшу" привелегии (применю настройки)
FLUSH PRIVILEGES;

-- Задание 1. Посмотрю на перечень прав выданных пользваотелям
SELECT Host, Db, User, Select_priv, Create_priv, Insert_priv, Update_priv, Delete_priv, Alter_priv
FROM mysql.db
WHERE
    USER = 'shop_read'
    OR USER = 'shop_admin';


-- ЗАДАНИЕ 2
-- (по желанию)
-- Есть таблица (accounts), включающая в себя три столбца: id, name, password, которые содержат первичный ключ, имя пользователя и его пароль.
-- Создайте представление username таблицы accounts, предоставляющее доступ к столбцам id и name.
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username.

-- Задание 2. Создам таблицу accounts в БД sample
DROP TABLE IF EXISTS sample.accounts;
CREATE TABLE sample.accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    password VARCHAR(1024)
) COMMENT 'Учетные данные пользователей';

-- Задание 2. Создам процедуру для добавления случайных аккаунтов
DROP PROCEDURE IF EXISTS generate_sample_accounts;
CREATE PROCEDURE generate_sample_accounts()
BEGIN
    DECLARE account_num INT;
    DECLARE u_name, u_password VARCHAR(255);
    SET account_num = 0;
    WHILE account_num < 20 DO
        SET u_name = CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100)));
        SET u_password = SUBSTRING(MD5(RAND()) FROM 1 FOR 10);
        INSERT INTO sample.accounts (id, name, password)
        VALUES (default, u_name, u_password);
        SET account_num = account_num + 1;
    END WHILE;
END;

-- Задание 2. Добавлю случайные аккаунты (20 штук)
CALL generate_sample_accounts();

-- Задание 2. Таблица случайных аккаунтов
SELECT * FROM sample.accounts;

-- Задание 2. Создам представление 'username' таблицы sample.accounts со столбцами (id, name)
CREATE OR REPLACE VIEW sample.username(id, user)
    AS SELECT acc.id, acc.name
    FROM sample.accounts as acc;

-- Задание 2. Представление username
SELECT * FROM sample.username;

-- Задание 2. Создам пользователя user_read
DROP USER IF EXISTS user_read;
CREATE USER user_read IDENTIFIED WITH sha256_password BY 'pa$$w0rd';

-- Задание 2. Предоставлю пользователю user_read право на чтение представления sample.username
GRANT SELECT ON sample.username TO user_read;

-- Задание 2. "Сброшу" привелегии (применю настройки)
FLUSH PRIVILEGES;

-- Задание 2. Посмотрю привилегии пользователя user_read
SHOW GRANTS FOR user_read;


-- ИЗ УРОКА
/*
-- Создам пользователя 'shop'
CREATE USER shop IDENTIFIED WITH sha256_password BY 'pa$$w0rd';

-- Запущу MySQL от пользователя 'shop'
-- > mysql -u shop -p'pa$$w0rd'
-- > SELECT USER();

-- Удалю пользователя 'foo'
-- > DROP USER foo;

-- Переименую пользователя 'shop' -> 'foo'
-- > RENAME USER shop TO foo;

SELECT User, Host, plugin FROM mysql.user;

-- Добавлю ВСЕ права пользователю 'foo@%'
GRANT ALL ON *.* TO 'foo'@'%';

-- Отберу ВСЕ права пользователя 'foo@%'
REVOKE ALL ON *.* FROM 'foo'@'%';

-- Привелегии разные, поэтому следует правильно выбирать их перед добавлением пользователю
-- ALL, ALTER, CREATE, DELETE, DROP, EXECUTE, INDEX, INSERT, REFERENCES, SELECT, SHOW DATABASES, SHOW VIEW, USAGE, GRANT OPTION

GRANT SELECT, INSERT, DELETE, UPDATE ON *.* TO foo;

-- Ключевое слово ALL должно применяться отдельно при выдаче прав
GRANT ALL ON *.* TO foo;

GRANT GRANT OPTION ON *.* TO foo;

-- Выдача прав только на одну БД
GRANT USAGE ON shop.* TO foo;

-- Посмотрю все привелегии (просмотр от пользователя root)
SHOW GRANTS;
*/






