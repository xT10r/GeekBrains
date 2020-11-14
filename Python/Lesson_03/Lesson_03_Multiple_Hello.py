users = ["John", "Artur", "Kate", "Jane"]


# Всё что будет записано с "*" - позиционные аргументы
# А всё что будет записано с "**" - именнованные аргументы
def say_hello(*users_list, **user_settings):
    for user in users_list:
        print(user)

say_hello(*users, discount=10, user_font=100)

