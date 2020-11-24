import os
import sys

path_script = f"{os.path.dirname(sys.argv[0])}\\Lesson_05_Data.txt"
with open(rf'{path_script}', "w") as printable:
    print("Hello, World!", file=printable)

with open(rf'{path_script}', "w") as printable:
    strings = ["John", "Kate"]
    for x in strings:
        print(x, file=printable)
