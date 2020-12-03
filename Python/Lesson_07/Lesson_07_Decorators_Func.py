# Декоратор (пример функции)

def print_decorator(func):
	def wrapper(*args, **kwargs):
		print("Start")
		func(*args, **kwargs)
		print("End")

	return wrapper


@print_decorator
def show_message(content):
	print(content)





show_message("Hello, World!")
