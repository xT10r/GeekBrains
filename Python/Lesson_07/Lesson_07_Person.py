class Person:

	def __init__(self, attrs: dict):
		self._attributes = attrs  # чтобы полностью соответствовать правилам инкапсуляции добавим "_" в начале

	def __del__(self):
		print("Person removed")

	def __str__(self):
		return f"Person: {self._attributes['first_name']} {self._attributes['last_name']}"

	def __repr__(self):
		return self.__str__()

	# инкапслуяция (чтобы извне при обращении к конкретному экземпляру возвращать запрашиваемое значение
	def __getitem__(self, item):
		if item != 'age':
			return self._attributes[item]
		else:
			return None

	# нужна проверка на (уже) наличие атрибутов класса
	def __setattr__(self, key, value):
		if '_attributes' in self.__dict__:
			self._attributes[key] = value
		else:
			super().__setattr__(key,value)


john = Person({"first_name": "John", "last_name": "Doe", "age": 30})
artur = Person({"first_name": "Artur", "last_name": "Doe", "age": 40})

# del john

# print(john.attributes['first_name'])

users = [john, artur]

print(users)

print(john['first_name'])
print(john['age'])

john.job = "Developer"  # чтобы так добавить новый атрибут в класс, нужно описать оператор __setattr__ в классе john
# print(john.job) # такой формат вызова работать не будет, нужно обратиться к атрибуту job через class.['job']
print(john['job'])
