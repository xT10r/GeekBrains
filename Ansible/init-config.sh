clear

# Создаем папку для Ansible файлов
mkdir -p ~/ansible
cd ~/ansible

# Архивируем уже имеющиеся Ansible файлы (папка layout)
mkdir -p ./archive
zip -r ./archive/layout-"$(date +"%Y_%m_%d_%I_%M_%p")".zip ./layout ./*.* -x /archive

# Очищаем каталог layout
rm -rf ./layout

#

# Создаем каталог layout и переходим в него
mkdir -p ./layout
cd ./layout

# ===== Уровень 1 ======

# Создаем каталог ролей
mkdir -p ./roles

# Создаем каталог inventory с подкаталогом local
mkdir -p ./inventory/local

# ===== Уровень 2+ ======

# Создаем каталоги групповых переменных и переменных хоста
mkdir -p ./inventory/local/group_vars
mkdir -p ./inventory/local/host_vars

# Создаем каталог роли для создания файлов
mkdir -p ./roles/create_file/tasks
mkdir -p ./roles/intra/restart_service/tasks


# заполнение конфигурационных файлов
# Layout-config
echo -e "# здесь могла быть ваша реклама" > ./inventory/all_in_one.ini
echo -e "[application]\n127.0.0.1\n\n[load_balancer]\n127.0.0.1" > ./inventory/local/config-default.ini

# Group VAR config
echo -e "---\nfoo: \"bar2\"" > ./inventory/local/group_vars/all.yml

# Host VAR config
echo -e "---" > ./inventory/local/host_vars/all.yml

# Playbook config
cd ~/ansible/
echo -e "---\n- name: Test application\n  hosts: applications\n  tasks:\n    - shell: echo 123" > ./playbook-default.yml
## ...с указанием роли
echo -e "\n- name: Test application\n  hosts: application\n  roles:\n    - role: intra/restart_service" >> ./playbook-d>echo -e "\n- name: Test application\n  hosts: application\n  roles:\n    - role: create_file" >> ./playbook-default.yml

# Playbook Roles
cd ~/ansible/layout/roles
echo -e "---\n - shell: echo foo bar" > ./create_file/tasks/main.yml
echo -e "---" > ./intra/restart_service/tasks/main.yml

# Ansible config
cd ~/ansible/
echo -e "[defaults]\nhost_key_checking = False\n\n[ssh_connections]\nssh_connection = -C -o ControlMaster=auto -o Contr>
# проверка заполнения Inventory
cd ~/ansible/layout/inventory/local

ansible-inventory -i ./config-default.ini --graph --vars
