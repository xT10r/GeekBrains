-- УРОК 8

-- ПРОЦЕДУРЫ

USE shop;

-- Создадим примитивную процедуру возвращающую версию MySQL
-- * если процедуру необходимо создать в конкретной БД, то требуется это указать
-- * 'CREATE PROCEDUTE shop.my_version ()'
DROP FUNCTION IF EXISTS my_version;
DELIMITER //
CREATE PROCEDURE my_version ()
BEGIN
   SELECT VERSION();
END//
DELIMITER ;

-- Посмотреть все процедуры можно при помощи команды
-- * можно указать параметры для отбора нужных процедур
SHOW PROCEDURE STATUS
WHERE NOT Db = 'sys' AND Type = 'PROCEDURE';

-- Посмотреть все функции можно при помощи команды
-- * можно указать параметры для отбора нужных функций
SHOW FUNCTION STATUS
WHERE NOT Db = 'sys' AND Type = 'FUNCTION';

-- Для удаления процедуры используем команду (используем условие 'если процедура существует')
DROP PROCEDURE IF EXISTS my_version;


-- ФУНКЦИИ

-- Создам примитивную функцию возвращающую версию MySQL
-- Т.к. возвращаемое значение текущей функции всегда постоянно, то добавляем к возвращаемому значению 'DETERMINISTIC'
-- * в ином случае (когда значение возвращемое функцией не постоянно, то добавляем 'NOT DETERMINISTIC'
-- * чтобы вызываемая функция отрабатывала корректно перед её исполнением изменю символ окончания запроса ';' на '\\'
DROP FUNCTION IF EXISTS get_version;
DELIMITER //
CREATE FUNCTION get_version ()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    RETURN VERSION();
END//
DELIMITER ;



-- Создам примитивную процедуру записывающую входящее значение в локальную переменную '@x'
/*
DROP PROCEDURE IF EXISTS set_x;
DELIMITER //
CREATE PROCEDURE set_x (in value INT)
BEGIN
   SET @x = value;
END//
DELIMITER ;
*/
-- Чтобы процедура могла принимать значение, нужно перед параметром 'value' указать тип 'IN'
-- CREATE PROCEDURE set_x (IN value INT)
-- Чтобы процедура возращала значение, нужно перед параметром 'value' указать тип 'OUT'
-- * в этом случае нельзя передать в процедуру параметр, можно лишь получить его из процедуры
/*
DROP PROCEDURE IF EXISTS set_x;
DELIMITER //
CREATE PROCEDURE set_x (out value INT)
BEGIN
   SET @x = value;
   SET value = 1000;
END//
DELIMITER ;
*/
-- Для того чтобы передавать в процедуру значение параметра и получать его обратно, нужно перед параметром 'value' указать тип 'INOUT'
DROP PROCEDURE IF EXISTS set_x;
DELIMITER //
CREATE PROCEDURE set_x (inout value INT)
BEGIN
   SET @x = value;
   SET value = value - 1000;
END//
DELIMITER ;
-- SET @y = 10000 //
-- передадим значение в качестве входного в процедуру set_x(@y)


-- Процедура для декларирования переменных (1)
-- * переменная объявленная во внутреннем блоке не выйдет за рамки этого блока
DROP PROCEDURE IF EXISTS declare_var;
DELIMITER //
CREATE PROCEDURE declare_var ()
BEGIN
    DECLARE var TINYTEXT DEFAULT 'внешняя переменная';
    BEGIN
        DECLARE var TINYTEXT DEFAULT 'внутренняя переменная';
        SELECT var;
    END;
    SELECT var;
END //
DELIMITER ;
-- CALL example.declare_var


-- Процедура для декларирования переменных (2)
-- * переменная, объявленная во внешнем блоке будет видна и во внутреннем блоке
DROP PROCEDURE IF EXISTS one_declare_var;
DELIMITER //
CREATE PROCEDURE one_declare_var ()
BEGIN
    DECLARE var TINYTEXT DEFAULT 'внешняя переменная';
    BEGIN
        SELECT var;
    END;
    SELECT var;
END //
DELIMITER ;
-- CALL example.one_declare_var


-- Функция принимающая в качестве параметра количество секунд и возвращающая количество дней, часов, минут и секунд в переданном значении
DROP FUNCTION IF EXISTS second_format;
CREATE FUNCTION second_format (seconds INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE days, hours, minutes INT;

    SET days = FLOOR( seconds / 86400 );
    SET seconds = seconds - days * 86400;
    SET hours = FLOOR( seconds / 3600 );
    SET seconds = seconds - hours * 3600;
    SET minutes = FLOOR( seconds / 60 );
    SET seconds = seconds - minutes * 60;

    RETURN CONCAT(
        days, " days ",
        hours, " hours ",
        minutes, " minutes ",
        seconds, " seconds");
END;
-- SELECT shop.second_format(123456);
-- SELECT shop.second_format(120);


-- Процедура возвращая количество строк в таблице 'catalogs' БД 'shop'
DROP PROCEDURE IF EXISTS numcatalogs;
DELIMITER //
CREATE PROCEDURE numcatalogs (OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM catalogs;
END //
DELIMITER ;

/*
CALL shop.numcatalogs(@a);
SELECT @a as 'catalog rows';
 */


-- Процедра с ветвлениями IF/ELSEIF/ELSE
DROP PROCEDURE IF EXISTS format_now;
DELIMITER //
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
    IF (format = 'date') THEN
        SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
    ELSEIF (format = 'time') THEN
        SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
    ELSE
        SELECT UNIX_TIMESTAMP( NOW() ) AS format_now;
    END IF;
END //
DELIMITER ;

/*
CALL shop.format_now('date');
CALL shop.format_now('time');
CALL shop.format_now('');
*/

-- Процедура с множественным выбором CASE
DROP PROCEDURE IF EXISTS format_now;
DELIMITER //
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
    CASE format
        WHEN 'date' THEN
            SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
        WHEN 'time' THEN
            SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
        WHEN 'secs' THEN
            SELECT UNIX_TIMESTAMP( NOW() ) AS format_now;
        ELSE
            SELECT 'Ошибка в параметре format';
        END CASE;
END //
DELIMITER ;

/*
CALL shop.format_now('date');
CALL shop.format_now('time');
CALL shop.format_now('secs');
CALL shop.format_now('');
*/


-- ЦИКЛЫ И КУРСОРЫ
-- (WHILE, REPEAT, LOOP)

-- Простая процедура с циклом WHILE (1)
DROP PROCEDURE IF EXISTS NOW3;
DELIMITER //
CREATE PROCEDURE NOW3 ()
BEGIN
    DECLARE i INT DEFAULT 3;
    WHILE i > 0 DO
        SELECT NOW();
        SET i = i - 1;
    END WHILE;
END //
DELIMITER ;

/*
CALL NOW3();
*/


-- Простая процедура с циклом WHILE (2-1)
DROP PROCEDURE IF EXISTS NOWN;
DELIMITER //
CREATE PROCEDURE NOWN (IN num INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    IF (num > 0) THEN
        WHILE i < num DO
            SELECT NOW();
            SET i = i + 1;
        END WHILE;
    ELSE
        SELECT 'Ошибочное значение параметра';
    END IF;
END //
DELIMITER ;

/*
CALL NOWN(5);
*/

-- Простая процедура с циклом WHILE (2-2)
-- * с указанием метки цикла и досрочным прекращением цикла при првевышении внутреннего ограничителя
DROP PROCEDURE IF EXISTS NOWN;
DELIMITER //
CREATE PROCEDURE NOWN (IN num INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    IF (num > 0) THEN
        cycle: WHILE i < num DO
            IF i >= 2 THEN LEAVE cycle;
            END IF;
            SELECT NOW();
            SET i = i + 1;
        END WHILE cycle;
    ELSE
        SELECT 'Ошибочное значение параметра';
    END IF;
END //
DELIMITER ;

/*
CALL NOWN(2);
-- Если используем заведомо большое значение, то выйдем из цикла по внутреннему ограничителю 'IF i >= 2 THEN LEAVE cycle',
-- помимо этого нужно указать метку цикла 'cycle' чтобы выйти из нужного цикла.
CALL NOWN(1000);
*/



-- Простая процедура с циклом WHILE + ITERATE
-- процедура вернёт дубли цифр до 5 (включая 5) и далее цифры без дублей
-- для примера можно использовать значение входного параметра '9'
DROP PROCEDURE IF EXISTS numbers_string;
DELIMITER //
CREATE PROCEDURE numbers_string (IN num INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE bin TINYTEXT DEFAULT '';
    IF (num > 0) THEN
        cycle: WHILE i < num DO
            SET i = i + 1;
            SET bin = CONCAT(bin, i);
            IF i > CEILING(num / 2) THEN ITERATE cycle;
            END IF;
            SET bin = CONCAT(bin, i);
        END WHILE cycle;
        SELECT bin;
    ELSE
        SELECT 'Ошибочное значение параметра';
    END IF;
END //
DELIMITER ;

/*
CALL numbers_string(9);
*/

-- Простая процедура с циклом REPEAT
DROP PROCEDURE IF EXISTS NOW3;
DELIMITER //
CREATE PROCEDURE NOW3()
BEGIN
    DECLARE i INT DEFAULT 3;
    REPEAT
        SELECT NOW();
        SET i = i - 1;
    UNTIL i <= 0
    END REPEAT;
END //
DELIMITER ;

/*
CALL NOW3();
*/

-- Простая процедура с циклом LOOP
DROP PROCEDURE IF EXISTS NOW3;
DELIMITER //
CREATE PROCEDURE NOW3()
BEGIN
    DECLARE i INT DEFAULT 3;
    cycle: LOOP
        SELECT NOW();
        SET i = i - 1;
        IF i <= 0 THEN LEAVE cycle;
        END IF;
    END LOOP cycle;
END //
DELIMITER ;

/*
CALL NOW3();
*/

-- Ошибки и обработка ошибок по кодам
SELECT * FROM shop.catalogs;
INSERT INTO shop.catalogs VALUES (1, 'Процессоры');
-- в случае налиция записи с ID = 1 получим ошибку
-- [23000][1062] Duplicate entry '1' for key 'catalogs.PRIMARY'

-- Создадим процедуру с обработкой ошибки
DROP PROCEDURE IF EXISTS insert_to_catalogs;
DELIMITER //
CREATE PROCEDURE insert_to_catalogs(IN id INT, IN name VARCHAR(255))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
    INSERT INTO shop.catalogs VALUES (id, name);
    IF @error IS NOT NULL THEN
        SELECT @error;
    END IF;
END //
DELIMITER ;

/*
CALL insert_to_catalogs(4, 'Оперативная память');
CALL insert_to_catalogs(1, 'Процессоры');
*/

-- Получаем количество записей таблицы catalogs
-- * если от процедуры требуется вернуть более одного значения, то в этом случае нужно использовать курсоры (CURSOR)
-- * эта процедура будет возвращать ошибку [42000][1172] Result consisted of more than one row
DROP PROCEDURE IF EXISTS catalog_id;
DELIMITER //
CREATE PROCEDURE catalog_id (OUT total INT)
BEGIN
    SELECT id INTO total FROM catalogs;
END //
DELIMITER ;

/*
CALL catalog_id(@s);
SELECT @s;
*/

-- КУРСОРЫ
-- DECLARE CURSOR -> OPEN -> FETCH -> CLOSE
/*
DECLARE curcat CURSOR FOR SELECT * FROM catalogs;
OPEN curcat;
FETCH curcat INTO id, name;
CLOSE curcat;
*/

-- Создадим диблирующую таблицу catalogs (upcase_catalogs)
DROP TABLE IF EXISTS upcase_catalogs;
CREATE TABLE upcase_catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Раздели интернет-магазина';

-- Создадим процедуру для копирования записей из таблицы catalogs в таблицу upcase_catalogs
DROP PROCEDURE IF EXISTS copy_catalogs;
DELIMITER //
CREATE PROCEDURE copy_catalogs ()
BEGIN
    DECLARE id INT;
    DECLARE is_end INT DEFAULT 0;
    DECLARE name TINYTEXT;

    DECLARE curcat CURSOR FOR SELECT * FROM catalogs;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_end = 1;

    OPEN curcat;

    cycle : LOOP
        FETCH curcat INTO id, name;
        IF is_end THEN LEAVE cycle;
        END IF;
        INSERT INTO upcase_catalogs VALUES(id, UPPER(name));
    END LOOP cycle;

    CLOSE curcat;

END //
DELIMITER ;

/*
CALL copy_catalogs();
SELECT * FROM shop.upcase_catalogs;
*/

-- ТРИГГЕРЫ

DELIMITER //
DROP TRIGGER IF EXISTS catalogs_count;
CREATE TRIGGER catalogs_count AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    SELECT COUNT(*) INTO @total FROM catalogs;
END //
DELIMITER ;

/*
INSERT INTO catalogs VALUES (NULL, 'Мониторы');
SELECT @total;
*/

-- Получить список триггеров
/*
SHOW TRIGGERS;
SHOW TRIGGERS\G;
*/
