## Задание 3
### 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

#### Добавлю записи в таблицу users ("copy-paste", без цикла)
~~~
> mysql

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


EXIT;
~~~

#### Запрос для обновления записей, где не указаны значния в столбцах created_at, updated_at

~~~
> mysql

UPDATE users
SET created_at = NOW(), updated_at = NOW()
WHERE created_at IS NULL and updated_at IS NULL;

EXIT;
~~~



### 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

#### Изменю в таблице users тип столбцов created_at, updated_at
~~~
> mysql

ALTER TABLE users MODIFY created_at VARCHAR(255);
ALTER TABLE users MODIFY updated_at VARCHAR(255);

EXIT;
~~~

#### Добавлю записи в таблицу users (с форматом даты '%d-%m-%Y %H:%i')

~~~
> mysql

INSERT INTO users (id, name, birthday_at, created_at, updated_at) VALUES
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i')),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i')),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   SUBDATE(SUBDATE(SUBDATE(DATE_ADD(NOW(), INTERVAL -41 YEAR), INTERVAL (FLOOR ( (RAND( ) * 20) - (RAND( ) * 30) )) YEAR), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) MONTH), INTERVAL (FLOOR ( (RAND( ) * 7) - (RAND( ) * 10) )) DAY),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'),   DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -10 SECOND), '%d-%m-%Y %H:%i'));

EXIT;
~~~

#### Конвертирую (и обновляю) записи с форматом даты '%d-%m-%Y %H:%i' в формат DATETIME

~~~
> mysql

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

EXIT;
~~~


### 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Нулевые запасы должны выводиться в конце, после всех записей.

#### Добавлю записи в таблицу storehouses_products

~~~
> mysql

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

EXIT;
~~~

#### Выполню сортировку записей таблицы

~~~
> mysql

SELECT value
FROM storehouses_products
ORDER BY IF(value > 0, 0, 1), value;

EXIT;
~~~

### 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

#### Добавлю записи в таблицу users

~~~
> mysql

INSERT INTO users (id, name, birthday_at, created_at, updated_at) VALUES
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   '1972-05-12',  DATE_ADD(NOW(), INTERVAL -1 SECOND), DATE_ADD(NOW(), INTERVAL -1 SECOND)),
    (default,   CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100))),   '1972-08-03',  DATE_ADD(NOW(), INTERVAL -1 SECOND), DATE_ADD(NOW(), INTERVAL -1 SECOND));

EXIT;
~~~

#### Выполню отбор по датам рождения с месяцами "май" и "август"

~~~
> mysql

SELECT *, LOWER(MONTHNAME(birthday_at)) as month
FROM users
WHERE LOWER(MONTHNAME(birthday_at)) like 'may' OR LOWER(MONTHNAME(birthday_at)) like 'august'

EXIT;
~~~


### 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. 

#### Добавлю записи в таблицу catalogs

~~~
> mysql

INSERT IGNORE INTO catalogs (id, name) VALUES 
    (DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Видеокарты'),
    (DEFAULT, null),
    (DEFAULT, null),
    (DEFAULT, null),
    (DEFAULT, null),
    (DEFAULT, null);

EXIT;
~~~

#### Выполю отбор по id и последующую сортировку полученных значений в заданном порядке

~~~
> mysql

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);

EXIT;
~~~