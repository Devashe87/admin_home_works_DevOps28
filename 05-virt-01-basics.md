
# Домашнее задание к занятию 1.  «Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения»


## Как сдавать задания

Обязательны к выполнению задачи без звёздочки. Их нужно выполнить, чтобы получить зачёт и диплом о профессиональной переподготовке.

Задачи со звёздочкой (*) — это дополнительные задачи и/или задачи повышенной сложности. Их выполнять не обязательно, но они помогут вам глубже понять тему.

Домашнее задание выполняйте в файле readme.md в GitHub-репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Важно

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.

Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md).

---

## Задача 1

Опишите кратко, в чём основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.
```
Ответ:
Полная или аппаратная - не требуется хостовая OS
Каждая ВМ работает как отдельный гостевой операционный системой, несвязанный с хост-системой

Паравиртуализации - разворачивается на хостовой OS
Гостевые операционные системы осведомлены о своем виртуальном окружении и взаимодействуют с гипервизором

Виртуальная на основе OS - В этом типе виртуализации вместо гипервизора используется операционная система хост-системы
гостевые ОС в контейнерах должны быть совместимы с ядром хост-системы.
```
## Задача 2

Выберите один из вариантов использования организации физических серверов в зависимости от условий использования.

Организация серверов:

- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:

- высоконагруженная база данных, чувствительная к отказу;
```
высоконагруженная база данных, чувствительная к отказу;
 - физические сервера - нет конкуренции с другими гостевыми OS за ресурсы
```
- различные web-приложения;
```
различные web-приложения;
 - виртуализация уровня ОС. - можно быстро разворачивтать в контейнерах, легковесные
```
- Windows-системы для использования бухгалтерским отделом;
```
Windows-системы для использования бухгалтерским отделом;
 - паравиртуализация - Более отказоустойчивая (так же подойдёт Полная или аппаратная если использовать
hyper-v core, что требует более высокого порога входа для инженера, ещё необходимо учитвать кол-во гостевых OS
для оценки стоимости необходимых лицензий гостевых OS)
```
- системы, выполняющие высокопроизводительные расчёты на GPU.
```
системы, выполняющие высокопроизводительные расчёты на GPU.
 - физические сервера - нет конкуренции с другими гостевыми OS за ресурсы, возможна более гибкая настройка
```
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based-инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
```
Hyper-v core, VMware vSphere. VMware vSphere предоставляет широкий набор функциональных возможностей и инструментов, 
которые могут удовлетворить требования данного сценария.
Hyper-V Core так-же поддерживает виртуализацию как Linux, так и Windows, предоставляет функциональность балансировки нагрузки, репликации данных и создания резервных копий
```
2. Требуется наиболее производительное бесплатное open source-решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
```
KVM - обладает высокой производительностью и стабильностью, поддерживает установку из ISO и шаблонов
```
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows-инфраструктуры.
```
Hyper-V Core - бесплатный максимально совместимый с Windows
```
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.
```
VirtualBox - просто в установке и эксплуатации, бесплатный
```
## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.
```
Риски
 - Повышенные риски отазоустойчивости
 - Сложность администрирования
 - Возможны проблемы совместимости
Минимизация рисков
 - Автоматизация и оркестрация
Если бы был выбор
 - нет, не создал бы, риски не оправдывают средства, если есть жёская необходимость в разных гипервизорах, лучше иметь 2 хоста.
```
