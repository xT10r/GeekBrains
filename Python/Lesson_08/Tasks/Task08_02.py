# Задание 2.
# Создайте собственный класс-исключение, обрабатывающий ситуацию деления на нуль.
# Проверьте его работу на данных, вводимых пользователем.
# При вводе пользователем нуля в качестве делителя
# программа должна корректно обработать эту ситуацию и не завершиться с ошибкой.


class DivisionByZeroException(Exception):
	def __init__(self, x: float, y: float):
		self.x = x
		self.y = y
		self.ex_result = f"Обнаружено деление на ноль\n" \
		                 f"Операция не может быть выполнена ({str(self.x)} / {str(self.y)} = ?? )"

	def __str__(self):
		return f"{self.ex_result}"


def Division(x: float, y: float):
	x = int(x) if isinstance(x, int) else x
	y = int(y) if isinstance(y, int) else y
	if y == 0:
		raise DivisionByZeroException(x, y)
	else:
		return x / y


try:
	result = Division(12, 0)
	print(result)
except DivisionByZeroException as ex:
	print(ex.ex_result)
