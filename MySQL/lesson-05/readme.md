## Задание 5

### 1. Составьте список пользователей users, которые осуществили хотя бы один заказ (orders) в интернет-магазине.

#### Подготовлю записи таблицы orders, для этого воспользуюсь процедурой (цикл из 20 записей)
~~~
> mysql

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

CALL generate_orders();

EXIT;
~~~
#### Исходная таблица orders (случайные записи)
|`id`|`user_id`|`created_at`|`updated_at`|
|-|-|-|-|
|1|9|2021-10-17 22:50:27|2021-12-27 23:46:27|
|2|15|2021-10-05 23:13:27|2021-12-27 23:46:27|
|3|8|2021-12-18 23:26:27|2021-12-27 23:46:27|
|4|16|2021-12-18 22:33:27|2021-12-27 23:46:27|
|5|26|2021-12-06 23:17:27|2021-12-27 23:46:27|
|6|25|2021-11-09 23:35:27|2021-12-27 23:46:27|
|7|26|2021-10-03 23:10:27|2021-12-27 23:46:27|
|8|25|2021-11-06 23:17:27|2021-12-27 23:46:27|
|9|18|2021-11-12 22:08:27|2021-12-27 23:46:27|
|10|14|2021-12-07 22:50:27|2021-12-27 23:46:27|
|11|24|2021-10-14 22:16:27|2021-12-27 23:46:27|
|12|22|2021-12-01 22:27:27|2021-12-27 23:46:27|
|13|7|2021-12-02 23:07:27|2021-12-27 23:46:27|
|14|9|2021-09-29 23:26:27|2021-12-27 23:46:27|
|15|5|2021-09-28 22:09:27|2021-12-27 23:46:27|
|16|13|2021-12-21 22:55:27|2021-12-27 23:46:27|
|17|28|2021-09-21 23:42:27|2021-12-27 23:46:27|
|18|26|2021-12-24 23:06:27|2021-12-27 23:46:27|
|19|12|2021-12-07 22:17:27|2021-12-27 23:46:27|
|20|11|2021-10-02 22:14:27|2021-12-27 23:46:27|


#### Решение. Вариант 1
~~~
> mysql

SELECT
    u.id as `user_id`,
    count(*) as `order_count`
FROM shop.users as u
INNER JOIN shop.orders as o ON o.user_id = u.id
GROUP BY u.id;

END;
~~~

#### Решение. Вариант 2
~~~
> mysql

SELECT
    o.user_id as `user_id`,
    count(*) as `order_count`
FROM shop.users as u
LEFT JOIN shop.orders as o ON o.user_id = u.id
GROUP BY o.user_id
HAVING `order_count` > 0 AND user_id IS NOT NULL;


END;
~~~


#### Результат задания 1 (случайные записи)
|`user_id`|`order_count`|
|-|-|
|5|1|
|7|1|
|8|1|
|9|2|
|11|1|
|12|1|
|13|1|
|14|1|
|15|1|
|16|1|
|18|1|
|22|1|
|24|1|
|25|2|
|26|3|
|28|1|



### 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

#### Получу список всех товаров таблицы products и разделов таблицы catalogs соответствующим товарам

~~~
> mysql

SELECT *
FROM shop.products as p
INNER JOIN shop.catalogs as c
    ON c.id = p.catalog_id;

EXIT;
~~~

#### Результат задания 2

|`product_id`|`product_name`|`product_description`|`product_price`|`catalog_created_at`|`catalog_updated_at`|`catalog_id`|`catalog_name`|
|-|-|-|-|-|-|-|-|
|1|Intel Core i3-8100|Процессор Intel|7890.00|2021-12-27 14:20:06|2021-12-27 14:20:06|1|Процессоры|
|2|Intel Core i5-7400|Процессор Intel|12700.00|2021-12-27 14:20:06|2021-12-27 14:20:06|1|Процессоры|
|3|AMD FX-8320E|Процессор AMD|4780.00|2021-12-27 14:20:06|2021-12-27 14:20:06|1|Процессоры|
|4|AMD FX-8320|Процессор AMD|7120.00|2021-12-27 14:20:06|2021-12-27 14:20:06|1|Процессоры|
|5|ASUS ROG MAXIMUS X HERO|"Z370| Socket 1151-V2| DDR4| ATX"|19310.00|2021-12-27 14:20:06|2021-12-27 14:20:06|2|Мат. платы|
|6|Gigabyte H310M S2H|"H310| Socket 1151-V2| DDR4| mATX"|4790.00|2021-12-27 14:20:06|2021-12-27 14:20:06|2|Мат. платы|
|7|MSI B250M GAMING PRO|"B250| Socket 1151| DDR4| mATX"|5060.00|2021-12-27 14:20:06|2021-12-27 14:20:06|2|Мат. платы|



