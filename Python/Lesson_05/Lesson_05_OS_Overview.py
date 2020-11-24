import os
import sys

file_path = f"{os.path.dirname(sys.argv[0])}\\Lesson_05_Data.txt"

# if os.path.exists(file_path):
#    os.remove(file_path)

files = os.listdir()

print(files)

for x in files:
    print(os.path.dirname(x))
    print(os.path.dirname(f"./{x}"))

print(os.path.split('C:/Temp'))

print(os.path.join('C:/Temp', 'file1', 'hop/test', '1.txt'))