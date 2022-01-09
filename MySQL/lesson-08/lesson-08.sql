-- УРОК 8

USE shop;

-- ЗАДАНИЕ 1
/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
- с 06:00 до 12:00 функция должна возвращать фразу "Доброе утро",
- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
- с 18:00 до 00:00 — "Добрый вечер",
- с 00:00 до 6:00 — "Доброй ночи".
*/

-- Задание 1. Вариант с CASE
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

-- Результат задания 1 (CASE)
CALL hello();

-- Задание 1. Вариант с IF/ELSEIF/ELSE
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

-- Результат задания 1 (IF/ELSEIF/ELSE)
CALL hello();




-- ЗАДАНИЕ 2
/*
В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

-- Задание 2. Создам триггер для таблицы products, БД shop
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

-- Задание 2. Проверка работы триггера. Вызов ошибки
INSERT INTO products (name, description, price, catalog_id)
VALUES
    (NULL, NULL, 10000, 3);

-- Задание 2. Проверка работы триггера. Успешные записи
INSERT INTO products (name, description, price, catalog_id)
VALUES
    ("GeForce RTX 3090", NULL, 192000, 12),
    ("Radeon™ RX 6900 XT", "Enthusiast", 146282, 12);

SELECT name, description, price, catalog_id FROM products;



-- ЗАДАНИЕ 3
/*
(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
Числами Фибоначчи называется последовательность, в которой число равно сумме двух предыдущих чисел.
Вызов функции FIBONACCI(10) должен возвращать число55.
*/

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

-- Результат задания 3. Проверка по условию задачи
SELECT FIBONACCI(10) as `fib(10)`;

-- Результат задания 3. Часть ряда чисел Фибоначчи
CALL get_fibonacci(12);