# Полиморфизм. Перегрузка
# Пример:


class Person:
	_first_name: str
	_last_name: str

	def __init__(self, first_name: str, last_name: str):
		self._first_name = first_name
		self._last_name = last_name

	def fullname(self):
		return f"{self._first_name} {self._last_name}"


class User(Person):
	login: str
	password: str

	def __init__(self, first_name: str, last_name: str, login: str):  # перегрузка: добавляем login
		# перегрузка: добавляем функцию супер и передаем туда first и last name
		super(User, self).__init__(first_name, last_name)
		self.login = login

	def lo_gin(self):
		print(f"Welcome, {self.fullname()}!")


class InfoPrinter:
	def info(self, class_object):
		# нужно в первых условиях указать самые нижние классы, а потом уже родительские
		if isinstance(class_object, User):
			print("It's a User")
		elif isinstance(class_object, Person):
			print("It's a Person")
		else:
			print("Unknown class/type")


artur = Person("Artur", "Doe")

john = User("John", "Doe", "john_doe")
john.lo_gin()

printer = InfoPrinter()
printer.info(artur)
printer.info(john)
printer.info([])
