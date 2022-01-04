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
WHERE name IS NULL OR name = '';
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
-- 2.1. Владельцы файлов
DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id INT NOT NULL,
    PRIMARY KEY (id),
    owner_name VARCHAR(255)
) ENGINE=INNODB;

-- 2.2. Тип медиаконтента
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    id INT NOT NULL,
    PRIMARY KEY (id),
    tag_name VARCHAR(256) NOT NULL COMMENT 'Тип медиаконтента: audio/video/picture'
) ENGINE=INNODB;

-- 2.3. Жанр, направление, стиль
DROP TABLE IF EXISTS styles;
CREATE TABLE styles (
    id INT NOT NULL,
    PRIMARY KEY (id),
    style_name VARCHAR(256) COMMENT 'жанр, направление, стиль'
) ENGINE=INNODB;

-- 2.4. метаданные медиа-файлов
DROP TABLE IF EXISTS files_metadata;
CREATE TABLE files_metadata (
	id SERIAL PRIMARY KEY,
    owner_id INT,
    file_name VARCHAR(1024) NOT NULL COMMENT 'Имя файла',
    file_path VARCHAR(256) NOT NULL COMMENT 'Путь до файла',
    tag_id INT,
    tag_title VARCHAR(128) NOT NULL COMMENT 'Заголовок медиа файла',
    tag_author VARCHAR(128) NOT NULL,
    tag_description TEXT,
    style_id INT,
	INDEX index_of_owner_id(owner_id),
	FOREIGN KEY (owner_id)
	    REFERENCES owners(id)
	    ON UPDATE CASCADE
        ON DELETE NO ACTION,
	INDEX index_of_tag_id(tag_id),
	FOREIGN KEY (tag_id)
	    REFERENCES tags(id)
	    ON UPDATE CASCADE
        ON DELETE NO ACTION,
	INDEX index_of_style_id(style_id),
	FOREIGN KEY (style_id)
	    REFERENCES styles(id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
) ENGINE=INNODB;

-- 3. Заполнение таблицы предопределенными данными
-- 3.1. Заполню таблицу owners
INSERT INTO owners (id, owner_name) VALUES
    (1, 'Petrov Ivan'),
    (2, 'Samoylov Michael'),
    (3, 'Ivanov Kirill'),
    (4, 'Simonov Piter'),
    (5, 'Kalinov Denis');

SELECT * FROM owners;

-- 3.2. Заполню таблицу tags
INSERT INTO tags (id, tag_name) VALUES
    (1, 'audio'),
    (2, 'video'),
    (3, 'picture');

SELECT * FROM tags;

-- 3.3. Заполню таблицу styles
INSERT INTO styles (id, style_name) VALUES
    (1, 'Techno'),
    (2, 'Drama'),
    (3, 'Adventure'),
    (4, 'Romanticism');

SELECT * FROM styles;

-- 3.4. Заполню таблицу files_metadata
INSERT INTO files_metadata (id, owner_id, file_name, file_path, tag_id, tag_title, tag_author, tag_description, style_id) VALUES
    (default, 1, 'robot.mp3', '/opt/storage_media/content/music/robot.mp3', 1, '001 - Robot', 'm$tool', 'Nothing see here', 1),
    (default, 2, '1965_Bunny_Lake_Is_Missing.mkv', '/opt/storage_media/content/movies/1965_Bunny_Lake_Is_Missing.mkv', 2, 'Bunny Lake Is Missing', 'Otto Preminger', 'A woman reports that her young daughter is missing, but there seems to be no evidence that she ever existed', 2),
    (default, 3, '1982_E.T._The_Extra-Terrestrial.mkv', '/opt/storage_media/content/movies/1982_E.T._The_Extra-Terrestrial.mkv', 2, 'E.T. the Extra-Terrestrial', 'Steven Spielberg', 'A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.', 3),
    (default, 4, '1827-The_Death_Of_Sardanapalus.jpg', '/opt/storage_media/content/pictures/1827/1827-The_Death_Of_Sardanapalus.jpg', 3, 'The Death of Sardanapalus', 'Eugene Delacroix', 'The composition shows the bearded Sardanapalus lounging (upper left) on a sumptuous divan, in the midst of an orgy of death and destruction', 4);

-- 4. Покажу результат (без связей таблиц)
SELECT * FROM files_metadata;

-- 5. Покажу результат (со связями таблиц)
SELECT
    fm.id,
    fm.file_name,
    fm.file_path,
    fm.tag_title,
    fm.tag_author,
    fm.tag_description,
    o.owner_name,
    t.tag_name,
    s.style_name
FROM files_metadata as fm
LEFT JOIN owners o on fm.owner_id = o.id
LEFT JOIN tags t on fm.tag_id = t.id
LEFT JOIN styles s on fm.style_id = s.id;

-- 6. Покажу список созданных БД (проверю что ничего лишнего не создал)
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