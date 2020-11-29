# Задание 5.
# Создайте экземпляры классов, передайте значения атрибутов.
# Выполните доступ к атрибутам, выведите результат.
# Выполните вызов методов и также покажите результат.
#

import Lesson_06.Tasks.Task06_04 as ImportCar  # Импортирую предыдущий скрипт задания


# car = Car(60, 2, "Ракета", False)

sportCar = ImportCar.SportCar(140, 1, "McLaren P1")
sportCar.go()
sportCar.turn()
sportCar.stop()
sportCar.show_speed()
print(f'\n>> Доступ к атрибутам:'
      f'\nspeed: {sportCar.speed}'
      f'\ncolor: {sportCar.color}'
      f'\nname: {sportCar.name}'
      f'\nis_police: {sportCar.is_police}\n')
print()
townCar = ImportCar.TownCar(40, 3, "KIA")
townCar.go()
townCar.stop()
townCar.show_speed()
print()
workCar = ImportCar.WorkCar(61, 2, "Газель")
workCar.go()
workCar.stop()
workCar.show_speed()
