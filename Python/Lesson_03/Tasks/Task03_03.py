# Задание 3.
# Реализовать функцию my_func(),
# которая принимает три позиционных аргумента,
# и возвращает сумму наибольших двух аргументов.
import random

isManual = False
num1, num2, num3 = 0, 0, 0


def my_func(*nums):
    """
    Принимает позиционные аргументы (числа)\n
    и возвращает сумму 2ух больших из них
    :param nums: числа 1...N (в задаче подразумевается всего 3 числа)
    :return: сумма двух наибольших чисел
    """
    return sum(sorted(list(nums))[1::1])


def print_results(num1_value, num2_value, num3_value):
    """
    Принимает 3 числовых значения \nи возвращет результат в виде строки: \n[num1_value, num2_value, num3_value] | расчет суммы 1 | расчет суммы 2
    :param num1_value: число 1
    :param num2_value: число 2
    :param num3_value: число 3
    """
    print(
        f"[{num1_value}, {num2_value}, {num3_value}] | "
        f"lambda_func: {(lambda *nums: sum(sorted(list(nums))[1::1]))(num1, num2, num3)} | "
        f"my_func: {my_func(num1, num2, num3)}")


def manual_input():
    return int(input("Первое число: ")), int(input("Второе число: ")), int(input("Третее число: ")), True


# ВАЖНО! Если хочется проверить задачу вручную, то раскоментируйте строку ниже
# num1, num2, num3, isManual = manual_input()

# Чтобы вручную не задавать числа, добавил генерацию через random
if isManual:
    print_results(num1, num2, num3)
else:
    for i in range(0, random.randint(1, 20), random.randint(1, 2)):
        num1, num2, num3 = random.randint(0, 18), random.randint(0, 18), random.randint(0, 18)
        print_results(num1, num2, num3)
