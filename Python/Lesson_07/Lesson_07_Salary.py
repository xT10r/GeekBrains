class Salary:
	amount: int
	vat: int
	multiply: int

	def __init__(self, amount: int, vat: int = 0, multiply: int = 1):
		self.amount = amount
		self.vat = vat
		self.multiply = multiply

	# добавляем оператор сравнения "меньше чем"
	# (полиморфизм)
	def __lt__(self, other):
		if isinstance(other, int) or isinstance(other, float):
			return self.amount < other
		else:
			return self.amount < other.amount

	# "больше чем"
	def __gt__(self, other):
		if isinstance(other, int) or isinstance(other, float):
			return self.amount > other
		else:
			return self.amount > other.amount

	def __eq__(self, other: 'Salary'):
		return self.amount == other.amount and self.vat == other.vat and self.multiply == other.multiply


junior = Salary(200)
middle = Salary(500)
senior = Salary(1000)

print(junior < middle)
print(middle > junior)
print(middle < 400)

print(senior == junior)