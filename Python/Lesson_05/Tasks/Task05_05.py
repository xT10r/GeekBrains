# Задание 5.
# Создать (программно) текстовый файл,
# записать в него программно набор чисел,
# разделенных пробелами.
#
# Программа должна подсчитывать
# сумму чисел в файле и выводить ее на экран.

import os
import random
import sys

# Абсолютный путь до каталога скрипта и до файла с текстом
from itertools import count

path_script = f"{os.path.dirname(sys.argv[0])}"
path_inputFile = os.path.join(path_script, 'Task05_05_Nums.txt')
my_list = [str(x) for x in range(random.randint(1, 10), random.randint(20, 50))]
my_result_str = ' '.join(my_list)

# Пишу в файл строку из чисел(строк)
with open(path_inputFile, 'w') as file_nums:
    print(f'{my_result_str}', file=file_nums)

# Считаю сумму из файла
with open(path_inputFile, 'r') as file_nums:
    my_sum = sum([int(x) for x in file_nums.readline().split()])
    print(f'Сумма всех чисел составила: {my_sum}')