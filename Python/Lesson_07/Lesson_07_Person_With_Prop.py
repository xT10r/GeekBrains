# Пример специального (стандартного) декоратора @Property
class Person:
	_name: str
	_last_name: str

	def __init__(self, first_name, last_name):
		self._name = first_name
		self._last_name = last_name

	@property  # вот и стандартная декоракция, позволяет обращаться к функции как к переменной
	def full_name(self):
		return f"{self._name} {self._last_name}"


john = Person("John", "Duo")

print(john.full_name)
