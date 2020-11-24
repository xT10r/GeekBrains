# Задание 6.
# Необходимо создать (не программно) текстовый файл,
# где каждая строка описывает учебный предмет и наличие лекционных,
# практических и лабораторных занятий по этому предмету и их количество.
# Важно, чтобы для каждого предмета не обязательно были все типы занятий.
# Сформировать словарь, содержащий название предмета и общее количество занятий по нему.
# Вывести словарь на экран.
#
# Примеры строк файла: Информатика: 100(л) 50(пр) 20(лаб).
# Физика: 30(л) — 10(лаб)
# Физкультура: — 30(пр) —
# Пример словаря: {“Информатика”: 170, “Физика”: 40, “Физкультура”: 30}

import os
import sys
import re

# Абсолютный путь до каталога скрипта и до файла с текстом
path_script = f"{os.path.dirname(sys.argv[0])}"
path_InfoFile = os.path.join(path_script, 'Task05_06_Data.txt')

regex_bracket = r'\([^)]*\)'
regex_words = r'^[^a-zA-Z]+[^\s\d]'

dict_subjects = {}

with open(path_InfoFile, 'r', encoding='utf-8') as Data_Info:
    file_lines = Data_Info.readlines()
    index = len(file_lines)
    for file_line in file_lines:
        str_clean_bracket = re.sub(regex_bracket, '', file_line)
        str_clean_subject = re.findall(regex_words, str_clean_bracket)[0]
        str_clean_time = sum([int(x) for x in re.sub(regex_words, '', str_clean_bracket).split()])
        dict_subjects[str_clean_subject] = str_clean_time

print(dict_subjects)
