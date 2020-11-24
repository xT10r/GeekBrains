import os
import sys

# Чтение

path_script = f"{os.path.dirname(sys.argv[0])}\\Lesson_05_Data.txt"
# os.system(f"python {path_script} 10 20 30")

my_file = open(rf'{path_script}', "r")  # r - raw

my_file_lines = my_file.readlines()

# print(my_file.closed)
# print(my_file.mode)
# print(my_file.name)
# print(my_file_lines)

for line in my_file_lines:
    print(line.replace('\n', ''))

# print(my_file.read())  # по факту выводится одна строка, т.к. могут быть проблемы с парсингом

# print(my_file.read(1024))  # получить первые 1024 байта

for data in my_file.read(1024):  # По байтовое считывание
    print(data)

print(my_file.tell())
my_file.seek(0, 0)
print(my_file.tell())
print(my_file.read(27))

# Print - может писать в файл


my_file.close()
