## Задание

**Шаг 1.** Работа c HTTP через telnet.

- Подключитесь утилитой telnet к сайту stackoverflow.com:

`telnet stackoverflow.com 80`
 
- Отправьте HTTP-запрос:

```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
*В ответе укажите полученный HTTP-код и поясните, что он означает.*

```
Ответ:
403 Доступ запрещён
или если ещё раз повторить команду то
500 Domain Not Found (домен не найден)
```
```
vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.65.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 403 Forbidden
Connection: close
Content-Length: 1918
Server: Varnish
Retry-After: 0
Content-Type: text/html
Accept-Ranges: bytes
Date: Thu, 25 May 2023 12:17:27 GMT
Via: 1.1 varnish
X-Served-By: cache-hel1410023-HEL
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1685017048.756141,VS0,VE1
X-DNS-Prefetch-Control: off
```
```
vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.129.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0

HTTP/1.1 500 Domain Not Found
Connection: close
Content-Length: 223
```

**Шаг 2.** Повторите задание 1 в браузере, используя консоль разработчика F12:

 - откройте вкладку `Network`;
 - отправьте запрос [http://stackoverflow.com](http://stackoverflow.com);
 - найдите первый ответ HTTP-сервера, откройте вкладку `Headers`;
 - укажите в ответе полученный HTTP-код;
 - проверьте время загрузки страницы и определите, какой запрос обрабатывался дольше всего;
 - приложите скриншот консоли браузера в ответ.
```
Ответ:
307 Внутреннее перенаправление
```
![Get_307_Redirect](https://github.com/Devashe87/admin_home_works_DevOps28/assets/91850152/1669a911-dc5a-4e25-83d0-5d5f0854ca9e)
```
проверьте время загрузки страницы и определите, какой запрос обрабатывался дольше всего;
```
![306+ms](https://github.com/Devashe87/admin_home_works_DevOps28/assets/91850152/0f415eba-c8db-449d-bf2a-f9944c5b9c70)

**Шаг 3.** Какой IP-адрес у вас в интернете?
```
Ответ:
vagrant@vagrant:~$ dig @resolver4.opendns.com myip.opendns.com +short
85.185.184.185
```

**Шаг 4.** Какому провайдеру принадлежит ваш IP-адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`.
```
Ответ:
vagrant@vagrant:~$ whois -h whois.radb.net 94.159.91.198
route:          85.185.184.0/22
descr:          "NetCom-R" LLC
origin:         AS49531
mnt-by:         MNT-NETCOM-R
created:        2021-11-16T18:17:40Z
last-modified:  2021-11-16T18:17:40Z
source:         RIPE
```

**Шаг 5.** Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`.
```
Ответ:
vagrant@vagrant:~$ traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.0.2.2 [*]  0.129 ms  0.111 ms  0.102 ms
 2  10.0.2.2 [*]  1.796 ms  1.785 ms  1.774 ms

Понимаю что этот ответ не соответсвуюет ожиданию.
Имею представления что должно быть.
Но в причинах почему вывод такой, пока что нет времени разобраться
```

**Шаг 6.** Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка — delay?
```
Ответ:
9. AS15169
vagrant@vagrant:~$ mtr 8.8.8.8 -znrc 1
Start: 2023-05-25T13:53:54+0000
HOST: vagrant                     Loss%   Snt   Last   Avg  Best  Wrst StDev
  1. AS???    10.0.2.2             0.0%     1    0.3   0.3   0.3   0.3   0.0
  2. AS???    192.168.8.1          0.0%     1    1.3   1.3   1.3   1.3   0.0
  3. AS???    192.168.1.1          0.0%     1    1.4   1.4   1.4   1.4   0.0
  4. AS49531  94.159.91.197        0.0%     1    1.5   1.5   1.5   1.5   0.0
  5. AS49531  93.92.32.145         0.0%     1    2.3   2.3   2.3   2.3   0.0
  6. AS29076  31.28.19.89          0.0%     1    2.2   2.2   2.2   2.2   0.0
  7. AS15169  108.170.250.34       0.0%     1    3.3   3.3   3.3   3.3   0.0
  8. AS15169  172.253.66.116       0.0%     1   21.0  21.0  21.0  21.0   0.0
  9. AS15169  172.253.66.108       0.0%     1   34.6  34.6  34.6  34.6   0.0
 10. AS15169  209.85.251.63        0.0%     1   20.2  20.2  20.2  20.2   0.0
 11. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 12. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 13. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 14. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 15. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 16. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 17. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 18. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 19. AS???    ???                 100.0     1    0.0   0.0   0.0   0.0   0.0
 20. AS15169  8.8.8.8              0.0%     1   19.7  19.7  19.7  19.7   0.0
```

**Шаг 7.** Какие DNS-сервера отвечают за доменное имя dns.google? Какие A-записи? Воспользуйтесь утилитой `dig`.
```
Ответ:
vagrant@vagrant:~$ dig dns.google NS +noall +answer
dns.google.             6753    IN      NS      ns2.zdns.google.
dns.google.             6753    IN      NS      ns4.zdns.google.
dns.google.             6753    IN      NS      ns1.zdns.google.
dns.google.             6753    IN      NS      ns3.zdns.google.
vagrant@vagrant:~$ dig dns.google A +noall +answer
dns.google.             5       IN      A       8.8.4.4
dns.google.             5       IN      A       8.8.8.8
```

**Шаг 8.** Проверьте PTR записи для IP-адресов из задания 7. Какое доменное имя привязано к IP? Воспользуйтесь утилитой `dig`.
```
Ответ:
vagrant@vagrant:~$ dig -x 8.8.8.8  +noall +answer
8.8.8.8.in-addr.arpa.   834     IN      PTR     dns.google.
vagrant@vagrant:~$ dig -x 8.8.4.4  +noall +answer
4.4.8.8.in-addr.arpa.   20111   IN      PTR     dns.google.
```

*В качестве ответов на вопросы приложите лог выполнения команд в консоли или скриншот полученных результатов.*

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
