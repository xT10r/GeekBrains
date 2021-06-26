clear

# роль для установки MySQL
#ansible-galaxy install geerlingguy.mysql --roles-path=~/AnsibleServer/roles/

ansible-playbook -i ./inventory/hosts ./playbooks/lesson3-playbook.yml --verbose
