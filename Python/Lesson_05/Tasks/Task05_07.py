# Задание 7.
# Создать вручную и заполнить несколькими строками текстовый файл,
# в котором каждая строка должна содержать данные о фирме:
# - название,
# - форма собственности,
# - выручка,
# - издержки.
#
# Пример строки файла: firm_1 ООО 10000 5000.
#
# Необходимо построчно прочитать файл, вычислить прибыль каждой компании,
# а также среднюю прибыль. Если фирма получила убытки, в расчет средней прибыли
# ее не включать.
# Далее реализовать список. Он должен содержать словарь с фирмами и их прибылями,
# а также словарь со средней прибылью.
# Если фирма получила убытки, также добавить ее в словарь (со значением убытков).
# Пример списка:
# [{“firm_1”: 5000, “firm_2”: 3000, “firm_3”: 1000}, {“average_profit”: 2000}].
#
# Итоговый список сохранить в виде json-объекта в соответствующий файл.
# Пример json-объекта:
#
# [{"firm_1": 5000, "firm_2": 3000, "firm_3": 1000}, {"average_profit": 2000}]

import os
import sys
import json

def isdigit_value(values):
    for value in values:
        if value.isdigit():
            return float(value) if not float(value).is_integer() else int(value)
        else:
            try:
                return float(value)
            except ValueError:
                return value


path_script = f"{os.path.dirname(sys.argv[0])}"
path_companyInfo = os.path.join(path_script, 'Task05_07_Data.txt')
path_companyProfit = os.path.join(path_script, 'Task05_07_CompanyProfit.txt')
path_companyDamages = os.path.join(path_script, 'Task05_07_CompanyDamages.txt')

dict_profit = {}
dict_damages = {}

with open(path_companyInfo, 'r', encoding='utf-8') as companyInfo_stream:
    company_lines = companyInfo_stream.readlines()
    for company_line in company_lines:
        company_line = [isdigit_value(item.split()) for item in company_line.split()]
        company_profit = round(company_line[2] - company_line[3], 2)

        if company_profit > 0:
            dict_profit[company_line[0]] = company_profit
        else:
            dict_damages[company_line[0]] = company_profit

sum_profit = sum(dict_profit.values())/len(dict_profit)
sum_damages = sum(dict_profit.values())/len(dict_profit)

with open(path_companyProfit, 'w', encoding='utf-8') as company_profit_stream:
    json.dump([dict_profit, {"average_profit": sum_profit}], company_profit_stream, ensure_ascii=False)

with open(path_companyDamages, 'w', encoding='utf-8') as company_damages_stream:
    json.dump([dict_damages, {"average_profit": sum_damages}], company_damages_stream, ensure_ascii=False)
