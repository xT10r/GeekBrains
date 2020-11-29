# Инкапсуляция
# Пример:


class Person:
	_first_name: str
	_last_name: str

	def __init__(self, first_name: str, last_name: str):
		self._first_name = first_name
		self._last_name = last_name

	def fullname(self):
		return f"{self._first_name} {self._last_name}"


john = Person("John", "Doe")
# print(john._first_name)
print(john.fullname())
