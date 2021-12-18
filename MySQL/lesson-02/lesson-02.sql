USE shop;

-- Удалю/создам таблицу заново
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Раздели интернет-магазина';

INSERT IGNORE INTO catalogs VALUES -- вставка только уникальных, ошибки дублей игнорируются
    (DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Мат. платы'),
    (DEFAULT, 'Видеокарты');

-- Добавлю неопределенные записи в таблицу catalogs
INSERT IGNORE INTO shop.catalogs (id, name) VALUES
    (default, null),
    (default, null),
    (default, null),
    (default, null),
    (default, null);
SELECT * FROM shop.catalogs;

-- Обновлю записи таблицы игнорируя ошибки уникальности (в итоге будет обновлена только одна запись)
-- Eсли игнорирования не будет, то появится ошибка о дублирующих записях и невозможности обновления
-- [23000][1062] Duplicate entry 'empty' for key 'catalogs.unique_name'
UPDATE IGNORE shop.catalogs
SET name = 'empty'
WHERE name IS NULL;
SELECT * FROM shop.catalogs;



--
ALTER TABLE shop.catalogs drop index unique_name;
UPDATE shop.catalogs
SET name = 'empty'
WHERE name IS NULL;
SELECT * FROM shop.catalogs;

SELECT * FROM catalogs;


CREATE UNIQUE INDEX unique_name ON shop.catalogs(name);









ANALYZE TABLE shop.catalogs;
