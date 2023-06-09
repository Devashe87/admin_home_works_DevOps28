## Задание

1. На лекции вы познакомились с [node_exporter](https://github.com/prometheus/node_exporter/releases). В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой [unit-файл](https://www.freedesktop.org/software/systemd/man/systemd.service.html) для node_exporter:

    * поместите его в автозагрузку;
    * предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на `systemctl cat cron`);
    * удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
```
Ответ:
```

```
sudo mkdir /opt/node_exporter
cd /opt/node_exporter
sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
sudo tar -xzf node_exporter-1.5.0.linux-amd64.tar.gz
sudo mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/bin/

```
```
sudo nano /etc/systemd/system/node_exporter.service
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/bin/node_exporter
KillMode=process
Restart=always

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
```

```
vagrant@vagrant:/opt/node_exporter$ sudo systemctl status node_exporter
● node_exporter.service - Prometheus Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2023-05-20 18:23:07 UTC; 2min 41s ago
   Main PID: 2776 (node_exporter)
      Tasks: 7 (limit: 2271)
     Memory: 3.0M
     CGroup: /system.slice/node_exporter.service
             └─2776 /usr/bin/node_exporter

May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=thermal_zone
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=time
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=timex
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=udp_queues
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=uname
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=vmstat
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=xfs
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=node_exporter.go:117 level=info collector=zfs
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=tls_config.go:232 level=info msg="Listening on" address=[::]:9100
May 20 18:23:07 vagrant node_exporter[2776]: ts=2023-05-20T18:23:07.865Z caller=tls_config.go:235 level=info msg="TLS is disabled." http2=false address=[::]:9100
vagrant@vagrant:/opt/node_exporter$
```

2. Изучите опции node_exporter и вывод `/metrics` по умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
```
Ответ:
--collector.cpu: Включает сбор метрик процессора (CPU).
--collector.meminfo: Включает сбор метрик памяти (Memory).
--collector.diskstats: Включает сбор метрик дисковой активности (Disk).
--collector.netstat: Включает сбор метрик сетевой активности (Network).
--collector.loadavg: Включает сбор метрик загрузки системы (System Load).
```
3. Установите в свою виртуальную машину [Netdata](https://github.com/netdata/netdata). Воспользуйтесь [готовыми пакетами](https://packagecloud.io/netdata/netdata/install) для установки (`sudo apt install -y netdata`). 
   
   После успешной установки:
   
    * в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`;
    * добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`:

    ```bash
    config.vm.network "forwarded_port", guest: 19999, host: 19999
    ```

    После успешной перезагрузки в браузере на своём ПК (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata, и с комментариями, которые даны к этим метрикам.

![System Overview](https://github.com/Devashe87/admin_home_works_DevOps28/assets/91850152/596cadcb-288d-4c6f-8445-51ff84584394)

4. Можно ли по выводу `dmesg` понять, осознаёт ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
```
Ответ:
Да
vagrant@vagrant:~$ dmesg | grep 'Hypervisor detected'
[    0.000000] Hypervisor detected: KVM
```
5. Как настроен sysctl `fs.nr_open` на системе по умолчанию? Определите, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?
```
Ответ:
vagrant@vagrant:~$ sysctl fs.nr_open
fs.nr_open = 1048576
Параметр fs.nr_open определяет максимальное количество открытых файловых дескрипторов (file descriptors), которые может использовать операционная система. Файловый дескриптор — это числовой идентификатор, используемый операционной системой для представления открытых файлов, сокетов, каналов и других ресурсов ввода-вывода.
```

```
fs.nr_open также существует другой лимит, который может ограничить достижение такого числа. Это лимит ulimit (User Limit), который устанавливается для каждого пользователя в системе.
ulimit

vagrant@vagrant:~$ ulimit -Sn
1024
vagrant@vagrant:~$ ulimit -Hn
1048576
```

6. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в этом задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т. д.
```
Ответ:
root@vagrant:~# ps -e |grep sleep
   1860 pts/1    00:00:00 sleep
root@vagrant:~# nsenter --target 1860 --pid --mount
root@vagrant:/# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.5 102644 11476 ?        Ss   19:20   0:01 /sbin/init
```

7. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время всё будет плохо, после чего (спустя минуты) — ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации.  
Как настроен этот механизм по умолчанию, и как изменить число процессов, которое можно создать в сессии?
```
Ответ:
Это fork bomb что является вредоносной командой, способной вызвать серьезные проблемы в системе, такие как перегрузка процессора и затруднение доступа к системным ресурсам.
Является рекурсивной конструкцией, которая создает дочерние процессы до исчерпания системных ресурсов. В результате система может стать неотзывчивой
```
```
Стабилизация системы:
[  367.403425] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-1.scope
```
```
По умолчанию настроено:
root@vagrant:~# ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 7572
max locked memory       (kbytes, -l) 65536
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 7572
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
```

```
Изменение
Изменение максимального количества открытых файлов (file descriptors):
ulimit -n <количество> устанавливает максимальное количество открытых

Изменение максимального количества процессов:
ulimit -u <количество> устанавливает максимальное количество процессов.

Изменение максимального количества размера стека:
ulimit -s <размер> устанавливает максимальный размер стека для каждого процесса.

Для изменения на постоянной основе необходимо отредактировть файл:
/etc/security/limits.conf
```
