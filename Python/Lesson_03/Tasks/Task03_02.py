# Задание 2. Реализовать функцию, принимающую несколько параметров, описывающих данные пользователя:
# - имя,
# - фамилия,
# - год рождения,
# - город проживания,
# - email,
# - телефон.
#
# Функция должна принимать параметры как именованные аргументы.
# Реализовать вывод данных о пользователе одной строкой.


def get_userInfo(**userParams):
    """
    Принимает именнованные аргументов и возвращает определенную строку из них\n
    > firstName - имя,\n
    > lastName - фамилия,\n
    > birthYear - год рождения,\n
    > curCity - город проживания,\n
    > email - электронная почта,\n
    > phoneNumber - телефон\n

    :param userParams: **userParams
    :return: str
    """
    return print(f"имя: {userParams.get('firstName')}, "
                 f"фамилия: {userParams.get('lastName')}, "
                 f"год рождения: {userParams.get('birthYear')}, "
                 f"город проживания: {userParams.get('curCity')}, "
                 f"email: {userParams.get('eMail')},"
                 f"телефон: {userParams.get('phoneNumber')}")


get_userInfo(
    firstName="Jonathan",
    lastName="Termi",
    birthYear=1980,
    curCity="London",
    eMail="boom@badaboom.seven",
    phoneNumber="+1871230761")
