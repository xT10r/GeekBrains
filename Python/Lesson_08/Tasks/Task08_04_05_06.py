# Задание 4.
# Начните работу над проектом «Склад оргтехники».
# Создайте класс, описывающий склад.
# А также класс «Оргтехника», который будет базовым для классов-наследников.
#
# Эти классы — конкретные типы оргтехники (принтер, сканер, ксерокс).
# В базовом классе определить параметры, общие для приведенных типов.
# В классах-наследниках реализовать параметры, уникальные для каждого типа оргтехники.

# Задание 5.
# Продолжить работу над первым заданием.
# Разработать методы, отвечающие за приём оргтехники на склад и передачу в определенное подразделение компании.
#
# Для хранения данных о наименовании и количестве единиц оргтехники,
# а также других данных, можно использовать любую подходящую структуру, например словарь.

# Задание 6.
# Продолжить работу над вторым заданием.
# Реализуйте механизм валидации вводимых пользователем данных.
# Например, для указания количества принтеров, отправленных на склад, нельзя использовать строковый тип данных.
#
# Подсказка: постарайтесь по возможности реализовать
# в проекте «Склад оргтехники» максимум возможностей, изученных на уроках по ООП.
#

from random import randint as ri


# Исключения
class NotEnoughEquipmentInStorage(Exception):
	def __init__(self, office: str, eq_exist: int, eq_needle: int):
		self.office = office
		self.eq_exist = eq_exist
		self.eq_needle = eq_needle

	def __str__(self):
		return f"\033[31m>>> На складе недостаточно техники для передачи в \"{self.office}\". " \
		       f"Доступно: {self.eq_exist}, нужно: {self.eq_needle}\033[0m"


class StorageIsFull(Exception):
	def __init__(self, max_count: int, other):
		self.max_count = max_count
		self.item_name = other.name if isinstance(other, OfficeEquipment) else other

	def __str__(self):
		return f"\033[31mДостигнут лимит позиций на складе ({self.max_count}). " \
		       f"Невозможно добавить \"{self.item_name}\" на склад!\033[0m"


class MyTypeError(Exception):

	def __init__(self, inputType: type, needType: type):
		self.inputType = inputType
		self.needType = needType

	def __str__(self):
		return f"\033[31mНеверный тип значения: {self.inputType}. Ожидалось значение типа: {self.needType}\033[0m"


