# -----------------------------
# Функция с возвратом значения


def calculate(salary):
    try:
        return salary - (salary * .13)
    except TypeError:
        return  # Если не указан тип возвращаемого значения у return, то по умолчанию возвращается None

def hello(name):
    print(f"Hello, {name}")