### 3. (по желанию) Есть таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов (flights) с русскими названиями городов.

#### В базе данных example создам таблицу cities и наполню записями.

~~~
> mysql

DROP TABLE IF EXISTS example.cities;
CREATE TABLE example.cities (
    label VARCHAR(255),
    name NVARCHAR(255)
) COMMENT = 'Полеты';

INSERT INTO example.cities (label, name)
VALUES
    ('Moscow', 'Москва'),
    ('Saint Petersburg', 'Санкт-Петербург'),
    ('Saratov', 'Саратов'),
    ('Chebarkul', 'Чебаркуль'),
    ('Chelyabinsk', 'Челябинск'),
    ('Miass', 'Миасс');

EXIT;
~~~

#### Значения таблицы cities

|`label`|`name`|
|-|-|
|Moscow|Москва|
|Saint Petersburg|Санкт-Петербург|
|Saratov|Саратов|
|Chebarkul|Чебаркуль|
|Chelyabinsk|Челябинск|
|Miass|Миасс|

#### В базе данных example создам таблицу flights. Для заполнения записями использую процедуру.

~~~
> mysql

-- Создание таблицы
DROP TABLE IF EXISTS example.flights;
CREATE TABLE example.flights (
    `id` SERIAL PRIMARY KEY,
    `from` VARCHAR(255),
    `to` VARCHAR(255)
) COMMENT = 'Полеты';

-- Процедура для заполнения записями
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

-- Сам процесс заполнения (вызов процедуры)
CALL generate_flights();

EXIT;
~~~

#### Значения таблицы flights
|`id`|`from`|`to`|
|-|-|-|
|1|Chelyabinsk|Miass|
|2|Saratov|Chebarkul|
|3|Saint Petersburg|Chelyabinsk|
|4|Moscow|Saint Petersburg|
|5|Miass|Saint Petersburg|
|6|Chelyabinsk|Saint Petersburg|
|7|Saratov|Saint Petersburg|
|8|Miass|Moscow|
|9|Chebarkul|Saint Petersburg|
|10|Saint Petersburg|Moscow|
|11|Saint Petersburg|Saratov|
|12|Moscow|Chelyabinsk|
|13|Saint Petersburg|Miass|
|14|Chebarkul|Saratov|
|15|Saratov|Miass|
|16|Miass|Chelyabinsk|
|17|Chelyabinsk|Saratov|
|18|Chebarkul|Miass|
|19|Chebarkul|Moscow|
|20|Miass|Chebarkul|
|21|Moscow|Miass|
|22|Saratov|Moscow|
|23|Chelyabinsk|Moscow|
|24|Miass|Saratov|
|25|Moscow|Chebarkul|
|26|Saint Petersburg|Chebarkul|
|27|Saratov|Chelyabinsk|
|28|Moscow|Saratov|
|29|Chebarkul|Chelyabinsk|
|30|Chelyabinsk|Chebarkul|

#### Запрос для получения списка маршрутов с русскими названиями городов
~~~
> mysql


SELECT
    f.id as `flight_id`,
    fc.name as `from`,
    tc.name as `to`
FROM example.flights as f
LEFT JOIN example.cities as fc ON f.`from` = fc.label
LEFT JOIN example.cities as tc ON f.`to` = tc.label;

EXIT;
~~~

#### Результат задания 3

|`flight_id`|`from`|`to`|
|-|-|-|
|1|Челябинск|Миасс|
|2|Саратов|Чебаркуль|
|3|Санкт-Петербург|Челябинск|
|4|Москва|Санкт-Петербург|
|5|Миасс|Санкт-Петербург|
|6|Челябинск|Санкт-Петербург|
|7|Саратов|Санкт-Петербург|
|8|Миасс|Москва|
|9|Чебаркуль|Санкт-Петербург|
|10|Санкт-Петербург|Москва|
|11|Санкт-Петербург|Саратов|
|12|Москва|Челябинск|
|13|Санкт-Петербург|Миасс|
|14|Чебаркуль|Саратов|
|15|Саратов|Миасс|
|16|Миасс|Челябинск|
|17|Челябинск|Саратов|
|18|Чебаркуль|Миасс|
|19|Чебаркуль|Москва|
|20|Миасс|Чебаркуль|
|21|Москва|Миасс|
|22|Саратов|Москва|
|23|Челябинск|Москва|
|24|Миасс|Саратов|
|25|Москва|Чебаркуль|
|26|Санкт-Петербург|Чебаркуль|
|27|Саратов|Челябинск|
|28|Москва|Саратов|
|29|Чебаркуль|Челябинск|
|30|Челябинск|Чебаркуль|