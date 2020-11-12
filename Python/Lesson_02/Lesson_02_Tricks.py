# Трюки

# 1
nums = [
    [1, 2, 3],
    [4, 5, 6]
]

joined = sum(nums, [])
print(joined)

# 2. Удаление дубликатов в списке (не для больших объектов)
unique = [1, 2, 3, 3, 4, 4, 4]
unique = list(set(unique))
print(unique)

# 3.
# a = 10
# b = 20
a, b = 10, 20
a, b = b, a

# 4. ~анализ данных
total = [1, 2, 3, 3]
print(
    max(
        set(total),
        key=total.count
    )
)

# 5. Распаковка значений из списков "*"
print(*total)
print(*total, end ='', sep='--')