# Домашнее задание к занятию «Использование Python для решения типовых DevOps-задач»

### Цель задания

В результате выполнения задания вы:

* познакомитесь с синтаксисом Python;
* узнаете, для каких типов задач его можно использовать;
* воспользуетесь несколькими модулями для работы с ОС.


### Инструкция к заданию

1. Установите Python 3 любой версии.
2. Скопируйте в свой .md-файл содержимое этого файла, исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-02-py/README.md).
3. Заполните недостающие части документа решением задач — заменяйте `???`, остальное в шаблоне не меняйте, чтобы не сломать форматирование текста, подсветку синтаксиса. Вместо логов можно вставить скриншоты по желанию.
4. Для проверки домашнего задания в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем репозитории.
4. Любые вопросы по выполнению заданий задавайте в чате учебной группы или в разделе «Вопросы по заданию» в личном кабинете.

### Дополнительные материалы

1. [Полезные ссылки для модуля «Скриптовые языки и языки разметки».](https://github.com/netology-code/sysadm-homeworks/tree/devsys10/04-script-03-yaml/additional-info)

------

## Задание 1

Есть скрипт:

```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:

| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | Ошибка TypeError в python нельзя складывать int и str  |
| Как получить для переменной `c` значение 12?  | изменить a с int на str "a = str(a)"   |
| Как получить для переменной `c` значение 3?  | изменить b на int "b = int(b)"  |

------

## Задание 2

Мы устроились на работу в компанию, где раньше уже был DevOps-инженер. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. 

Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:

```python
#!/usr/bin/env python3

import os


bash_command = ["cd ~/netology/sysadm-homeworks/admin_home_works_DevOps28*", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(os.path.abspath(result))
#        break

```

### Вывод скрипта при запуске во время тестирования:

```
vagrant@vagrant:~/netology/sysadm-homeworks/admin_home_works_DevOps28$ python3 test.py
/home/vagrant/netology/sysadm-homeworks/admin_home_works_DevOps28/      modified:   temp_test.txt
/home/vagrant/netology/sysadm-homeworks/admin_home_works_DevOps28/      modified:   test.py
```

------

## Задание 3

Доработать скрипт выше так, чтобы он не только мог проверять локальный репозиторий в текущей директории, но и умел воспринимать путь к репозиторию, который мы передаём, как входной параметр. Мы точно знаем, что начальство будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:

```python
#!/usr/bin/env python3

import os

path = os.getcwd()+'/sysadm-homeworks' #путь к каталогу с репозиториям
print("Выберите репозиторий: ")
repo = os.listdir(path)
num_chois = 0
repo_dict = {}
for f in repo:
    num_chois += 1
    repo_dict[num_chois] = f
    print(f"{num_chois}. {f}")

last_point = num_chois + 1
print(f"{last_point}. Ввести путь вручную")
print(f"0. Введите для выхода ")

user_chois = int(input("Введите номер репозитория: "))
if user_chois == last_point:
    repo_dict[last_point] = input("Введите путь к репозиторию: ")
if user_chois == 0:
    exit()
user_repo = (f"{path}/{repo_dict[user_chois]}")



bash_command = ["cd "+user_repo, "git status"]
#print(bash_command)
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False
print(f"Изменения в репозитории {user_repo}")
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(os.path.abspath(prepare_result))
#        break

```

### Вывод скрипта при запуске во время тестирования:

```
vagrant@vagrant:~/netology$ pwd
/home/vagrant/netology
vagrant@vagrant:~/netology$ ls -lh
total 12K
drwxrwxr-x 5 vagrant vagrant 4.0K Jun  7 15:03 sysadm-homeworks
-rw-rw-r-- 1 vagrant vagrant 1.2K Jun  7 18:14 temp.py
-rw-rw-r-- 1 vagrant vagrant  383 Jun  7 14:04 test.py
vagrant@vagrant:~/netology$ python3 temp.py
Выберите репозиторий:
1. devops_test
2. test_1
3. admin_home_works_DevOps28
4. Ввести путь вручную
0. Введите для выхода
Введите номер репозитория: 1
Изменения в репозитории /home/vagrant/netology/sysadm-homeworks/devops_test
/home/vagrant/netology/README.md
/home/vagrant/netology/new_word.txt
/home/vagrant/netology/test.md
/home/vagrant/netology/test.py
vagrant@vagrant:~/netology$ python3 temp.py
Выберите репозиторий:
1. devops_test
2. test_1
3. admin_home_works_DevOps28
4. Ввести путь вручную
0. Введите для выхода
Введите номер репозитория: 3
Изменения в репозитории /home/vagrant/netology/sysadm-homeworks/admin_home_works_DevOps28
/home/vagrant/netology/temp_test.txt
/home/vagrant/netology/test.py
vagrant@vagrant:~/netology$ python3 temp.py
Выберите репозиторий:
1. devops_test
2. test_1
3. admin_home_works_DevOps28
4. Ввести путь вручную
0. Введите для выхода
Введите номер репозитория: 0
vagrant@vagrant:~/netology$
```

------

## Задание 4

Наша команда разрабатывает несколько веб-сервисов, доступных по HTTPS. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. 

Проблема в том, что отдел, занимающийся нашей инфраструктурой, очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS-имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. 

Мы хотим написать скрипт, который: 

- опрашивает веб-сервисы; 
- получает их IP; 
- выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. 

Также должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена — оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:

```python
#!/usr/bin/env python3

import os
import socket
import json


file_path = '/home/vagrant/netology/original_hosts.txt'
servers = ['drive.google.com', 'mail.google.com', 'google.com']


def get_original_hosts(url, file_path):
    hosts_ip = {}
    if not os.path.exists(file_path):
        with open(file_path, 'w') as file:
            for f in servers:
                hosts_ip[f] = socket.gethostbyname(f)
            json.dump(hosts_ip, file)
    return hosts_ip

check_original_hosts = get_original_hosts(servers, file_path)

def get_current_hosts_ip(url):
    current_ip = {}
    for f in servers:
        current_ip[f] = socket.gethostbyname(f)
    return current_ip

current_ip = get_current_hosts_ip(servers)

for f in current_ip:
    print(f"{f} - {current_ip[f]}")


def check_out(current_ip, file_path):
    with open(file_path, 'r') as file:
         original_url = json.load(file)
    for f in original_url:
        original = original_url[f]
        current = socket.gethostbyname(current_ip[f])
        if original != current:
            print(f"[ERROR] {f} IP mismatch <{original}> <{current}>")
            original_url[f] = current
            update = True
    if update:
        with open(file_path, 'w') as file:
            json.dump(original_url, file)


check_out(current_ip, file_path)
```

### Вывод скрипта при запуске во время тестирования:

```
???
```

------

## Задание со звёздочкой* 

Это самостоятельное задание, его выполнение необязательно.
___

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в GitHub и пользуется Gitflow, то нам приходится каждый раз: 

* переносить архив с нашими изменениями с сервера на наш локальный компьютер;
* формировать новую ветку; 
* коммитить в неё изменения; 
* создавать pull request (PR); 
* и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. 

Мы хотим максимально автоматизировать всю цепочку действий. Для этого: 

1. Нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к GitHub, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым).
1. При желании можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. 
1. С директорией локального репозитория можно делать всё, что угодно. 
1. Также принимаем во внимание, что Merge Conflict у нас отсутствуют, и их точно не будет при push как в свою ветку, так и при слиянии в master. 

Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:

```python
vagrant@vagrant:~/netology$ python3 chek_socket.py
drive.google.com - 173.194.73.194
mail.google.com - 64.233.162.17
google.com - 142.250.74.110
[ERROR] drive.google.com IP mismatch <74.125.205.194> <173.194.73.194>
[ERROR] mail.google.com IP mismatch <64.233.162.83> <64.233.162.17>
```

### Вывод скрипта при запуске во время тестирования:

```
???
```

----

### Правила приёма домашнего задания

В личном кабинете отправлена ссылка на .md-файл в вашем репозитории.

-----

### Критерии оценки

Зачёт:

* выполнены все задания;
* ответы даны в развёрнутой форме;
* приложены соответствующие скриншоты и файлы проекта;
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку:

* задание выполнено частично или не выполнено вообще;
* в логике выполнения заданий есть противоречия и существенные недостатки.  
 
Обязательными являются задачи без звёздочки. Их выполнение необходимо для получения зачёта и диплома о профессиональной переподготовке.

Задачи со звёздочкой (*) являются дополнительными или задачами повышенной сложности. Они необязательные, но их выполнение поможет лучше разобраться в теме.
