user = {"name": "John"}

try:
    print(user["age"])
except KeyError:
    print("Invalid key!")
