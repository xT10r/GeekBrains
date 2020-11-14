# Задание 1. Переменные
def ex1():
    input("Задание 1. Нажмите <ENTER> для продолженния...")
    num01 = 10
    num02 = 30
    num03 = num01 + num02
    print(f"{num01}+{num02}={num03}")

    user_num01 = int(input("Введите число: "))
    user_num02 = int(input("Введите ещё одно число:"))
    user_str01 = input("Введите любой текст:")
    print(f"Вы ввели текст '{user_str01}' и, возможно, цифры '{user_num01}', '{user_num02}")


# Задание 2. Перевод секунд
def ex2():
    input("Задание 2. Нажмите <ENTER> для продолженния...")
    user_seconds = int(input("Укажите время в секундах: "))

    _hours = user_seconds // 3600  # часы
    _minutes = (user_seconds // 60) - (_hours * 60)  # минуты
    _seconds = user_seconds - (_hours * 3600) - (_minutes * 60)  # секунды

    print("{}:{}:{}".format(str(_hours).zfill(2), str(_minutes).zfill(2), str(_seconds).zfill(2)))


# Задание 3
def ex3():
    import math
    input("Задание 3. Нажмите <ENTER> для продолженния...")
    sum_value = new_value = _i = 0
    result_str = ""

    user_value = int(input("Введите число: "))
    X = int(math.log10(user_value)) + 1

    while _i < 3:
        factor = int(f'1'.ljust(X + 1, '0'))
        new_value = new_value + user_value
        user_value = user_value * factor
        # print(f"factor: {factor} // new_value: {new_value}")
        sum_value = sum_value + new_value
        if result_str:
            result_str = result_str + " + "
        result_str = result_str + str(new_value)
        _i += 1
    else:
        print(f"{result_str} = {sum_value}")


# Задание 4. Найти наибольшее число
def ex4():
    input("Задание 4. Нажмите <ENTER> для продолженния...")
    some_value = int(input("Введите какое-нибудь число: "))
    result = 0
    index = 0
    list_values = list(str(some_value))

    while index < len(list_values):

        cur_value = int(list_values[index])

        if index == 0:
            result = cur_value
            index += 1
            continue

        if cur_value > result:
            # print(f">>> index: {index}, cur:{cur_value}")
            result = cur_value

        index += 1
    print(f"Самое большая цифра в числе: {result}")


# Задание 5. Выручка и издержки
def ex5():
    input("Задание 5. Нажмите <ENTER> для продолженния...")
    proceeds = int(input("Размер выручки составил: "))
    costs = int(input("Размер издержек составил: "))

    profit = proceeds - costs  # состояние прибыли
    if profit > 0:
        print(f"Прибыль составила: {profit} у.е.")
        profitability = round(((profit / proceeds) * 100), 2)
        print(f"рентабельность выручки составила: {profitability}")
        employees = int(input("Укажите численность сотрудников в фирме, чел: "))
        profit_per_employee = round((profit / employees), 2)
        print(f"прибыль фирмы в расчете на одного сотрудника составила: {profit_per_employee} у.е.")
    elif profit < 0:
        print(f"Убыток составил: {(-1) * profit} у.е.")


# Задание 6. Спортсмен
def ex6():
    input("Задание 6. Нажмите <ENTER> для продолженния...")
    fist_jogging = int(input("Укажите, сколько КМ спортсмен пробежит в первый день: "))
    last_jogging = int(input("Укажите, сколько КМ спортсмен пробежит в день-X: "))
    coefficient = 0.1
    days = 1

    while fist_jogging <= last_jogging:
        print(f"{days}-й день: {round(fist_jogging, 2)}")
        percent_jogging = round(fist_jogging * coefficient, 2);
        fist_jogging = fist_jogging + percent_jogging;
        days += 1
    else:
        print(f"На {days}-й день спортсмен достиг результата - не менее {last_jogging} км.")


# запускам все 6 заданий поочереди
ex1()
ex2()
ex3()
ex4()
ex5()
ex6()
