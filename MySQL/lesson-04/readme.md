## Задание 4

### 1. Подсчитайте средний возраст пользователей в таблице users.

#### Ниже приведенный запрос посчитает средне значение возраста покупателей
~~~
> mysql

SELECT ROUND(AVG(timestampdiff(YEAR, birthday_at, NOW())), 0) as `average age`
FROM users;

EXIT;
~~~

#### Результат задания 1

|`average age`|
| - |
| 36 |



### 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

#### Вариант 1

~~~
> mysql

SELECT
    DAYNAME(DATE_ADD(birthday_at, INTERVAL (YEAR(NOW())-YEAR(birthday_at)) YEAR)) as `week_day_name`,
    COUNT(*) as `count`
FROM users
GROUP BY
    week_day_name
ORDER BY
	`count` DESC;

EXIT;
~~~

#### Вариант 2

~~~
> mysql

SELECT
    DAYNAME(STR_TO_DATE(CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at)), '%Y-%m-%d')) as `week_day_name`,
    COUNT(*) as `count`
FROM users
GROUP BY
    week_day_name
ORDER BY
	`count` DESC;
	
EXIT;
~~~

#### Результат задания 2

|`week_day_name`|`count`|
| - | - |
|Saturday|6|
|Tuesday|6|
|Wednesday|5|
|Thursday|4|
|Sunday|3|
|Monday|3|
|Friday|2|



### 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.

#### Создам таблицу 'lesson_04_values' и добавлю в неё записи

~~~
> mysql

DROP TABLE IF EXISTS `lesson_04_values`;
CREATE TABLE `lesson_04_values`(
    value SERIAL PRIMARY KEY
);

INSERT INTO `lesson_04_values` VALUES
    (default),
    (default),
    (default),
    (default),
    (default);

EXIT;
~~~

#### Исходная таблица задания 3

|value|
|-|
|1|
|2|
|3|
|4|
|5|

#### Посчитаю произведение всех значений таблицы 'lesson_04_values'

~~~
> mysql

SELECT ROUND(EXP(SUM(LN(value))),0) AS values_sum FROM `lesson_04_values`;

EXIT;
~~~

#### Результат задания 3

|values_sum|
|-|
|120|
