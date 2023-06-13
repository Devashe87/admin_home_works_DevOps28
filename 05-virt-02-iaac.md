# Домашнее задание к занятию 2. «Применение принципов IaaC в работе с виртуальными машинами»

## Как сдавать задания

Обязательны к выполнению задачи без звёздочки. Их нужно выполнить, чтобы получить зачёт и диплом о профессиональной переподготовке.

Задачи со звёздочкой (*) — дополнительные задачи и/или задачи повышенной сложности. Их выполнять не обязательно, но они помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в GitHub-репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---


## Важно

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.

Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md).

---

## Задача 1

- Опишите основные преимущества применения на практике IaaC-паттернов.
```
Ответ:
Значительно ускоряет предоставление инфраструктуры для тестирования, разработки и маштабирования
Идемпотентность
```
- Какой из принципов IaaC является основополагающим?
```
Декларативность
Декларативность означает, что вместо того, чтобы описывать каждый шаг и действие, необходимое для развертывания и конфигурации инфраструктуры
можно описываете желаемое состояние инфраструктуры в виде кода. Система управления инфраструктурой, такая как Terraform берет на себя 
ответственность за приведение текущего состояния инфраструктуры в соответствие с описанным состоянием.
```

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
```
Использование SSH инфраструктуры без установки дополнительного окружения, а также наличие большого количества модулей.
Не требует установки агентов на целевые хосты
```
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?
```
Pull -  Узлы инфраструктуры запрашивают конфигурацию по необходимости, что позволяет им обновляться в своём темпе и избегать возможных конфликтов.
```
## Задача 3

Установите на личный компьютер:

- [VirtualBox](https://www.virtualbox.org/),
- [Vagrant](https://github.com/netology-code/devops-materials),
- [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md),
- Ansible.
```
devashe@Devashe87 vagrant % vagrant --version
Vagrant 2.3.6
devashe@Devashe87 vagrant % ansible --version
ansible [core 2.15.0]
  config file = /Users/devashe/netology/Vagrant/ansible.cfg
  configured module search path = ['/Users/devashe/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /Users/devashe/Library/Python/3.10/lib/python/site-packages/ansible
  ansible collection location = /Users/devashe/.ansible/collections:/usr/share/ansible/collections
  executable location = /Users/devashe/Library/Python/3.10/bin/ansible
  python version = 3.10.11 (v3.10.11:7d4cc5aa85, Apr  4 2023, 19:05:19) [Clang 13.0.0 (clang-1300.0.29.30)] (/usr/local/bin/python3)
  jinja version = 3.1.2
  libyaml = True
devashe@Devashe87 vagrant % terraform -version
Terraform v1.4.6
on darwin_amd64

Your version of Terraform is out of date! The latest version
is 1.5.0. You can update by downloading from https://www.terraform.io/downloads.html
```
*Приложите вывод команд установленных версий каждой из программ, оформленный в Markdown.*

## Задача 4 

Воспроизведите практическую часть лекции самостоятельно.

- Создайте виртуальную машину.
- Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды
```
docker ps,
vagrant@server1:~$ docker version
Client: Docker Engine - Community
 Version:           24.0.2
 API version:       1.43
 Go version:        go1.20.4
 Git commit:        cb74dfc
 Built:             Thu May 25 21:52:22 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          24.0.2
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.4
  Git commit:       659604f
  Built:            Thu May 25 21:52:22 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.21
  GitCommit:        3dce8eb055cbb6872793272b4f20ed16117344f8
 runc:
  Version:          1.1.7
  GitCommit:        v1.1.7-0-g860f061
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```
Vagrantfile из лекции и код ansible находятся в [папке](https://github.com/netology-code/virt-homeworks/tree/virt-11/05-virt-02-iaac/src).

Примечание. Если Vagrant выдаёт ошибку:
```
URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
Error: The requested URL returned error: 404:
```

выполните следующие действия:

1. Скачайте с [сайта](https://app.vagrantup.com/bento/boxes/ubuntu-20.04) файл-образ "bento/ubuntu-20.04".
2. Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>".
