# import time
from time import time as std_time, sleep as std_sleep

start = std_time()
print(f"Start at: {start}")

std_sleep(2)

end = std_time()
print(f"Stop at: {end}")
