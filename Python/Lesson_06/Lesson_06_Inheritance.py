# Наследование
# Пример:


class Person:
	_first_name: str
	_last_name: str

	def __init__(self, first_name: str, last_name: str):
		self._first_name = first_name
		self._last_name = last_name

	def fullname(self):
		return f"{self._first_name} {self._last_name}"


# В скобках можно указать класс который хотим унаследовать
# Можно указать имя класса в ковычках, чтобы независимо от местоположения текущего класса был определен родительский,
# но так лучше не делать, т.к. не все интерпретаторы это понимают. Пример: class User('Person')
# ! Помимо этого в Python поддерживается множественное наследование. Пример: class User(Person, Human, Role)
class User(Person):
	login: str
	password: str

	def login(self):
		print(f"Welcome, {self.fullname()}!")


john = User("John", "Doe")
john.login()
