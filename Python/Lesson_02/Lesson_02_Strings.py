first_name = "John"
last_name = "Doe"

# Конкатенация используется, когда неизвестно количество выводимых данных
full_name = first_name + " " + last_name

# Индексное обращение к строке
full_name_format = f"{first_name} {last_name}"
print(full_name)

# индексация строки идет от нуля
template = "1234c5678"
country_code = template[4]
print(country_code)

passport = "1234567891"
passport_serial = passport[0:4]
passport_number = passport[4:]

print(passport_serial, passport_number)

reverse_string = "123"
print(reverse_string[::-1])  # [первый символ:последний символ:шаг]
