-- УРОК 2
-- ЗАДАНИЕ 1

USE shop;

-- Удалю/создам таблицу заново
-- Исходные данные для задания
-- 1. Подготовлю таблицу
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Раздели интернет-магазина';

-- 2. Добавлю записи
INSERT IGNORE INTO catalogs VALUES -- вставка только уникальных, ошибки дублей игнорируются
    (DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Видеокарты');

-- 3. Добавлю неопределенные записи в таблицу catalogs
INSERT IGNORE INTO shop.catalogs (id, name) VALUES
    (default, null),
    (default, null),
    (default, null),
    (default, null),
    (default, null);
SELECT * FROM shop.catalogs;

-- 4.1. Обновлю записи таблицы, уникальность присутствует
-- добавлю игнорирование ошибок
-- в ином случае, появится ошибка о  наличии дублирующих записей и невозможности обновления
-- * [23000][1062] Duplicate entry 'empty' for key 'catalogs.unique_name'
-- * результат: будет обновлена только одна запись
UPDATE IGNORE shop.catalogs
SET name = 'empty'
WHERE name IS NULL;
SELECT * FROM shop.catalogs;

-- 4.2. Обновлю записи таблицы, с удалением индекса уникальности имени (name)
-- * т.к. индекс уникальности будет удален, его по итогу обновления записей нужно добавить заново
-- * результат: удасться обновить все записи, НО индекс уникальности добавить не получится!
/*
ALTER TABLE shop.catalogs drop index unique_name;
UPDATE shop.catalogs
SET name = 'empty'
WHERE name IS NULL;
SELECT * FROM shop.catalogs;
CREATE UNIQUE INDEX unique_name ON shop.catalogs(name);
ANALYZE TABLE shop.catalogs;
*/

-- ЗАДАНИЕ 2
-- Исходные данные для задания
-- Удалю/создам базу данных для хранения "метаданных" файлов медиа-контента
-- ... база данных будет содержать только пути к файлам, названия, описания, ключевых слов и принадлежности пользователю.
-- 1. Подготовлю базу данных
DROP DATABASE IF EXISTS storage_media;
CREATE DATABASE storage_media;
USE storage_media;

-- 2. Подготовлю таблицы
DROP TABLE IF EXISTS files_metadata;
CREATE TABLE files_metadata (
	id SERIAL PRIMARY KEY,
    owner_user_id int,
    file_name VARCHAR(1024) NOT NULL COMMENT 'Имя файла',
    file_path VARCHAR(256) NOT NULL COMMENT 'Путь до файла',
    tag_type VARCHAR(128) NOT NULL COMMENT 'Тип медиаконтента: audio/video/picture',
    tag_title VARCHAR(128) NOT NULL COMMENT 'Заголовок медиа файла',
    tag_author VARCHAR(128) NOT NULL,
    tag_description TEXT,
    tag_style VARCHAR(128) COMMENT 'жанр, направление, стиль'
);

-- 3. Заполнение таблицы предопределенными данными
INSERT INTO files_metadata VALUES
    (default, 1, 'robot.mp3', '/opt/storage_media/content/music/robot.mp3', 'audio', '001 - Robot', 'm$tool', 'Nothing see here', 'Techno'),
    (default, 1, '1965_Bunny_Lake_Is_Missing.mkv', '/opt/storage_media/content/movies/1965_Bunny_Lake_Is_Missing.mkv', 'video', 'Bunny Lake Is Missing', 'Otto Preminger', 'A woman reports that her young daughter is missing, but there seems to be no evidence that she ever existed', 'Drama'),
    (default, 2, '1982_E.T._The_Extra-Terrestrial.mkv', '/opt/storage_media/content/movies/1982_E.T._The_Extra-Terrestrial.mkv', 'video', 'E.T. the Extra-Terrestrial', 'Steven Spielberg', 'A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.', 'Adventure'),
    (default, 3, '1827-The_Death_Of_Sardanapalus.jpg', '/opt/storage_media/content/pictures/1827/1827-The_Death_Of_Sardanapalus.jpg', 'picture', 'The Death of Sardanapalus', 'Eugene Delacroix', 'The composition shows the bearded Sardanapalus lounging (upper left) on a sumptuous divan, in the midst of an orgy of death and destruction', 'Romanticism');

-- 4. Покажу результат
SELECT * FROM files_metadata;

-- 5. Покажу список созданных БД (проверю что ничего лишнего не создал)
SHOW DATABASES;


-- ЗАДАНИЕ 3
-- Исходные данные для задания
-- Создать таблицу 'cat' в БД 'sample', которая будет копией таблицы 'catalog' из БД 'shop'
-- * (...с такими же первичными ключами)

-- 1. Переключу базу данных на 'sample'
USE sample;

-- 2. Создам таблицу 'cat'
DROP TABLE IF EXISTS sample.cat;
CREATE TABLE sample.cat (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

-- 3. Вставлю значения
INSERT INTO sample.cat values
	(DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Видеокарты');

-- 4. Скопирую значения из таблицы 'catalogs' (БД shop) в таблицу 'cat' (БД sample)
-- * Если происходит конфликт по первичным ключам, то заменяю значения в таблице 'cat' значениями из таблицы 'catalogs'
INSERT INTO sample.cat
    SELECT *
    FROM shop.catalogs
    ON DUPLICATE KEY UPDATE id = values(id);

SELECT
       cat.id as cat_id,
       cat.name as cat_name,
       catalogs.id as catalogs_id,
       catalogs.name as catalogs_name
FROM
    sample.cat as cat
LEFT JOIN shop.catalogs as catalogs
    ON cat.id = catalogs.id;