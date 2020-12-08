# мутабельные типы - изменяющиеся в течении времени
# (И)мутабельные типы - НЕ изменяющиеся в течении времени

name = "john"
print(hash(name))

values = [1, 2, 3]
# print(hash(values))  # TypeError: unhashable type: 'list'

tup = (1, 2, 3)
print(hash(tup))


class TestClass:
	first_name: str
	values: list

	def __init__(self, attr):
		self.first_name = attr
		self.values = []

	def __hash__(self):
		return hash(self.first_name)


a = TestClass("John")
a.first_name = "Invalid"
print(hash(a))
