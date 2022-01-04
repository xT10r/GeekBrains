## Задание 2
### 1. Пусть в таблице catalogs базы данных shop в строке name могут находиться пустые строки и поля, принимающие значение NULL. Напишите запрос, который заменяет все такие поля на строку ‘empty’. Помните, что на уроке мы установили уникальность на поле name. Возможно ли оставить это условие? Почему?

#### Запрос для обновления всех записей (null в «empty»), без учета уникальности
~~~
> mysql

UPDATE shop.catalogs
SET name = 'empty'
WHERE name IS NULL;
SELECT * FROM shop.catalogs;

EXIT;
~~~

#### Запрос для обновления записей (одной штуки) с учетом уникальности

~~~
> mysql

UPDATE IGNORE shop.catalogs
SET name = 'empty'
WHERE name IS NULL;
SELECT * FROM shop.catalogs;

EXIT;
~~~

#### Запрос для обновления всех записей (null в «empty») со снятием ключа уникальности

~~~
> mysql

ALTER TABLE shop.catalogs drop index unique_name;
UPDATE shop.catalogs
SET name = 'empty'
WHERE name IS NULL OR name = '';

EXIT;
~~~

----

Ответ на вопрос:
- Если есть необходимость в сохранении уникальности по столбцу name, то обновить «все» записи со значением null в "empty" нельзя. Можно лишь их "вычистить".
- Если же есть необходимость именно в обновлении "всех" записей, то требуется отказаться от уникальности (убрать индекс и обновить записи)


### 2. Спроектируйте базу данных, которая позволяла бы организовать хранение медиафайлов, загружаемых пользователем (фото, аудио, видео). Сами файлы будут храниться в файловой системе, а база данных будет содержать только пути к файлам, названия, описания, ключевых слов и принадлежности пользователю.

#### Подготовлю базу данных
~~~
> mysql

DROP DATABASE IF EXISTS storage_media;
CREATE DATABASE storage_media;
USE storage_media;

EXIT;
~~~

#### Подготовлю таблицы
#### 1. Владельцы файлов

~~~
> mysql

DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id INT NOT NULL,
    PRIMARY KEY (id),
    owner_name VARCHAR(255)
) ENGINE=INNODB;

EXIT;
~~~

#### 2. Тип медиаконтента

~~~
> mysql

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    id INT NOT NULL,
    PRIMARY KEY (id),
    tag_name VARCHAR(256) NOT NULL COMMENT 'Тип медиаконтента: audio/video/picture'
) ENGINE=INNODB;

EXIT;
~~~

#### 3. Жанр, направление, стиль

~~~
> mysql

DROP TABLE IF EXISTS styles;
CREATE TABLE styles (
    id INT NOT NULL,
    PRIMARY KEY (id),
    style_name VARCHAR(256) COMMENT 'жанр, направление, стиль'
) ENGINE=INNODB;

EXIT;
~~~

#### 4. Метаданные медиа-файлов

~~~
> mysql

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

EXIT;
~~~

#### Добавлю в таблицы записи

#### 1. Заполю таблицу owners

~~~
> mysql

INSERT INTO owners (id, owner_name) VALUES
    (1, 'Petrov Ivan'),
    (2, 'Samoylov Michael'),
    (3, 'Ivanov Kirill'),
    (4, 'Simonov Piter'),
    (5, 'Kalinov Denis');

EXIT;
~~~

#### 2. Заполню таблицу tags

~~~
> mysql

INSERT INTO tags (id, tag_name) VALUES
    (1, 'audio'),
    (2, 'video'),
    (3, 'picture');

EXIT;
~~~


#### 3. Заполню таблицу styles

~~~
> mysql

INSERT INTO styles (id, style_name) VALUES
    (1, 'Techno'),
    (2, 'Drama'),
    (3, 'Adventure'),
    (4, 'Romanticism');

EXIT;
~~~


#### 4. Заполню таблицу files_metadata

~~~
> mysql

