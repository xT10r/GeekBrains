from itertools import count


def some_number(start=0):
    yield start + 1


for x in count(100, 10):
    if x > 1000:
        break
    print(x)
print("Done")
