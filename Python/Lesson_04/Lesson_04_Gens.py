import random

tel = "8001234567"

# for x in range(1, 99):
#    return x

tel_list = [f"{tel}{x}" for x in range(1, 10) if x != 5]

print(tel_list)

numbers = [10, 20, 30, 40]

result_dict = {key: key * 2 for key in numbers}
print(result_dict)

random_number = random.choice(tel_list)
print(random_number)

random.shuffle(tel_list)
print(tel_list)
