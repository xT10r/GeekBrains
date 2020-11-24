# Задание 1.
# Создать программно файл в текстовом формате,
# записать в него построчно данные, вводимые пользователем.
# Об окончании ввода данных свидетельствует пустая строка.
import os
import sys

# Абсолютный путь до каталога скрипта и до файла с текстом
path_script = f"{os.path.dirname(sys.argv[0])}"
path_text_file = os.path.join(path_script, 'Task05_01_data.txt')
os.remove(path_text_file) if os.path.exists(path_text_file) else None


def write_to_file(inData: str):
    with open(path_text_file, 'a+') as input_stream:
        print(inData, file=input_stream)


print('Введите текст (для выхода нажмите <Enter>):')
while True:
    result = input('> ')
    if not result:
        break
    write_to_file(result)

print(f"Содержимое файла {path_text_file}:")
with open(path_text_file, 'r') as output_stream:
    print(output_stream.read())

