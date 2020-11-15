# Задание 1. Реализовать функцию, принимающую два числа (позиционные аргументы) и выполняющую их деление.
# Числа запрашивать у пользователя, предусмотреть обработку ситуации деления на ноль.
import random


def numbers_division(number_a, number_b):
    """
    Выполняет деление числа А на число Б\n
    Возвращает результат из двух значений: (result, error)\n
    где:\n
    > result - результат деления,\n
    > error - текст ошибки

    :param number_a: ЧислоА
    :param number_b: ЧислоБ
    :return: (result, error)
    """
    try:
        return number_a / number_b, ""
    except ZeroDivisionError:
        return None, "(деление на 0 запрещено)"
    except TypeError:
        return None, "(функция работает только с числовыми значениями)"


# Автоматизирован вывод результатов выполнения функции деления
for i in range(0, random.randint(1, 20), random.randint(1, 2)):
    num1, num2 = random.randint(0, 18), random.randint(0, 15)
    result, error = numbers_division(num1, num2)
    print(f"{num1} / {num2} = {result} {error}")
