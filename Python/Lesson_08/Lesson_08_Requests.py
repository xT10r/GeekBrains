import requests

response = requests.get("https://google.com", {"q": "python language"})
# https://google.com?q=python+language
print(response.status_code)
print(response.content)
# print(response.text)
