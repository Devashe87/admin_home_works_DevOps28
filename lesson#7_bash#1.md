------

## Задание 1

Есть скрипт:

```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c, d, e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | a+b  | Переменной c присвоено значение строка "a+b" |
| `d`  | 1+2  | Переменной d присвоено заначение 1+2 т.к. переменным a и b не присвоено значение целочисленного числа |
| `e`  | 3  | Пременой e присвоено значение 3 т.к. произошло преобразование в целочисленное число в результате конструкции $(()) которая приобразоывает все переменные внутри в целочисленные|

----

## Задание 2

На нашем локальном сервере упал сервис, и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным. После чего скрипт должен завершиться. 

В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на жёстком диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:

```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:

```bash
while ((1==1)) 	#Нехватало закрывающей скобки
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date > curl.log
	else	#Добавил условие выхода из цикла
		break
	fi
done
```

---

## Задание 3

Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:

```bash
vagrant@vagrant:~$ ip_adresses=(192.168.0.1 173.194.222.113 87.250.250.242)
vagrant@vagrant:~$ port=80
vagrant@vagrant:~$ log_file=TEST3.log
vagrant@vagrant:~$ num_retries=5
vagrant@vagrant:~$ while ((1==1))
> do
>     for ip in ${ip_adresses[@]}
>     do
>         if nc -z -w1 $ip $port
>         then
>             result="$ip:$port - доступен"
>         else
>             result="$ip:$port - недоступен"
>         fi
>         echo $result >> $log_file
>     done
>     num_retries=$((num_retries - 1))
>     if [ $num_retries -eq 0 ]
>     then
>         break
>     fi
> done
vagrant@vagrant:~$ cat $log_file
192.168.0.1:80 - недоступен
173.194.222.113:80 - доступен
87.250.250.242:80 - доступен
192.168.0.1:80 - недоступен
173.194.222.113:80 - доступен
87.250.250.242:80 - доступен
192.168.0.1:80 - недоступен
173.194.222.113:80 - доступен
87.250.250.242:80 - доступен
192.168.0.1:80 - недоступен
173.194.222.113:80 - доступен
87.250.250.242:80 - доступен
192.168.0.1:80 - недоступен
173.194.222.113:80 - доступен
87.250.250.242:80 - доступен
```

---
## Задание 4

Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен — IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:

```bash
vagrant@vagrant:~$ ip_adresses=(192.168.0.1 173.194.222.113 87.250.250.242)
vagrant@vagrant:~$ port=80
vagrant@vagrant:~$ log_file=TEST.log
vagrant@vagrant:~$ log_error=ERROR.log
vagrant@vagrant:~$ num_retries=5
vagrant@vagrant:~$ while ((1==1))
> do
>     for ip in ${ip_adresses[@]}
>     do
>         if nc -z -w1 $ip $port
>         then
>             result="$ip:$port - доступен"
>         else
>             result="$ip:$port - недоступен"
>             echo $result >> $log_error
>             exit 0
>         fi
>         echo $result >> $log_file
>     done
> done

```

---

## Задание со звёздочкой* 

Это самостоятельное задание, его выполнение необязательно.
____

Мы хотим, чтобы у нас были красивые сообщения для коммитов в репозиторий. Для этого нужно написать локальный хук для Git, который будет проверять, что сообщение в коммите содержит код текущего задания в квадратных скобках, и количество символов в сообщении не превышает 30. Пример сообщения: \[04-script-01-bash\] сломал хук.

### Ваш скрипт:

```bash
???
```

----

### Правила приёма домашнего задания

В личном кабинете отправлена ссылка на .md-файл в вашем репозитории.


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