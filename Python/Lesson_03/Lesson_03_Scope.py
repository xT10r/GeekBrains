# Примеры: области видимости

# number = 1
#
#
# def increment(a):
#     global result
#     result = a + 1
#     print(result)
#
# increment(number)
# print(number)
# print(result)

def top_func():
    start = 0

    def inner_func():
        nonlocal start
        start += 1

    inner_func()
    print(start)


top_func()

""" Комментарий """