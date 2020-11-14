# Задание 1. Реализовать функцию, принимающую два числа (позиционные аргументы) и выполняющую их деление.
# Числа запрашивать у пользователя, предусмотреть обработку ситуации деления на ноль.
def numbers_division(num1, num2):
    try:
        return num1 / num2
    except ZeroDivisionError:
        return "Деление на 0 запрещено"


print(numbers_division(1, 000))
