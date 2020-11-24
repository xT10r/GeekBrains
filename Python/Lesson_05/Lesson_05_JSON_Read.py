import json
import os
import sys

script_path = f"{os.path.dirname(sys.argv[0])}"
file_path = os.path.join(script_path, 'person.json')

with open(file_path) as file_stream:
    person = json.load(file_stream)

    print(sum(person['salaries']))
