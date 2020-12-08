# Pip. Особенности использования
# Это популярная система управления пакетами,
# предназеначенная для установки и управления программными пакетами,
# реализованными  помощью Python
#
# pip help - получить подсказку о доступных командах
# pip install [package_name] - установить пакет [package_name]
# pip uninstall [package_name] - удалить пакет [package_name]
# pip list - получить сипсок установленных пакетов
# pip search [package_name] - найти пакет по имени
# pip install -U [package_name] - обновить указанный пакет
# pip show [package_name] - получить информацию об установленном пакете
#
# ! Важно использовать Virtualenv (чтобы пакеты устанавливались именно в директорию проекта, а не в "рут"
# Особенности использования
# Под виртуальной средой понимают директорию, содержащую необходимые для работы приложения-пакеты,
# позволяющие выполнять изолированный запуск приложения.
# Установка virtualenv: pip install virtualenv
# Создание виртуальной среды: virtualenv my_proj
#
# активация виртуальной среды:
# - my_proj\Scripts\activate - Windows
# - source my_proj/venv/bin/activate - Linux, MacOS
#
# деактивация виртуальной среды:
# - my_proj\Scripts\deactivate - Windows
# - deactivate - Linux, MacOS
