# Задание 4.
# Создать (не программно) текстовый файл со следующим содержимым:
# One — 1
# Two — 2
# Three — 3
# Four — 4
#
# Необходимо написать программу, открывающую файл на чтение и считывающую построчно данные.
# При этом английские числительные должны заменяться на русские.
# Новый блок строк должен записываться в новый текстовый файл.

import os
import sys

dict_nums = {
    1: "Один",
    2: "Два",
    3: "Три",
    4: "Четыре"
}

# Абсолютный путь до каталога скрипта и до файла с текстом
path_script = f"{os.path.dirname(sys.argv[0])}"
path_inputFile = os.path.join(path_script, 'Task05_04_In.txt')


file_list = os.listdir(path_script)
for curFile in file_list:
    curFilePath = os.path.join(path_script, curFile)
    if curFile.find('Task05_04_Out') >= 0:
        os.remove(curFilePath)

with open(path_inputFile, 'r') as in_data:
    my_data_lines = in_data.readlines()
    for x, str_line in enumerate(my_data_lines):
        path_outputFile = os.path.join(path_script, f'Task05_04_Out{x}.txt')
        str_line = str_line.replace(' ', '')
        index = str_line.find('-')
        num_value = int(str_line[index + 1:])
        num_name = dict_nums[num_value]

        with open(path_outputFile, 'a+', encoding='utf-8') as out_data:
            print(f"{num_name} - {num_value}", file=out_data)
