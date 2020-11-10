numbers = [4, 8, 15, 16, 22, 45, 103]
print(numbers)

numbers.append(215)
print(numbers)

numbers.remove(45)
print(numbers)

numbers.append(15)
print(numbers)

print(numbers.count(15))

new_list = [20, 30, 40]
new_list.extend(numbers)
print(new_list)

new_list.sort()
print(new_list)

new_list.reverse()
print(new_list)
