# -----------------------------
# Функция с возвратом значения

def calculate(salary):
    try:
        return salary - (salary * .13)
    except TypeError:
        return  # Если не указан тип возвращаемого значения у return, то по умолчанию возвращается None


salary_1 = 100
print(salary_1, calculate(salary_1))

# Формируем ошибку и в функции добавляем try/except
salary_1 = "тест_значения"
print(salary_1, calculate(salary_1))
