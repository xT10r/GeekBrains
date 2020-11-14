# Задаем дефолтное значение имени пользователя для функции
def user_hello(user_name="Guest"):
    print(f"Hello, {user_name}")


user_hello()
user_hello("Artur")
user_hello(user_name="John")
