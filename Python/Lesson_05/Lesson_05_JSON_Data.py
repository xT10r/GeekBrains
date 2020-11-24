import json
import os
import sys

script_path = f"{os.path.dirname(sys.argv[0])}"
file_path = os.path.join(script_path, 'person.json')
person = {
    "name": "John",
    "age": 40,
    "salaries": [100, 200, 160]
}

with open(file_path, 'w') as file_stream:
    json.dump(person, file_stream)
