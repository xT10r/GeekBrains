# Задание 4.
# Реализуйте базовый класс Car.
# У данного класса должны быть следующие атрибуты: speed, color, name, is_police (булево).
# А также методы:
# - go,
# - stop,
# - turn(direction),
# которые должны сообщать, что машина поехала, остановилась, повернула (куда).
#
# Опишите несколько дочерних классов:
# - TownCar,
# - SportCar,
# - WorkCar,
# - PoliceCar.
#
# Добавьте в базовый класс метод show_speed, который должен показывать текущую скорость автомобиля.
# Для классов TownCar и WorkCar переопределите метод show_speed.
#
# При значении скорости свыше 60 (TownCar) и 40 (WorkCar) должно выводиться сообщение о превышении скорости.
#


class Car:
	speed: int
	color: str
	name: str
	is_police: bool

	def __init__(self, speed: int, color: int, name: str, is_police: bool = False):
		color_dict = {1: "Red", 2: "Green", 3: "Blue"}
		self.speed = speed
		self.color = color_dict[color]
		self.name = name
		self.is_police = is_police

	def go(self):
		print(f'Автомобиль \'{self.name}\' {self.color} начал движение со скоростью {self.speed} км/ч')

	def stop(self):
		print(f'Автомобиль \'{self.name}\' {self.color} закончил движение')

	def turn(self):  # direction
		print(f'Автомобиль \'{self.name}\' {self.color} изменил направление движения, но куда...')

	def show_speed(self):
		print(f"Скорость автомобиля \'{self.name}\' {self.color} составляет {self.speed} км/ч")


class TownCar(Car):

	def __init__(self, speed: int, color: int, name: str, is_police: bool = False):
		super().__init__(speed, color, name, is_police)

	def show_speed(self):
		if self.speed > 60:
			print(f"[П] Скорость городского автомобиля \'{self.name}\' {self.color}: {self.speed} "
			      f"км/ч (превышает 60 км/ч)")
		else:
			print(f"[П] Скорость городского автомобиля \'{self.name}\' {self.color}: {self.speed} км/ч")


class SportCar(Car):
	def __init__(self, speed: int, color: int, name: str, is_police: bool = False):
		super().__init__(speed, color, name, is_police)


class WorkCar(Car):

	def __init__(self, speed: int, color: int, name: str, is_police: bool = False):
		super().__init__(speed, color, name, is_police)

	def show_speed(self):
		if self.speed > 40:
			print(f"[П] Скорость рабочего автомобиля \'{self.name}\' {self.color}: {self.speed} "
			      f"км/ч (превышает 40 км/ч)")
		else:
			print(f"[П] Скорость рабочего автомобиля \'{self.name}\' {self.color}: {self.speed} км/ч")


class PoliceCar(Car):
	def __init__(self, speed: int, color: int, name: str, is_police: bool = False):
		super().__init__(speed, color, name, is_police)

