simple_string = "Hello, World!"
byte_string = b"Hello, World!"

byte_array_string = bytearray(byte_string)

print(byte_string)
print(type(simple_string))
print(type(byte_string))
print(type(byte_array_string))

name = "John"
byte_name = name.encode("UTF-8")
print(type(byte_name))