# Основной класс "Склад"
class Storage:
	max_items: int
	onStorage: dict
	inOperation: dict

	# Инициализации
	def __init__(self, max_items=0):
		self.max_items = max_items
		self.onStorage = {'Printer': [], 'Scanner': [], 'Xerox': []}
		self.inOperation = {}

	# АВТО: добавление техники на склад
	def auto_add_to_storage(self, cPrinters: int = 0, cScanners: int = 0, cXerox: int = 0):
		for pr in [Printer(f"PrGen_{i}", f"172.1.{ri(1, 100)}.{ri(1, 100)}") for i in range(0, cPrinters)]:
			self.add_to_storage(pr)
		for sc in [Scanner(f"ScGen_{i}", f"172.2.{ri(1, 100)}.{ri(1, 100)}") for i in range(0, cScanners)]:
			self.add_to_storage(sc)
		for xr in [Xerox(f"XrGen_{i}", f"172.3.{ri(1, 100)}.{ri(1, 100)}") for i in range(0, cXerox)]:
			self.add_to_storage(xr)

	# ВРУЧНУЮ: добавить на склад
	def add_to_storage(self, other: 'OfficeEquipment'):
		try:
			if not isinstance(other, OfficeEquipment):
				raise MyTypeError(type(other), type(OfficeEquipment))
		except MyTypeError as mte:
			print(mte)
			return

		list_items: list
		key_type = ''
		if isinstance(other, Printer):
			key_type = 'Printer'
		elif isinstance(other, Scanner):
			key_type = 'Scanner'
		elif isinstance(other, Xerox):
			key_type = 'Xerox'

		list_items = self.onStorage[key_type]

		itemInList = False
		for item in list_items:
			if item.name == other.name:
				itemInList = True
		try:
			if self.get_number_of_pieces_of_equipment >= self.max_items and not itemInList:
				raise StorageIsFull(self.max_items, other)
		except StorageIsFull as sIsFull:
			print(sIsFull)
		else:
			self.onStorage[key_type].append(other) if not itemInList else None

	# ВРУЧНУЮ: получить количество единиц техники на складе
	@property
	def get_number_of_pieces_of_equipment(self):
		count = 0
		# количество единиц на складе
		for item_key in self.onStorage.keys():
			count += len(self.onStorage[item_key])
		return count

	# ВРУЧНУЮ: Передать в использование
	def put_into_operation(self, office: str = "Unknown", cPrinters: int = 0, cScanners: int = 0, cXerox: int = 0):
		tmp_eqOnStorage_list = self.onStorage.copy()

		tmp_request = {}

		if cPrinters > 0:
			tmp_request["Printer"] = cPrinters

		if cScanners > 0:
			tmp_request["Scanner"] = cScanners

		if cXerox > 0:
			tmp_request["Xerox"] = cXerox

		for tmp_request_key in tmp_request.keys():
			onStorage_count = len(self.onStorage[tmp_request_key])
			need_count = tmp_request[tmp_request_key]

			try:
				if onStorage_count < need_count:
					raise NotEnoughEquipmentInStorage(office, onStorage_count, need_count)
			except NotEnoughEquipmentInStorage as notEnough:
				print(f"{notEnough}")
			# print(f">>> Недостаточно техники: \"{notEnough.equipment}\" для передачи в \"{office}\". "
			#      f"На складе: {notEnough.eq_exist} / необходимо: {notEnough.eq_needle}")
			else:
				tmp_eqInOperation_list = self.onStorage[tmp_request_key][0:need_count].copy()

				if office not in self.inOperation.keys():
					self.inOperation[office] = []

				for x in tmp_eqInOperation_list:
					self.inOperation[office].append(x)

				for eqInOp in tmp_eqInOperation_list:
					for eqOnStr in tmp_eqOnStorage_list[tmp_request_key]:
						if eqInOp.name == eqOnStr.name:
							tmp_eqOnStorage_list[tmp_request_key].remove(eqOnStr)

		self.onStorage = tmp_eqOnStorage_list

	# Вывод количества единиц техники на складе... и т.п.
	def __str__(self):
		str_result = "Количество единиц техники на складе:\n"
		for equipment in self.onStorage:
			str_result += f"{equipment:<10} - {len(self.onStorage[equipment]):<10}\n"
		str_result += "Количество единиц техники в эксплуатации:\n"
		for office in self.inOperation.keys():
			office_eq = self.inOperation[office]
			str_result += f"> Помещение: {office:<10}\n"
			str_result += f"{'Printer':<10} - {len([x for x in office_eq if isinstance(x, Printer)]):<10}\n"
			str_result += f"{'Scanner':<10} - {len([x for x in office_eq if isinstance(x, Scanner)]):<10}\n"
			str_result += f"{'Xerox':<10} - {len([x for x in office_eq if isinstance(x, Xerox)]):<10}\n"
		return str_result


class OfficeEquipment:

	def __init__(self, name: str = "Unknown", ipAddress: str = "0.0.0.0", location: str = "-"):
		self.name = name
		self.ipAddress = ipAddress
		self.location = location

	def __str__(self):
		if isinstance(self, Printer):
			typeEq = "[Printer]"
		elif isinstance(self, Scanner):
			typeEq = "[Scanner]"
		elif isinstance(self, Xerox):
			typeEq = "[Xerox]"
		else:
			typeEq = "[Unknown]"
		#
		return f"{typeEq:<10} Name: {self.name:<15} ipAddress: {self.ipAddress:<16} location: {self.location:<15}"


class Printer(OfficeEquipment):

	@staticmethod
	def print():
		print("\n>>> Я печатаю <<<\n")


class Scanner(OfficeEquipment):

	@staticmethod
	def scan():
		print("\n>>> Я сканирую <<<\n")


class Xerox(OfficeEquipment):

	@staticmethod
	def photocopying():
		print("\n>>> Я ксерокопирую <<<\n")


storage = Storage(100)  # Заполняем максимальное количество мест на складе

printer_1 = Printer("Manual_Printer", "10.2.1.100")
printer_1.print()

scanner_1 = Scanner("Manual_Scanner", "10.22.102.121")
scanner_1.scan()

storage.add_to_storage(printer_1)
storage.add_to_storage(printer_1)

storage.auto_add_to_storage(50, 20, 20)  # Заполняем склад техникой в шт. / принтеры, сканеры, ксероксы /

storage.put_into_operation('office1', 155, 0, 0)  # выдаем технику подразеделниям (офисам)
storage.put_into_operation('office2', 10, 0, 0)
print(storage)
