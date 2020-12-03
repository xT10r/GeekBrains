# Задание 3.
# Реализовать программу работы с органическими клетками, состоящими из ячеек.
# Необходимо создать класс Клетка.
# В его конструкторе инициализировать параметр, соответствующий количеству ячеек клетки (целое число).
# В классе должны быть реализованы методы перегрузки арифметических операторов:
# - сложение (add()),
# - вычитание (sub()),
# - умножение (mul()),
# - деление (truediv()).
#
# Данные методы должны применяться только к клеткам и выполнять
# - увеличение,
# - уменьшение,
# - умножение
# - и целочисленное (с округлением до целого) деление клеток, соответственно.
#
# Сложение.
# Объединение двух клеток.
# При этом число ячеек общей клетки должно равняться сумме ячеек исходных двух клеток.
#
# Вычитание.
# Участвуют две клетки.
# Операцию необходимо выполнять только если разность количества ячеек двух клеток больше нуля,
# иначе выводить соответствующее сообщение.
#
# Умножение.
# Создается общая клетка из двух.
# Число ячеек общей клетки определяется как произведение количества ячеек этих двух клеток.
#
# Деление.
# Создается общая клетка из двух.
# Число ячеек общей клетки определяется как целочисленное деление количества ячеек этих двух клеток.
#
# В классе необходимо реализовать метод make_order(),
# принимающий экземпляр класса и количество ячеек в ряду.
# Данный метод позволяет организовать ячейки по рядам.
# Метод должен возвращать строку вида *****\n*****\n*****...,
# где количество ячеек между \n равно переданному аргументу.
# Если ячеек на формирование ряда не хватает, то в последний ряд записываются все оставшиеся.
#
# Например, количество ячеек клетки равняется 12, количество ячеек в ряду — 5.
# Тогда метод make_order() вернет строку: *****\n*****\n**.
# Или, количество ячеек клетки равняется 15, количество ячеек в ряду — 5.
# Тогда метод make_order() вернет строку: *****\n*****\n*****.
#
# Подсказка: подробный список операторов для перегрузки доступен по ссылке.
import random as r
import math as m


class OrganicCell:
	_ocNum: int = 0
	_cCount: int
	_lstOperation: str

	def __init__(self, cellCount: int, lstOperation: str = ""):
		OrganicCell._ocNum += 1
		self._cCount = cellCount
		self._lstOperation = lstOperation
		self._ocNum = OrganicCell._ocNum

	# сложение
	def __add__(self, other):
		if isinstance(other, OrganicCell):
			return OrganicCell(self._cCount + other._cCount, "// получена при сложении")

	# вычитание
	def __sub__(self, other):
		if isinstance(other, OrganicCell):
			_sub = self._cCount - other._cCount
			if _sub < 0:
				print("Невозможно выполнить вычитание, результат отрицательный")
			return OrganicCell(_sub if _sub >= 0 else 0, "// получена при вычитании")

	# умножение
	def __mul__(self, other):
		if isinstance(other, OrganicCell):
			return OrganicCell(self._cCount * other._cCount, "// получена при умножении")

	# деление
	def __truediv__(self, other):
		if isinstance(other, OrganicCell):
			return OrganicCell(self._cCount // other._cCount, "// получена при делении")

	# вывод
	def __str__(self):
		return f"Орг.клетка ({self._ocNum}). Количество ячеек в клетке: {self._cCount} {self._lstOperation}"

	def make_order(self, cell_rowCount: int):

		max_value = max(cell_rowCount, self._cCount)
		min_value = min(cell_rowCount, self._cCount)

		columns = m.ceil(self._cCount / cell_rowCount)
		columns = columns if abs(columns) > 1 else 1
		print(f"Орг.клетка ({self._ocNum}). Количество ячеек в ряду: {cell_rowCount}")

		result_str = ""
		for x in range(1, columns + 1):
			part_num = max_value / (min_value * x) if (min_value * x) != 0 else 0
			if part_num == 0:
				return
			sym_num = min_value if part_num > 1 else max_value - (min_value * (x - 1))
			result_str = result_str + f"{'*'*sym_num}\n"

		return result_str


# cells1 = OrganicCell(9)
cells1 = OrganicCell(r.randint(5, 20))
cells2 = OrganicCell(r.randint(5, 20))
cells3 = cells1 + cells2
# cells4 = cells1 - cells2
# cells5 = cells1 * cells2
# cells6 = cells1 / cells2

print(cells1)
print(cells2)
print(cells3)
# print(cells3)
# print(cells4)
# print(cells5)
# print(cells6)

print()

print(cells1.make_order(r.randint(4, 10)))
print(cells2.make_order(r.randint(4, 10)))
print(cells3.make_order(r.randint(4, 10)))

