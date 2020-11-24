import os
import sys

# Запись

path_script = f"{os.path.dirname(sys.argv[0])}\\Lesson_05_Data.txt"
my_file = open(rf'{path_script}', "w")  # r - raw

if my_file.writable():
    my_file.write("Update\n")

    strings = ["Artur\n", 'Kate\n', "John\n"]
    my_file.writelines(strings)

else:
    print("Can not write")

my_file.close()