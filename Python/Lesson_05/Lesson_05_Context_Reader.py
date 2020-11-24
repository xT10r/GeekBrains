import os
import sys

# Запись

path_script = f"{os.path.dirname(sys.argv[0])}\\Lesson_05_Data.txt"

with open(rf'{path_script}', "r") as my_file:  # создает контейнер типа Using C#
    print(my_file.read())

print(type(my_file))

# print(my_file.read())

# Exception handler
try:
    with open(rf'{path_script}', "r") as my_file:  # создает контейнер типа Using C#
        print(my_file.read())
except IOError:
    print("Some error")