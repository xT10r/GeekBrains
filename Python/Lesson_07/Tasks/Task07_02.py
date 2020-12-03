# Задание 2.
# Реализовать проект расчета суммарного расхода ткани на производство одежды.
# Основная сущность (класс) этого проекта — одежда, которая может иметь определенное название.
# К типам одежды в этом проекте относятся пальто и костюм.
# У этих типов одежды существуют параметры: размер (для пальто) и рост (для костюма).
# Это могут быть обычные числа: V и H, соответственно.
# Для определения расхода ткани по каждому типу одежды использовать формулы:
# - для пальто (V/6.5 + 0.5),
# - для костюма (2*H + 0.3).
#
# Проверить работу этих методов на реальных данных.
#
# Реализовать общий подсчет расхода ткани.
# Проверить на практике полученные на этом уроке знания:
# - реализовать абстрактные классы для основных классов проекта,
# - проверить на практике работу декоратора @property.
from abc import ABC


class Cloth:
	V: int = 0
	H: int = 0

	def __init__(self, V, H):
		self.V = V if self.V == 0 else self.V
		self.H = H if self.V == 0 else self.V

	@property
	def get_tissue_consumption(self):
		if isinstance(self, Coat):
			Cloth.V = self.V
			return f"Расход ткани для пальто (V={self.V}): {self.V / 6.5 + 0.5}"
		elif isinstance(self, Jacket):
			Cloth.H = self.H
			return f"Расход ткани для костюма (H={self.H}): {2 * self.H + 0.3}"

	@property
	def get_general_fabric_calculation(self):
		return f"Общие затраты ткани: {Cloth.V + Cloth.H}"


class Coat(Cloth, ABC):

	def __init__(self, V):
		super().__init__(V, 0)


class Jacket(Cloth, ABC):

	def __init__(self, H):
		super().__init__(0, H)


my_coat = Coat(10)
my_jacket = Jacket(4)

print(my_coat.get_tissue_consumption)
print(my_jacket.get_tissue_consumption)

print(my_jacket.get_general_fabric_calculation)
