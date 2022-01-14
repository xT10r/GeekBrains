## Задание 8

### 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 06:00 до 12:00 функция должна возвращать фразу "Доброе утро". С 12:00 до 18:00 функция должна возвращать фразу "Добрый день". С 18:00 до 00:00 — "Добрый вечер". С 00:00 до 6:00 — "Доброй ночи".

#### Переключусь на БД shop
~~~
> mysql

USE shop;

EXIT;
~~~

#### Создам процедуру используя CASE (вариант 1)
~~~
> mysql

DROP PROCEDURE IF EXISTS hello;
DELIMITER //
CREATE PROCEDURE hello()
BEGIN
	CASE
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //
DELIMITER ;

EXIT;
~~~

#### Создам процедуру используя IF/ELSEIF/ELSE (вариант 2)

~~~
> mysql

DROP PROCEDURE IF EXISTS hello;
DELIMITER //
CREATE PROCEDURE hello()
BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '12:00:00') THEN
		SELECT 'Доброе утро';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '18:00:00') THEN
		SELECT 'Добрый день';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '00:00:00') THEN
		SELECT 'Добрый вечер';
	ELSE
		SELECT 'Доброй ночи';
	END IF;
END //
DELIMITER ;

EXIT;
~~~

#### Результат задания 1 (вариант 1 / вариант 2)

~~~
> mysql

CALL hello();

EXIT;
~~~

|`Добрый вечер`|
|-|
|Добрый вечер|




### 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

#### Создам триггер для таблицы products

~~~
> mysql

DROP TRIGGER IF EXISTS checkNull_products;
DELIMITER //
CREATE TRIGGER checkNull_products BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		-- пользовательский код ошибки (45000)
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка создания записи. Наименование (name) и описание (description) не могут быть пустыми';
	END IF;
END //
DELIMITER ;

EXIT;
~~~

#### Результат задания 2.
#### Вывод сообщения об ошибке при добавлении "неправильной" записи

~~~
> mysql

INSERT INTO products (name, description, price, catalog_id)
VALUES
    (NULL, NULL, 10000, 3);

EXIT;
~~~

`[45000][1644] Ошибка создания записи. Наименование (name) и описание (description) не могут быть пустыми`

#### Добавление "правильных" записей проходит без ошибок

~~~
> mysql

INSERT INTO products (name, description, price, catalog_id)
VALUES
    ("GeForce RTX 3090", NULL, 192000, 12),
    ("Radeon™ RX 6900 XT", "Enthusiast", 146282, 12);
	
SELECT name, description, price, catalog_id FROM products;

EXIT;
~~~


|`name`|`description`|`price`|`catalog_id`|
|-|-|-|-|
|Intel Core i3-8100|Процессор Intel|7890.00|1
|Intel Core i5-7400|Процессор Intel|12700.00|1
|AMD FX-8320E,Процессор AMD,4780.00|1|
|AMD FX-8320,Процессор AMD,7120.00|1|
|ASUS ROG MAXIMUS X HERO|"Z370, Socket 1151-V2, DDR4, ATX"|19310.00|2|
|Gigabyte H310M S2H|"H310, Socket 1151-V2, DDR4, mATX"|4790.00|2|
|MSI B250M GAMING PRO|"B250, Socket 1151, DDR4, mATX"|5060.00|2|
|GeForce RTX 3090||192000.00|12|
|Radeon™ RX 6900 XT|Enthusiast|146282.00|12|


### 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность, в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

#### Создам функцию для расчета числа Фибоначчи

~~~
> mysql

DROP FUNCTION IF EXISTS FIBONACCI;
DELIMITER //
CREATE FUNCTION FIBONACCI (num BIGINT) RETURNS BIGINT DETERMINISTIC
BEGIN

    DECLARE i, num_count, num_prev BIGINT default 0;
    DECLARE num_next BIGINT default 1;
    DECLARE num_sum, res BIGINT;
    DECLARE num_sign TINYINT DEFAULT 1;

    IF num < 0 THEN SET num_sign = -1; END IF;

    cycle: WHILE (i <= ABS(num)) DO

        IF (i >= ABS(num)) THEN LEAVE cycle;
        END IF;

        SET num_sum = num_prev + num_next * num_sign;
        SET num_prev = num_next;
        SET num_next = num_sum;

        SET i = i + 1;
    END WHILE cycle;

    SET res = num_prev;

    RETURN res;

END //
DELIMITER ;

EXIT;
~~~

#### Выполню проверку по условию из задания. Вызов функции FIBONACCI(10) должен возвращать число 55.

~~~
> mysql

SELECT FIBONACCI(10) as `fib(10)`;

EXIT;
~~~

|`fib(10)`|
|-|
|55|

#### Проверю правильность чисел ряда Фибоначчи, например в диапазоне от -12 до 12. Для этого подготовлю небольшую процедуру

~~~
> mysql

-- Задание 3. Процедура для вывода числе Фибоначчи
DROP PROCEDURE IF EXISTS get_fibonacci;
DELIMITER //
CREATE PROCEDURE get_fibonacci(IN `range` INT)
BEGIN
    DECLARE i INT DEFAULT (ABS(`range`) * -1);
    DROP TABLE IF EXISTS temp_fibonacci;
    CREATE TEMPORARY TABLE temp_fibonacci (`N` INT, `Fn` BIGINT);

    cycle: WHILE (i <= ABS(`range`)) DO
        INSERT INTO temp_fibonacci
        SELECT i, FIBONACCI(i);
        SET i = i + 1;
    END WHILE cycle;

    SELECT * FROM temp_fibonacci;

END //
DELIMITER ;

-- Выполню процедуру
CALL get_fibonacci(12);

EXIT;
~~~

|`N`|`Fn`|
|-|-|
|-12|-144|
|-11|89|
|-10|-55|
|-9|34|
|-8|-21|
|-7|13|
|-6|-8|
|-5|5|
|-4|-3|
|-3|2|
|-2|-1|
|-1|1|
|0|0|
|1|1|
|2|1|
|3|2|
|4|3|
|5|5|
|6|8|
|7|13|
|8|21|
|9|34|
|10|55|
|11|89|
|12|144|
