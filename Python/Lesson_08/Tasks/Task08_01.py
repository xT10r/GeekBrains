# Задание 1.
# Реализовать класс «Дата», функция-конструктор которого должна принимать дату в виде строки формата «день-месяц-год».
# В рамках класса реализовать два метода.
#
# Первый, с декоратором @classmethod, должен извлекать число, месяц, год и преобразовывать их тип к типу «Число».
# Второй, с декоратором @staticmethod, должен проводить валидацию числа, месяца и года (например, месяц — от 1 до 12).
#
# Проверить работу полученной структуры на реальных данных.
from datetime import datetime as dt
import re


class MyDate:
	_dateAsIs: str = ""
	_date: dt = dt.strptime('01-01-0001', '%d-%m-%Y')

	def __init__(self, input_date: str):
		self._dateAsIs = input_date

	@classmethod
	def extract_date_parts(cls, dateAsIs: str):
		_day, _month, _year = dateAsIs.split('-') if dateAsIs.find("-") > 0 else ['0', '0', '0']
		return int(_day), int(_month), int(_year)

	def __str__(self):
		_day, _month, _year = self.extract_date_parts(self._dateAsIs)
		return f"{str(_day).zfill(2)}-{str(_month).zfill(2)}-{str(_year).zfill(4)} {self.validation(_day, _month, _year)}"

	@staticmethod
	def validation(day: int = 1, month: int = 1, year: int = 1):

		max_year = dt.max.year
		max_month = dt.max.month
		max_day = dt.max.day

		result = ""
		err_message = "\033[32m> no errors found when checking maximum values\033[31m"
		err_in_message = ""

		# Доп. проверка по маске: день, месяц - двузначное число, год - четырехзначное число
		tmp_date_str = f"{day}-{month}-{year}"
		tmp_date = re.search("([0-9]{1,2})(?:-[0-9]{1,2})(?:-[0-9]{4,})", tmp_date_str)
		if tmp_date is None:
			err_in_message = f"(\033[33minput value: {tmp_date_str} does not match format \"01-01-1000\"\033[0m)"

		# Шаблон сообщения для вывода ошибочных значений: дня, месяца, года
		err_message_template = "> {} {} greater than max value {} by datatype: \"datetime\""

		# Проверка на максимальные значения
		if year > max_year:
			err_message = err_message_template.format("Year", year, max_year)
		if month > max_month:
			err_message = err_message_template.format("Month", month, max_month)
		if day > max_day:
			err_message = err_message_template.format("Day", day, max_day)

		input_date_str = f"{str(day).zfill(2)}-{str(month).zfill(2)}-{str(year).zfill(4)}"

		# Проверка по типу данных datetime
		# Тут есть один нюанс с проверкой ГОДА.
		try:
			year_mask = "%Y" if year > 99 else "%y"
			year_str = str(year).zfill(2) if year < 99 else str(year).zfill(4)
			tmp_date = dt.strptime(f'{day}-{month}-{year_str}', f"%d-%m-{year_mask}")

			system_date_str = f"{str(tmp_date.day).zfill(2)}-{str(tmp_date.month).zfill(2)}-{str(tmp_date.year).zfill(4)}"

			result = f"\n\033[32mValidation successful {err_in_message}\n" \
			         f"> system datetime is {system_date_str}\n" \
			         f"> input datetime is {input_date_str}\033[0m"
		except ValueError as ex:
			result = f"\n\033[31mValidation failed:\n> {input_date_str}\n{err_message}\n> {ex}\033[0m"

		return result


my_date_str = "12-12-1980"
my_date = MyDate(my_date_str)
print(my_date)
