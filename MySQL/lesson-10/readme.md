## Задание 10

### 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов

#### Выберу уникальные IP клиентов используя redis-cli

~~~

> redis-cli -a "$MY_PASS" client list | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sort | uniq

~~~

|`connection_ip`|
|-|
|127.0.0.1|
|192.168.123.1|
|192.168.123.5|
|192.168.123.8|
|192.168.123.15|

#### Вручную сформирую коллекцию из записей IP (Redis)

HINCRBY используется для добавления инкрементного значения для определения значения полей в хэш-таблице

~~~
> redis-cli

HINCRBY my_ip '192.168.123.1' 1
HINCRBY my_ip '192.168.123.5' 1
HINCRBY my_ip '192.168.123.8' 1
HINCRBY my_ip '192.168.123.15' 1
HINCRBY my_ip '192.168.123.8' 1
HINCRBY my_ip '192.168.123.15' 1

exit
~~~

#### Посмотрю элементы коллекции и их количество (Redis)

Для просмотра количества записей и  в коллекции воспользуюсь командой HGETALL

~~~
> redis-cli


HGETALL my_ip

1) "192.168.123.1"
2) "1"
3) "192.168.123.5"
4) "1"
5) "192.168.123.8"
6) "2"
7) "192.168.123.15"
8) "2"

exit
~~~

### 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

Выходя за рамки БД при получении тех или иных данных можно использовать JSON формат записи значений в Redis, а поиск нужного значения осуществлять через внешние утилиты, например jq, но т.к. условие задачи ограничено возможностями БД сделаю проще.

#### Вариант 1. Создам зеркальные записи для одного пользователя (username -> email; email -> username)

пользователи john и jessy

~~~
> redis-cli

SET john john@mail.ru
SET john@mail.ru john

SET jessy jessy@yahoo.com
SET jessy@yahoo.com jessy

exit

~~~

#### Вариант 1. Получу электронную почту по имени пользователя и наоборот.

~~~
> redis-cli

GET jessy

> "jessy@yahoo.com"

GET john@mail.ru

> "john"

exit

~~~

#### Вариант 2. Создам 2 хеш-таблицы (username/email, email/username)


~~~
> redis-cli

HSET USERS 'jessy' 'jessy@yahoo.com'
HSET USERS 'john' 'john@mail.ru'
HSET EMAILS 'john@mail.ru' 'john'
HSET EMAILS 'jessy@yahoo.com' 'jessy'

127.0.0.1:6379> HSET USERS 'jessy' 'jessy@yahoo.com'
(integer) 1
127.0.0.1:6379> HSET USERS 'john' 'john@mail.ru'
(integer) 1
127.0.0.1:6379> HSET EMAILS 'john@mail.ru' 'john'
(integer) 1
127.0.0.1:6379> HSET EMAILS 'jessy@yahoo.com' 'jessy'
(integer) 1

exit

~~~

#### Вариант 2. Получу электронную почту по имени пользователя и наоборот.

~~~
> redis-cli

HGET USERS jessy
HGET EMAILS jessy@yahoo.com

127.0.0.1:6379> HGET USERS jessy
"jessy@yahoo.com"
127.0.0.1:6379> HGET EMAILS jessy@yahoo.com
"jessy"
127.0.0.1:6379>

exit

~~~

### 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

#### Создам коллекцию категорий/разделов (catalogs), добавлю в неё записи и посмотрю результат

~~~
> mongosh

use catalogs;

db.catalogs.insertMany([
    {"name": "Процессоры"},
    {"name": "Мат.платы"},
    {"name": "Видеокарты"},
    {"name": "Принтеры"},
    {"name": "Сканеры"},
    {"name": "Гарнитуры"},
    {"name": "Системы охлаждения"}
])

db.catalogs.find();

exit

~~~


|`_id`|`name`|
|-|-|
|61e8ad4babebd8581e3a9244|Процессоры|
|61e8ad4babebd8581e3a9245|Мат.платы|
|61e8ad4babebd8581e3a9246|Видеокарты|
|61e8ad4babebd8581e3a9247|Принтеры|
|61e8ad4babebd8581e3a9248|Сканеры|
|61e8ad4babebd8581e3a9249|Гарнитуры|
|61e8ad4babebd8581e3a924a|Системы охлаждения|


#### Создам коллекцию товарных позиций (products), добавлю в неё записи и посмотрю результат

~~~

> mongosh

use products;

db.products.insertMany([
    {
        "name" : "Canon Pixma G7020",
        "description" : "All-in-one, Color, Ethernet, USB, Wireless, PictBridge, A4",
        "price" : "26024",
        "catalog_id" : "Принтеры",
        "created_at": new Date(),
        "updated_at": new Date()
    },
    {
        "name" : "CanoScan LIDE 400",
        "description" : "A4, 300 pdi, USB Type-C",
        "price" : "8500",
        "catalog_id" : "Сканеры",
        "created_at": new Date(),
        "updated_at": new Date()
    },
    {
        "name" : "Logitech G G332",
        "description" : "20-20000Hz, 39 Ohm, 107 dB, microphone",
        "price" : "4200",
        "catalog_id" : "Принтер",
        "created_at": new Date(),
        "updated_at": new Date()
    },
    {
        "name" : "Кулер для процессора ID-COOLING DK-01S",
        "description" : "LGA 1151-v2, LGA 1156, LGA 1151, AM4",
        "price" : "399",
        "catalog_id" : "Системы охлаждения",
        "created_at": new Date(),
        "updated_at": new Date()
    }
])

db.products.find()

exit

~~~

|`_id`|`catalog_id`|`created_at`|`description`|`name`|`price`|`updated_at`|
|-|-|-|-|-|-|-|
|61e8ad1dabebd8581e3a923e|Принтеры|2022-01-20T00:30:21.418Z|"All-in-one, Color, Ethernet, USB, Wireless, PictBridge, A4"|Canon Pixma G7020|26024|2022-01-20T00:30:21.418Z|
|61e8ad1dabebd8581e3a923f|Сканеры|2022-01-20T00:30:21.418Z|"A4, 300 pdi, USB Type-C"|CanoScan LIDE 400|8500|2022-01-20T00:30:21.418Z|
|61e8ad1dabebd8581e3a9240|Принтер|2022-01-20T00:30:21.418Z|"20-20000Hz, 39 Ohm, 107 dB, microphone"|Logitech G G332|4200|2022-01-20T00:30:21.418Z|
|61e8ad1dabebd8581e3a9241|Системы охлаждения|2022-01-20T00:30:21.418Z|"LGA 1151-v2, LGA 1156, LGA 1151, AM4"|Кулер для процессора ID-COOLING DK-01S|399|2022-01-20T00:30:21.418Z|
