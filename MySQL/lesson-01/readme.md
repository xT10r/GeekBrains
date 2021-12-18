## Задание 1
### 1. Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.

#### Установлю MySQL
~~~
sudo apt install mysql-server mysql-client
~~~

#### Проверю версию (что установил по дефолту)
~~~
mysql -V
~~~

> mysql  Ver 8.0.27-0ubuntu0.20.04.1 for Linux on x86_64 ((Ubuntu))

#### Добавлю пользователю в папку home файл ".my.cnf", это желательно сделать чтобы постоянно не писать "креды" подключения к MySQL. Ниже приведено содержимое файла:

~~~
[client]
user=root
password=r00tStr0ngPa$$w0rd
~~~


### 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

#### Создам БД с таблицей users (id, name)

~~~
> mysql

SHOW DATABASES;
CREATE DATABASE example;
SHOW CREATE DATABASE example;
USE example;
SHOW TABLES;
CREATE TABLE IF NOT EXISTS users (id INT NOT NULL, name VARCHAR(1024) NOT NULL);
DESCRIBE example.users;
EXIT;
~~~

#### Создам дамп БД 'example' и разверну его в БД 'sample'

~~~
mysqldump -v -uroot example > ~/dump_example.sql
mysql -uroot -hlocalhost -e "CREATE DATABASE IF NOT EXISTS sample; SHOW DATABASES;"
mysql -uroot -hlocalhost sample < ~/dump_example.sql
mysql -uroot -hlocalhost -e "DESCRIBE sample.users;"
~~~

### 3. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

~~~
mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > ~/first_100_rows_help_keyword.sql
~~~

----


### Сделаю бэкап созданных БД (example, sample) из MySQL
~~~
mysqldump -u root -B example sample > ~/lesson01_databases.sql
~~~
