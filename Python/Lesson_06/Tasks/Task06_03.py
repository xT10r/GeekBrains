# Задание 3.
# Реализовать базовый класс Worker (работник), в котором определить атрибуты:
# - name,
# - surname,
# - position (должность),
# - income (доход).
#
# Последний атрибут должен быть защищенным и ссылаться на словарь, содержащий элементы: оклад и премия,
# например, {"wage": wage, "bonus": bonus}.
#
# Создать класс Position (должность) на базе класса Worker.
#
# В классе Position реализовать методы получения полного имени сотрудника (get_full_name)
# и дохода с учетом премии (get_total_income).
#
# Проверить работу примера на реальных данных
# (создать экземпляры класса Position, передать данные, проверить значения атрибутов, вызвать методы экземпляров).

class Worker:
	name: str
	surname: str
	position: None
	_income: dict = {"wage": 0, "bonus": 0}

	def __init__(self, name: str, surname: str, position: str, wage: int = 0, bonus: int = 0):
		self.name = name
		self.surname = surname
		self.position = position
		self._income["wage"] = wage
		self._income["bonus"] = bonus


class Position(Worker):

	def __init__(self, name: str, surname: str, position: str, wage: int = 0, bonus: int = 0):
		super().__init__(name, surname, position, wage, bonus)

	def get_full_name(self):
		return f"{self.name} {self.surname}"

	def get_total_income(self):
		values = [x for x in self._income.values()]
		return f"{values[0]} {values[1]}"


engineer = Position('Петр', 'Петров', 'Бухгалтер', 25000, 5000)
print(f"{engineer.get_full_name()} {engineer.get_total_income()}")
