## Задание 7

### 1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

#### Создам пользователей MySQL
~~~
> mysql

DROP USER IF EXISTS shop_read, shop_admin;
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'pa$$w0rd';
CREATE USER shop_admin IDENTIFIED WITH sha256_password BY 'pa$$w0rd';

EXIT;
~~~

#### Предоставлю пользователю `shop_read` права на чтение данных БД shop

~~~
> mysql

GRANT SELECT ON shop.* TO shop_read;

EXIT;
~~~

#### Предоставлю пользователю `shop_admin` права на чтение данных БД shop

~~~
> mysql

GRANT ALL ON shop.* TO shop_admin;

EXIT;
~~~

#### Обновлю права пользователей

~~~
> mysql

FLUSH PRIVILEGES;

EXIT;
~~~

#### Результат задания 1 (выданные права пользователям)

~~~
> mysql

SELECT Host, Db, User, Select_priv, Create_priv, Insert_priv, Update_priv, Delete_priv, Alter_priv
FROM mysql.db
WHERE
    USER = 'shop_read'
    OR USER = 'shop_admin';
	
EXIT;
~~~

|`Host`|`Db`|`User`|`Select_priv`|`Create_priv`|`Insert_priv`|`Update_priv`|`Delete_priv`|`Alter_priv`|
|-|-|-|-|-|-|-|-|-|
|%|shop|shop_admin|Y|Y|Y|Y|Y|Y|
|%|shop|shop_read|Y|N|N|N|N|N|


### 2. (по желанию) Есть таблица (accounts), включающая в себя три столбца: id, name, password, которые содержат первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющее доступ к столбцам id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username.

#### Создам таблицу accounts в БД sample

~~~
> mysql

DROP TABLE IF EXISTS sample.accounts;
CREATE TABLE sample.accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    password VARCHAR(1024)
) COMMENT 'Учетные данные пользователей';

EXIT;
~~~

#### Создам процедуру для добавления случайных аккаунтов

~~~
> mysql

DROP PROCEDURE IF EXISTS generate_sample_accounts;
CREATE PROCEDURE generate_sample_accounts()
BEGIN
    DECLARE account_num INT;
    DECLARE u_name, u_password VARCHAR(255);
    SET account_num = 0;
    WHILE account_num < 20 DO
        SET u_name = CONCAT('user-', LEFT(UUID(), 9), FLOOR ( (RAND( ) * 100)));
        SET u_password = SUBSTRING(MD5(RAND()) FROM 1 FOR 10);
        INSERT INTO sample.accounts (id, name, password)
        VALUES (default, u_name, u_password);
        SET account_num = account_num + 1;
    END WHILE;
END;

EXIT;
~~~

#### Добавлю случайные аккаунты (20 штук)

~~~
> mysql

CALL generate_sample_accounts();

EXIT;
~~~

#### Исходная таблица случайных аккаунтов
|`id`|`user`|`password`|
|-|-|-|
|1|user-3a97e8f8-95|50b20c4b75|
|2|user-3a985200-86|7e4f2388d0|
|3|user-3a98a510-96|4ac9e5181c|
|4|user-3a98ca46-54|a263632d3d|
|5|user-3a98f4c2-61|b2b876dd42|
|6|user-3a99327b-76|b3365c069c|
|7|user-3a995c41-4|dedbf5b306|
|8|user-3a998378-91|da95c4a30a|
|9|user-3a99b8bf-97|cea52bcf61|
|10|user-3a99d8cc-29|1d840c9a78|
|11|user-3a99fdb2-80|1bf8f51497|
|12|user-3a9a269c-56|8f63118142|
|13|user-3a9a5e07-48|0516e2695c|
|14|user-3a9a865f-11|56a79ab9de|
|15|user-3a9aabcc-87|3299dfac04|
|16|user-3a9ae928-59|d73ca94dca|
|17|user-3a9b0df9-42|b1c01618c9|
|18|user-3a9b3a64-70|9a11024681|
|19|user-3a9b64da-50|b7aa80f2c2|
|20|user-3a9b9bcc-33|7bd777147d|

#### Создам представление 'username' таблицы sample.accounts со столбцами (id, name)

~~~
> mysql

CREATE OR REPLACE VIEW sample.username(id, user)
    AS SELECT acc.id, acc.name
    FROM sample.accounts as acc;

EXIT;
~~~

#### Представление username

~~~
> mysql

SELECT * FROM sample.username;

EXIT;
~~~

|`id`|`username`|
|-|-||1,user-3a97e8f8-95||2,user-3a985200-86||3,user-3a98a510-96||4,user-3a98ca46-54||5,user-3a98f4c2-61||6,user-3a99327b-76||7,user-3a995c41-4||8,user-3a998378-91||9,user-3a99b8bf-97||10,user-3a99d8cc-29||11,user-3a99fdb2-80||12,user-3a9a269c-56||13,user-3a9a5e07-48||14,user-3a9a865f-11||15,user-3a9aabcc-87||16,user-3a9ae928-59||17,user-3a9b0df9-42||18,user-3a9b3a64-70||19,user-3a9b64da-50||20,user-3a9b9bcc-33|

#### Создам пользователя user_read

~~~
> mysql

DROP USER IF EXISTS user_read;
CREATE USER user_read IDENTIFIED WITH sha256_password BY 'pa$$w0rd';

EXIT;
~~~

#### Предоставлю пользователю user_read право на чтение представления sample.username

~~~
> mysql

GRANT SELECT ON sample.username TO user_read;
FLUSH PRIVILEGES;

EXIT;
~~~

#### Посмотрю список предоставленных прав пользователю user_read

~~~
> mysql

SHOW GRANTS FOR user_read;

EXIT;
~~~

|`Grants for user_read@%`|
|-|
|GRANT USAGE ON *.* TO `user_read`@`%`|

#### Выполню вход от пользователя user_read и посмотрю представление sample.username

~~~
> mysql -u user_read -p'pa$$w0rd'

SELECT * FROM sample.username;

+----+------------------+
| id | user             |
+----+------------------+
|  1 | user-3a97e8f8-95 |
|  2 | user-3a985200-86 |
|  3 | user-3a98a510-96 |
|  4 | user-3a98ca46-54 |
|  5 | user-3a98f4c2-61 |
|  6 | user-3a99327b-76 |
|  7 | user-3a995c41-4  |
|  8 | user-3a998378-91 |
|  9 | user-3a99b8bf-97 |
| 10 | user-3a99d8cc-29 |
| 11 | user-3a99fdb2-80 |
| 12 | user-3a9a269c-56 |
| 13 | user-3a9a5e07-48 |
| 14 | user-3a9a865f-11 |
| 15 | user-3a9aabcc-87 |
| 16 | user-3a9ae928-59 |
| 17 | user-3a9b0df9-42 |
| 18 | user-3a9b3a64-70 |
| 19 | user-3a9b64da-50 |
| 20 | user-3a9b9bcc-33 |
+----+------------------+
20 rows in set (0.00 sec)

EXIT;
~~~


