# Задание 3.
# Создайте собственный класс-исключение, который должен проверять содержимое списка на наличие только чисел.
# Проверить работу исключения на реальном примере.
#
# Необходимо запрашивать у пользователя данные и заполнять список только числами.
# Класс-исключение должен контролировать типы данных элементов списка.
#
# Примечание: длина списка не фиксирована.
# Элементы запрашиваются бесконечно, пока пользователь сам не остановит работу скрипта, введя, например, команду “stop”.
# При этом скрипт завершается, сформированный список с числами выводится на экран.
#
# Подсказка: для данного задания примем, что пользователь может вводить только числа и строки.
# При вводе пользователем очередного элемента необходимо реализовать проверку типа элемента и вносить его в список,
# только если введено число.
#
# Класс-исключение должен не позволить пользователю ввести текст (не число) и отобразить соответствующее сообщение.
# При этом работа скрипта не должна завершаться.
import re


class MyDigitException(Exception):

	def __init__(self, digits: list):
		self.err_found = False
		for x in digits:
			if isinstance(x, str):
				self.err_found = True
				self.err_value = x

	def __str__(self):
		if self.err_found:
			return f'Введено не числовое значение: {self.err_value}'
		else:
			return f'Ошибок нет'


class myApp:
	_digit_array: list = []
	_var_array: list = []

	def __init__(self):

		while True:
			string_result = input("Введите что хочется или число (для выхода введите 'q' и нажмите <ENTER>): ")

			if string_result == "q":
				break

			digit_pattern = r"^[-]?([1-9]{1}[0-9]{0,}(\.[0-9]{0,})?|0(\.[0-9]{0,})?|\.[0-9]{0,})$"
			isDigit = re.match(digit_pattern, string_result) is not None

			self._var_array.append(string_result)

			try:
				self._err_found = False
				if not isDigit:
					raise MyDigitException(self._var_array)
			except MyDigitException as ex:
				self._err_found = ex.err_found
				if ex.err_found:
					print(ex)
			finally:
				if not self._err_found:
					digit_value = int(string_result) if string_result.find('.') < 0 else float(string_result)
					self._digit_array.append(digit_value)

	def __str__(self):
		return "\n".join(map(str, self._digit_array))


s = myApp()
print(s)
