# Задание 3.
# Создать текстовый файл (не программно),
# построчно записать фамилии сотрудников
# и величину их окладов (не менее 10 строк).
# Определить, кто из сотрудников имеет оклад менее 20 тыс.,
# вывести фамилии этих сотрудников.
# Выполнить подсчет средней величины дохода сотрудников.
#
# Пример файла:
# Иванов 23543.12
# Петров 13749.32

import os
import sys

# Абсолютный путь до каталога скрипта и до файла с текстом
path_script = f"{os.path.dirname(sys.argv[0])}"
path_text_file = os.path.join(path_script, 'Task05_03_data.txt')


def str_to_digit(value):
    return int(value) if str(value).isdigit() else float(value)


with open(path_text_file, 'r', encoding='utf-8') as in_stream:
    pre_list = [seg.split() for seg in in_stream.readlines() if str_to_digit(seg.split()[1]) < 20000]
    my_sum = sum([str_to_digit(salary[1]) for salary in pre_list])
    print(f"Фамилии сотрудников (оклад < 20к):\n{', '.join([last_name[0] for last_name in pre_list])}\n")
    # print(f"Оклады сотрудников:\n{', '.join([salary[1] for salary in pre_list])}")
    print(f"Общ.сумма: {my_sum}")
    print(f"Средняя ЗП: {(my_sum / len(pre_list))}")
