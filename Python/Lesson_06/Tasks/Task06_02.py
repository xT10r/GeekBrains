# Задание 2.
# Реализовать класс Road (дорога), в котором определить атрибуты: length (длина), width (ширина).
# Значения данных атрибутов должны передаваться при создании экземпляра класса.
# Атрибуты сделать защищенными.
# Определить метод расчета массы асфальта, необходимого для покрытия всего дорожного полотна.
# Использовать формулу: длина*ширина*масса асфальта для покрытия одного кв метра дороги асфальтом,
# толщиной в 1 см*число см толщины полотна.
#
# Проверить работу метода.
#
# Например: 20м*5000м*25кг*5см = 12500 т
#


class Road:
	__length: int
	__width: int

	def __init__(self, lenght, width):
		self.__length = lenght
		self.__width = width

	def get_mass_of_asphalt(self, mass: int = 1, depth: int = 1):
		result = self.__length * self.__width * mass * (depth / 1000)
		result = int(result) if float(result).is_integer() else float(result)
		return result


# Проверка метода (реализован в классе)
print(f"Масса асфальта = {Road(20, 5000).get_mass_of_asphalt(25, 5)} т")
