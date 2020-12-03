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
from abc import ABC, abstractmethod


class Cloth:

	@abstractmethod
	def get_tissue_consumption(self):
		if isinstance(self, Coat):
			return f"Расход ткани для пальто (V={self.V}): {self.V / 6.5 + 0.5}"
		elif isinstance(self, Jacket):
			return f"Расход ткани для костюма (H={self.H}): {2 * self.H + 0.3}"


class Coat(Cloth, ABC):

	@property
	def get_coat_fabric_consumption(self):
		return super().get_tissue_consumption()

	def __init__(self, value=0):
		self.V = value if isinstance(value, (int, float)) else 0


class Jacket(Cloth, ABC):

	@property
	def get_jacket_consumption(self):
		return super().get_tissue_consumption()

	def __init__(self, value=0):
		self.H = value if isinstance(value, (int, float)) else 0


my_coat = Coat(10.4)
my_jacket = Jacket(4)

print(my_coat.get_coat_fabric_consumption)

print(my_jacket.get_jacket_consumption)
