# Данный файл является дополнением к заданию 1
# Содержит в себе функцию расчета ЗП
# ... и небольшого обработчика для запуска этого скрипта из вне

import sys


def get_salary(hours, hourly_rate, prize):
    """
    Функция возвращает значение заработной платы
    :param hours: выработка в часах
    :param hourly_rate: ставка в час
    :param prize: премия
    :return: int
    """
    return (hours * hourly_rate) + prize


if len(sys.argv) > 3:
    argv_list = [int(x) for x in sys.argv[1:] if x.isdigit()]
    if len(argv_list) == 3:
        print(f"Вызов из другого скрипта -> ЗП: {get_salary(argv_list[0], argv_list[1], argv_list[2])}")
    else:
        print(f"Вы указали неверное количество параметров\nДля расчета зарплаты нужно указать 3 параметра")
        pass
