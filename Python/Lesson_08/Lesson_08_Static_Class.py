class Operations:
	"""
	Decription for class
	описание записывается в __doc__
	"""
	class_name: str  # эта переменная с определенным типом запишится в аннтотации класса __annotations__
	class_attr: int  # см. выше

	@staticmethod
	def lower_string(content: str):
		return content.lower()

	@staticmethod
	def upper_string(content: str):
		return content.upper()

	# классовый метод позволяет обращаться к методам класса
	# например в качестве валидатора исходных данных
	@classmethod
	def normalize(cls, content):
		a = cls.lower_string(content)
		return cls.upper_string(a)


temp_string = "Hello!"
print(Operations.lower_string(temp_string))
print(Operations.normalize(temp_string))

print(Operations.__dict__)
print(Operations.__annotations__)
print(Operations.__doc__)