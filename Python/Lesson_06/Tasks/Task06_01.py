# Задание 1.
# Создать класс TrafficLight (светофор) и определить у него один атрибут color (цвет) и метод running (запуск).
# Атрибут реализовать как приватный.
# В рамках метода реализовать переключение светофора в режимы: красный, желтый, зеленый.
# Продолжительность:
# - первого состояния (красный) составляет 7 секунд,
# - второго (желтый) — 2 секунды,
# - третьего (зеленый) — на ваше усмотрение.
#
# Переключение между режимами должно осуществляться только в указанном порядке (красный, желтый, зеленый).
# Проверить работу примера, создав экземпляр и вызвав описанный метод.
#
# Задачу можно усложнить,
# реализовав проверку порядка режимов, и при его нарушении выводить соответствующее сообщение и завершать скрипт.
#
import time


class TrafficLight:
	_color = {1: "\033[1;31m█", 2: "\033[33m█", 3: "\033[0;32m█"}

	def running(self):
		on_light = {1: 7, 2: 2, 3: 5}  # время включения цветов в сек: 7-кр, 2-жел, 5-зел (как вариант)

		for color_key in self._color.keys():
			int_key = int(color_key)
			int_index = int(on_light[int_key])
			print()
			for i in range(0, int_index):
				print(self._color[color_key], end='')
				time.sleep(1)


lights = TrafficLight()
lights.running()