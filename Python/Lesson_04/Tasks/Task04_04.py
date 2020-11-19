# Задание 4.
# Представлен список чисел.
# Определить элементы списка, не имеющие повторений.
# Сформировать итоговый массив чисел, соответствующих требованию.
# Элементы вывести в порядке их следования в исходном списке.
# Для выполнения задания обязательно использовать генератор.
# Пример исходного списка: [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11].
# Результат: [23, 1, 3, 10, 4, 11]
import random

source_list = [random.randint(x, x * 2) for x in range(random.randint(1, 5), random.randint(10, 20))]
random.shuffle(source_list)

for x in source_list[1:len(source_list)//2]:
    random.shuffle(source_list)
    source_list.append(x)

result_list = [x for x in source_list if source_list.count(x) == 1]

print(f"Исходный список: {source_list}")
print(f"Результат: {result_list}")


