# Задание 6
# б) итератор, повторяющий элементы некоторого списка, определенного заранее

from itertools import cycle

my_list = "* И и и г о р ь ! * ".split(' ')
my_cycle = cycle(my_list)

lst_count = input("Сколько раз повторить вывод элементов списка?: ")

if not lst_count.isdigit():
    pass

lst_count = int(lst_count) if isinstance(lst_count, int) else float(lst_count)
lst_count_max = lst_count * len(my_list)

for my_value in my_cycle:
    if lst_count_max < lst_count:
        print(f"{my_value:>2}")
        break
    print(f"{my_value:>2}")
    lst_count += 1
