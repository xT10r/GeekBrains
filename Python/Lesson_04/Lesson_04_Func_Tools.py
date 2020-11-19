from functools import reduce

user_balance = {"john": 100, "kate": 70, "artur": 50}


def my_balance_func(total, amount):
    return total + amount

users_total = reduce(my_balance_func, user_balance.values())

print(users_total)

users_total1 = reduce(lambda total, amount: total + amount,
                     user_balance.values())

print(users_total1)