INSERT INTO files_metadata (id, owner_id, file_name, file_path, tag_id, tag_title, tag_author, tag_description, style_id) VALUES
    (default, 1, 'robot.mp3', '/opt/storage_media/content/music/robot.mp3', 1, '001 - Robot', 'm$tool', 'Nothing see here', 1),
    (default, 2, '1965_Bunny_Lake_Is_Missing.mkv', '/opt/storage_media/content/movies/1965_Bunny_Lake_Is_Missing.mkv', 2, 'Bunny Lake Is Missing', 'Otto Preminger', 'A woman reports that her young daughter is missing, but there seems to be no evidence that she ever existed', 2),
    (default, 3, '1982_E.T._The_Extra-Terrestrial.mkv', '/opt/storage_media/content/movies/1982_E.T._The_Extra-Terrestrial.mkv', 2, 'E.T. the Extra-Terrestrial', 'Steven Spielberg', 'A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.', 3),
    (default, 4, '1827-The_Death_Of_Sardanapalus.jpg', '/opt/storage_media/content/pictures/1827/1827-The_Death_Of_Sardanapalus.jpg', 3, 'The Death of Sardanapalus', 'Eugene Delacroix', 'The composition shows the bearded Sardanapalus lounging (upper left) on a sumptuous divan, in the midst of an orgy of death and destruction', 4);

EXIT;
~~~

#### Посмотрю результат
~~~
> mysql

SELECT * FROM files_metadata;
SHOW DATABASES;

EXIT;
~~~

#### Результат в табличном виде

|id|owner_id|file_name|file_path|tag_id|tag_title|tag_author|tag_description|style_id|
|-|-|-|-|-|-|-|-|-|
1|1|robot.mp3|/opt/storage_media/content/music/robot.mp3|1|001 - Robot|m$tool|Nothing see here|1|
2|2|1965_Bunny_Lake_Is_Missing.mkv|/opt/storage_media/content/movies/1965_Bunny_Lake_Is_Missing.mkv|2|Bunny Lake Is Missing|Otto Preminger|A woman reports that her young daughter is missing, but there seems to be no evidence that she ever existed|2|
3|3|1982_E.T._The_Extra-Terrestrial.mkv|/opt/storage_media/content/movies/1982_E.T._The_Extra-Terrestrial.mkv|2|E.T. the Extra-Terrestrial|Steven Spielberg|A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.|3|
4|4|1827-The_Death_Of_Sardanapalus.jpg|/opt/storage_media/content/pictures/1827/1827-The_Death_Of_Sardanapalus.jpg|3|The Death of Sardanapalus|Eugene Delacroix|The composition shows the bearded Sardanapalus lounging (upper left) on a sumptuous divan, in the midst of an orgy of death and destruction|4|


### 3. (по желанию) В учебной базе данных shop присутствует таблица catalogs. Пусть в базе данных sample имеется таблица cat, в которой могут присутствовать строки с такими же первичными ключами. Напишите запрос, который копирует данные из таблицы catalogs в таблицу cat, при этом для записей с конфликтующими первичными ключами в таблице cat должна производиться замена значениями из таблицы catalogs.

#### Переключу БД на 'sample'
~~~
> mysql

USE sample;

EXIT;
~~~

#### Создам таблицу 'cat'
~~~
> mysql

DROP TABLE IF EXISTS sample.cat;
CREATE TABLE sample.cat (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

EXIT;
~~~

#### Добавлю начальные значения
~~~
> mysql

INSERT INTO sample.cat values
  (DEFAULT, 'Процессоры'),
  (DEFAULT, 'Мат. платы'),
  (DEFAULT, 'Видеокарты');

EXIT;
~~~

#### (*) Скопирую значения из таблицы 'catalogs'
~~~
> mysql

INSERT INTO sample.cat
    SELECT *
    FROM shop.catalogs
    ON DUPLICATE KEY UPDATE id = values(id);

EXIT;
~~~

#### Посмотрю результат
~~~
> mysql

SELECT
       cat.id as cat_id,
       cat.name as cat_name,
       catalogs.id as catalogs_id,
       catalogs.name as catalogs_name
FROM
    sample.cat as cat
LEFT JOIN shop.catalogs as catalogs
    ON cat.id = catalogs.id;
    
EXIT;
~~~

#### Результат в табличном виде
|cat_id|cat_name|catalogs_id|catalogs_name|
|-|-|-|-|
|1|Процессоры|1|Процессоры
|2|Мат. платы|2|Мат. платы
|3|Видеокарты|3|Видеокарты
|4|empty|4|empty
|5||5|
|6||6|
|7||7|
|8||8|
