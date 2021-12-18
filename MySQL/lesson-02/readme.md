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
WHERE name IS NULL;

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

#### Подготовлю таблицу
~~~
> mysql

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

EXIT;
~~~

#### Добавлю в таблицу записи
~~~
> mysql

INSERT INTO files_metadata VALUES
    (default, 1, 'robot.mp3', '/opt/storage_media/content/music/robot.mp3', 'audio', '001 - Robot', 'm$tool', 'Nothing see here', 'Techno'),
    (default, 1, '1965_Bunny_Lake_Is_Missing.mkv', '/opt/storage_media/content/movies/1965_Bunny_Lake_Is_Missing.mkv', 'video', 'Bunny Lake Is Missing', 'Otto Preminger', 'A woman reports that her young daughter is missing, but there seems to be no evidence that she ever existed', 'Drama'),
    (default, 2, '1982_E.T._The_Extra-Terrestrial.mkv', '/opt/storage_media/content/movies/1982_E.T._The_Extra-Terrestrial.mkv', 'video', 'E.T. the Extra-Terrestrial', 'Steven Spielberg', 'A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.', 'Adventure'),
    (default, 3, '1827-The_Death_Of_Sardanapalus.jpg', '/opt/storage_media/content/pictures/1827/1827-The_Death_Of_Sardanapalus.jpg', 'picture', 'The Death of Sardanapalus', 'Eugene Delacroix', 'The composition shows the bearded Sardanapalus lounging (upper left) on a sumptuous divan, in the midst of an orgy of death and destruction', 'Romanticism');

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

|id|owner_user_id|file_name|file_path|tag_type|tag_title|tag_author|tag_description|tag_style|
|-|-|-|-|-|-|-|-|-|
1|1|robot.mp3|/opt/storage_media/content/music/robot.mp3|audio|001 - Robot|m$tool|Nothing see here|Techno
2|1|1965_Bunny_Lake_Is_Missing.mkv|/opt/storage_media/content/movies/1965_Bunny_Lake_Is_Missing.mkv|video|Bunny Lake Is Missing|Otto Preminger|A woman reports that her young daughter is missing, but there seems to be no evidence that she ever existed|Drama
3|2|1982_E.T._The_Extra-Terrestrial.mkv|/opt/storage_media/content/movies/1982_E.T._The_Extra-Terrestrial.mkv|video|E.T. the Extra-Terrestrial|Steven Spielberg|A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.|Adventure
4|3|1827-The_Death_Of_Sardanapalus.jpg|/opt/storage_media/content/pictures/1827/1827-The_Death_Of_Sardanapalus.jpg|picture|The Death of Sardanapalus|Eugene Delacroix|The composition shows the bearded Sardanapalus lounging (upper left) on a sumptuous divan, in the midst of an orgy of death and destruction|Romanticism


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
