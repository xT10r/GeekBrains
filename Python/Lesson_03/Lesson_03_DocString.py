def hello_world(world="World"):
    """
    Возврат строки приветствия
    :param world: Кого приветствуем
    :return: Строка приветствия
    :rtype str
    """
    return f"Hello, {world}"

print(hello_world())
print(hello_world("Home"))