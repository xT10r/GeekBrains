# возврат из функции множественных результатов


def multiplies(a, b):
    return a * b, b * a  # результатом такого возврата будет тип данных "Кортеж"


result1, result2 = multiplies(4, 2)
print(result1, result2)

# можно именовать передаваемые в функцию значения
result1, result2 = multiplies(b=4, a=2)
print(result1, result2)

