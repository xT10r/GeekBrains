import os
import shutil
import sys
from time import sleep

path_source = f"{os.path.dirname(sys.argv[0])}"
path_target = os.path.join(path_source, 'test_dir')

file_source = os.path.join(path_source, 'person.json')
file_target = os.path.join(path_target, 'person.json')

if not os.path.exists(path_target):
    os.mkdir(path_target, mode=0o777)

if not os.path.exists(file_target):
    shutil.copyfile(file_source, file_target)

# sleep(2)

# shutil.rmtree(path_target)

sys.stdin  # стандартный ввод
sys.stdout  # стандартный вывод
sys.stderr  # стандартный вывод ошибок

print(sys.platform)
