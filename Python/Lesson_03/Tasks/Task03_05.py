# Задание 5.
# Программа запрашивает у пользователя строку чисел, разделенных пробелом.
# При нажатии Enter должна выводиться сумма чисел.
# Пользователь может продолжить ввод чисел, разделенных пробелом и снова нажать Enter.
# Сумма вновь введенных чисел будет добавляться к уже подсчитанной сумме.
# Но если вместо числа вводится специальный символ, выполнение программы завершается.
# Если специальный символ введен после нескольких чисел, то вначале нужно добавить
# сумму этих чисел к полученной ранее сумме и после этого завершить программу.


def get_sum(nums_list):
    isSpecChar = True if 'q' in nums_list else False
    lst_index = nums_list.index('q') if isSpecChar else len(nums_list)
    return sum([int(num) for num in nums_list[:lst_index] if num.isdigit()]), isSpecChar


isChr = False
my_sum = 0
while not isChr:
    result_sum, isChr = get_sum(list(input("Введите числа разделяя их пробелом (для выхода введите 'q'): ").split(' ')))
    my_sum = my_sum + result_sum
    print(f"Сумма всех введенных чисел: {my_sum}")
