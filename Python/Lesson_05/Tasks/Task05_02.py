# Задание 2.
# Создать текстовый файл (не программно),
# сохранить в нем несколько строк,
# выполнить подсчет количества строк,
# количества слов в каждой строке.

import os
import sys

# Абсолютный путь до каталога скрипта и до файла с текстом
path_script = f"{os.path.dirname(sys.argv[0])}"
path_text_file = os.path.join(path_script, 'Task05_02_data.txt')

with open(path_text_file, 'r') as my_data:
    my_data_lines = my_data.readlines()
    lines = len(my_data_lines)
    words = len([words for segments in my_data_lines for words in segments.split()])

    print(f"Всего строк: {lines}")
    print(f"Всего слов: {words}")
