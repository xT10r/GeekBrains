# password = input("Введите пароль >>> ")
#
# original_password = "correct"
#
# if original_password == password:
#     print("Верно")
# else:
#     print("Не верно")

# Ветвления (условия)
age = int(input("Введите ваш возраст >>>"))

if age >= 14:
    print("паспорт можно получить")

    if 20 <= age < 45:
        print("паспорт можно поменять")

elif age < 1:
    print("Custom")

else:
    print("паспорт нельзя получить")
