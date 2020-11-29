# Задание 6.
# Реализовать класс Stationery (канцелярская принадлежность).
# Определить в нем атрибут title (название) и метод draw (отрисовка).
# Метод выводит сообщение “Запуск отрисовки.”
# Создать три дочерних класса Pen (ручка), Pencil (карандаш), Handle (маркер).
# В каждом из классов реализовать переопределение метода draw.
# Для каждого из классов метод должен выводить уникальное сообщение.
# Создать экземпляры классов и проверить, что выведет описанный метод для каждого экземпляра.
#


class Stationery:
	_title: str

	def __init__(self, title):
		self._title = title

	def draw(self):
		print(f'Запуск отрисовки.')


class Pen(Stationery):

	def __init__(self, title):
		super().__init__(title)

	def draw(self):
		print(f'Запуск отрисовки \'{self._title}\' (ручкой)')


class Pencil(Stationery):

	def __init__(self, title):
		super().__init__(title)

	def draw(self):
		print(f'Запуск отрисовки \'{self._title}\' (карандашом)')


class Handle(Stationery):

	def __init__(self, title):
		super().__init__(title)

	def draw(self):
		print(f'Запуск отрисовки \'{self._title}\' (маркером)')


pen = Pen("черепаха")
pen.draw()

pencil = Pen("жук")
pencil.draw()

handle = Handle("медверь")
handle.draw()
