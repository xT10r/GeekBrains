class Human:
	age: int
	first_name: str
	last_name: str
	weight: int
	_password: str  # protected
	__bank_account: int  # private

	# Счетчик для определения числа созданных экземпляров класса
	counter: int = 0

	def __init__(self, first_name, last_name, age, weight=0):
		self.first_name = first_name
		self.last_name = last_name
		self.age = age
		self.weight = weight
		self.__bank_account: str = "408020312961" # private

		Human.counter += 1  # Указываем сам класс вместо экземпляра

	def info(self):
		print(f"I'm {self.first_name}, age: {self.age}, weight: {self.weight}")

	def _init_password(self):
		self._password = "0QO_090_111_xQ!"

	def show_bank_account(self):
		print(f"Account {self.__bank_account[:5]}*******")

john = Human("John", "Doe", 40)
artur = Human("Artur", "Doe", 50)

john.info()
artur.info()

# print(john.counter)
# print(artur.counter)
print(Human.counter)

john._init_password()
print(john._password)

print(f"!Лайфхак (get private). Account: {john._Human__bank_account}") # Hack для получения приватной переменной (банковского аккаунта)
john.show_bank_account() # правильный вариант получения (приватной переменной) банковского аккаунта

# print(john, artur)
#
# john.age = 30
# john.first_name = "John"
# john.last_name = "Doe"
#
# artur.age = 40
# artur.first_name = "Artur"
# artur.last_name = "Doe"

# print(john.first_name, john.last_name, john.age, john.weight)
# print(artur.first_name, artur.last_name, artur.age, artur.weight)
