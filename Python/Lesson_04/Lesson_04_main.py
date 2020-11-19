import sys
from Lesson_04 import Lesson_04_My_Mod as my_mod

try:
    file, user, salary = sys.argv
except ValueError:
    print("Invalid args")
    exit()

# print(sys.argv)

my_mod.hello(user)
print(my_mod.calculate(int(salary)))
