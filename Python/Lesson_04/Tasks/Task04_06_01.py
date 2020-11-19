# Задание 6
# а) итератор, генерирующий целые числа, начиная с указанного

from itertools import count

fst_count = input("Укажите начальное число (+10): ")

if not fst_count.isdigit():
    pass

fst_count = int(fst_count) if isinstance(fst_count, int) else float(fst_count)
lst_count = fst_count + 10

for my_value in count(fst_count):
    if my_value == lst_count:
        print(f"> {my_value:>10}")
        break
    print(f"> {my_value:>10}")

