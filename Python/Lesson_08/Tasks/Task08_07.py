# Задание 7.
# Реализовать проект «Операции с комплексными числами».
# Создайте класс «Комплексное число», реализуйте перегрузку методов сложения и умножения комплексных чисел.
# Проверьте работу проекта, создав экземпляры класса (комплексные числа)
# и выполнив сложение и умножение созданных экземпляров. Проверьте корректность полученного результата.

class Complex:
	real: int
	imag: int

	def __init__(self, i: float, j: float):
		self.real = i if isinstance(i, float) else int(i)
		self.imag = j if isinstance(j, float) else int(j)

	# сложение
	def __add__(self, other):
		if isinstance(other, Complex):
			real = self.real + other.real
			imag = self.imag + other.imag
			return Complex(real, imag)
		else:
			print(f"Unknown value")
			return None

	# умножение
	def __mul__(self, other):
		if isinstance(other, Complex):

			r1 = self.real
			i1 = self.imag

			r2 = other.real
			i2 = other.imag

			real = r1 * r2 - i1 * i2
			imag = i1 * r2 + r1 * i2

			return Complex(real, imag)
		else:
			print(f"Unknown value")
			return None

	def __str__(self):
		return f"{self.real}{'-' if self.imag < 0 else '+'}{abs(self.imag)}j"


c1 = Complex(1, 2)
c2 = Complex(1, -3)

print(c1)
print(c2)

print(f"Сложение: {c1+c2}")
print(f"Умножение: {c1*c2}")

