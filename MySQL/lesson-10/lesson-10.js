// ЗАДАНИЕ 1 (Redis)
// В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

// Выберу среди всех IP уникальные, по ним уже выберу отдельные IP
redis-cli -a "$MY_PASS" client list | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sort | uniq

// (далее, но уже вручную сформирую коллекцию из записей IP в redis)
HINCRBY my_ip '192.168.123.1' 1
HINCRBY my_ip '192.168.123.5' 1
HINCRBY my_ip '192.168.123.8' 1
HINCRBY my_ip '192.168.123.15' 1

// Чтобы получить количество записей в коллекции воспользуюсь командой:
HGETALL my_ip



// ЗАДАНИЕ 2 (Redis)
// При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

// Вариант 1 (простые записи). Создам зеркальные записи для одного пользователя (username -> email; email -> username):

// пользователь john
SET john john@mail.ru
SET john@mail.ru john

// пользователь jessy
SET jessy jessy@yahoo.com
SET jessy@yahoo.com jessy

// Чтобы теперь получить электронную почту по имени пользователя и наоборот, выполню команды
GET jessy
GET john@mail.ru

// Вариант 2 (коллекции). Создам зеркальные коллекции содержащие пару (ключ/значение): "Имя/Email", "Email/Имя"

HSET USERS 'jessy' 'jessy@yahoo.com'
HSET USERS 'john' 'john@mail.ru'

HSET EMAILS 'john@mail.ru' 'john'
HSET EMAILS 'jessy@yahoo.com' 'jessy'

// Чтобы теперь получить электронную почту по имени пользователя и наоборот, выполню команды

HGET USERS jessy
HGET EMAILS jessy@yahoo.com


// ЗАДАНИЕ 3 (MongoDB)
// Создам коллекцию категорий/разделов (catalogs)
use catalogs;

// Добавлю записи
db.catalogs.insertMany([
    {"name": "Процессоры"},
    {"name": "Мат.платы"},
    {"name": "Видеокарты"},
    {"name": "Принтеры"},
    {"name": "Сканеры"},
    {"name": "Гарнитуры"},
    {"name": "Системы охлаждения"}
])

// Посмотрю результат
db.catalogs.find();

// Создам коллекцию товарных позиций (products)
use products;

// Добавлю записи
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

// Посмотрю результат
db.products.find()



