# Задание 1.
# Реализовать класс Matrix (матрица).
# Обеспечить перегрузку конструктора класса (метод init()),
# который должен принимать данные (список списков) для формирования матрицы.
#
# Подсказка: матрица — система некоторых математических величин,
# расположенных в виде прямоугольной схемы.
#
# Примеры матриц: см. в методичке.
#
# Следующий шаг — реализовать перегрузку метода str() для вывода матрицы в привычном виде.
# Далее реализовать перегрузку метода add() для реализации операции сложения двух объектов класса Matrix (двух матриц).
# Результатом сложения должна быть новая матрица.
#
# Подсказка: сложение элементов матриц выполнять поэлементно —
# первый элемент первой строки первой матрицы складываем с первым элементом первой строки второй матрицы и т.д.

import random as r


class Matrix:
	_counter: int = 0

	def __init__(self, w, h, m=None):
		Matrix._counter += 1
		self._w = w
		self._h = h
		self._m = [[r.randint(1, 150) for x in range(w)] for y in range(h)] if m is None else m
		self._counter = Matrix._counter

	def __str__(self):
		m_str = f'Матрица {self._counter}\n'
		for m_col in self._m:
			for m_row in m_col:
				m_str = m_str + f"{str(m_row):<10}"
			m_str = m_str + '\n'
		return m_str

	def __add__(self, other):
		if isinstance(other, Matrix):
			if other._h != self._h and other._w != self._w:
				return "Сложение невозможно. Разные размерности матриц"
			new_matrix = []
			new_row = []
			for ci in range(0, len(self._m)):
				for ri in range(0, len(self._m[ci])):
					new_row.append(self._m[ci][ri] + other._m[ci][ri])
				new_matrix.append(new_row.copy())
				new_row.clear()
			return Matrix(self._w, self._h, new_matrix)
		else:
			return f"Что-то пошло не так!"


matrix1 = Matrix(3, 3)
matrix2 = Matrix(3, 3)

matrix3 = matrix1 + matrix2
print(matrix1)
print(matrix2)
print(matrix3)
