from typing import List, Tuple


def ex1():
    # Задание 1. Проверка типа данных каждого элемента списка
    # * Формат вывода не указан. Поэтому выводить буду Item и Type
    input(">> Задание 1. Вывод типов значений из списка.\nНажмите <ENTER> для продолженния...")
    list_types = [
        int(10),
        float(10.55),
        complex(-10.5 + 3j),
        bin(10),
        "Apple",
        bytes(0x5),
        False,
        None,
        (),
        {},
        [],
    ]

    for list_item in list_types:
        print("Значение: {0: <25} \t Тип: {1: <15}".format(str(list_item), str(type(list_item))))
    print("\n")


def ex2():
    # Задание 2. Заполнеие списка элементами и последовательная попарная перестановка элементов местами
    import re  # использую регулярку для изощренного ввода значений и последующего формирования списка
    input(
        ">> Задание 2. Реверс значений списка попарно-последовательно, \nисключая при нечетном количестве значений "
        "последний элемент. \nНажмите <ENTER> для продолженния...")
    pre_values = \
        input('\033[31mЗаполните список значениями '
              '\033[33m(для разделения значений используйте разделители (\',\', \' \', \'.\', \';\', \'|\'), '
              'иначе список будет сформирован посимвольно)\n'
              '\033[0mВвод значений: ')

    delimeter = "[,|.;\W]+"
    isRegexFind = bool(re.findall(delimeter, pre_values))
    cur_list = re.split(delimeter, pre_values) if isRegexFind else list(str(pre_values))
    rev_list = []
    index = 0
    for i in range(0, len(cur_list), 2):
        rev_list.append(cur_list[i + 1]) if (i + 1) < len(cur_list) else None
        rev_list.append(cur_list[i])

    print(f"Исх. список: {cur_list}")
    print(f"Рев. список: {rev_list}")
    print("\n")


def ex3():
    # Задание 3. Вводим месяц цифрой, получаем в ответ сезон года
    input(">> Задание 3. Определение сезона года по номеру месяца\nНажмите <ENTER> для продолженния...")

    while True:
        cur_month = int(input('\033[0mВведите номер месяца: '))
        if 12 >= cur_month > 0:
            break
        else:
            print("\033[33mНомер месяца указан неверно. Выберите значение от 1 до 12")

    dict_seasons = {
        1: "Зима",
        2: "Весна",
        3: "Лето",
        4: "Осень"
    }

    list_months = [
        dict_seasons.get(1),
        dict_seasons.get(1),
        dict_seasons.get(2),
        dict_seasons.get(2),
        dict_seasons.get(2),
        dict_seasons.get(3),
        dict_seasons.get(3),
        dict_seasons.get(3),
        dict_seasons.get(4),
        dict_seasons.get(4),
        dict_seasons.get(4),
        dict_seasons.get(1)
    ]

    print(list_months[cur_month - 1])
    print("\n")


def ex4():
    # Задани 4. Пользователь вводит слова с разделителем "пробел". Вывести каждое слово отдельной строкой.
    # Сократить длину строки до 10 символов при выводе
    list_strings = filter(None, input(
        ">> Задание 4. Введите несколько слов, разделяя их пробелами\nВвод слов: ").split(' '))
    for (index, value_str) in enumerate(list_strings, start=1):
        print(f"{index:<5} {value_str}")
    print("\n")


def ex5():
    # Задание 5. Структура "Рейтинг". Одинаковые значения должны быть расположены рядом
    source_struct = [10, 9, 8, 7, 3, 1]
    input(">> Задание 5. Структура \"Рейтинг\".\nПользователю нужно вводить целые числа, которые буду размещены по "
          "убыванию в списке\nНажмите <ENTER> для продолженния...")

    while True:

        try:
            cur_item = int(input("Введите число: "))
        except ValueError:
            print("Ввод завершен")
            break

        if cur_item in source_struct:
            first_item_index = source_struct.index(cur_item)
            source_struct.insert(first_item_index + 1, cur_item)

        else:

            if cur_item > max(source_struct):
                source_struct.insert(0, cur_item)

            else:

                cur_index = len(source_struct)

                for (i, value) in enumerate(source_struct, start=0):
                    if value < cur_item:
                        cur_index = i
                        break

                source_struct.insert(cur_index, cur_item)

        print(source_struct)

    print("\n")


def ex6():
    # Задание 6 (hardmode). Структура "Товары". Передача кортежей

    goods_list = []

    # // Отладочный код с подготовленным списком, чтобы не вводить товары лапками
    # goods_list = [
    #     (1, {"название": "дерево", "цена": 246, "количество": 1000, "ед": "м3"}),
    #     (2, {"название": "яблоки", "цена": 120, "количество": 2500, "ед": "кг"}),
    #     (3, {"название": "груши", "цена": 210, "количество": 2000, "ед": "кг"}),
    #     (4, {"название": "гвозди", "цена": 45, "количество": 3500, "ед": "кг"}),
    #     (5, {"название": "ткань", "цена": 510, "количество": 1000, "ед": "м2"})
    # ]
    # // ----

    index = 1
    input_goods = True
    print(">> Задание 6. Структура \"Товары\"\n>>> Ввод товаров. Для завершения ввода, оставьте одно или все поля "
          "пыстыми, нажав <Enter>")
    while input_goods:

        goods = input(f"[{index}] Название товара: ")
        price = input(f"[{index}] Цена: ")
        count = input(f"[{index}] Количество: ")
        okei = input(f"[{index}] Ед.изм.: ")

        goods_set = {
            "название": goods,
            "цена": price,
            "количество": count,
            "ед": okei
        }

        # для завершения цикла выполняю проверку на пустые значения
        if len(goods) == 0 or len(price) == 0 or len(okei) == 0:
            print("Ввод товаров завершен\n")
            input_goods = False
        else:
            goods_tuple = (index, goods_set)
            goods_list.append(goods_tuple)

        index += 1

    print(f"Товары: {goods_list}\n")

    # Аналитика. Исходные данные
    goods_analysis = []
    price_analysis = []
    count_analysis = []
    okei_analysis = []

    for i, value in goods_list:
        goods_analysis.append(value.get("название"))
        price_analysis.append(value.get("цена"))
        count_analysis.append(value.get("количество"))
        okei_analysis.append(value.get("ед"))

    total_analysis = {
        "название": goods_analysis,
        "цена": price_analysis,
        "количество": count_analysis,
        "ед": okei_analysis
    }

    print(">>> Аналитика")
    for tuple_item in total_analysis:
        print(f"{tuple_item:<15}: {total_analysis.get(tuple_item)}")


# Последовательный запуск всех заданий
#ex1()
#ex2()
#ex3()
#ex4()
#ex5()
ex6()
