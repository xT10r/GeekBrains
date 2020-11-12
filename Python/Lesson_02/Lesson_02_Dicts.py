old_dict = dict(name="John", age=10)

new_dict = {"name": "John", "age": 10}

print(old_dict.keys())
print(new_dict.values())

print(new_dict["age"])
print(new_dict.get("age"))

# если запросим поле, которого изначально нет, через квадратные скобки - получим ошибку
# print(new_dict["age1"])
# но если сделаем то же самое через функцию .get(), то вернутся None
print(new_dict.get("age1"))

if new_dict.get("surname") == None:
    print("No surname")
