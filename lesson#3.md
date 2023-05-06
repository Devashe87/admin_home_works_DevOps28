------

## Задание

1. Какой системный вызов делает команда `cd`? 

    В прошлом ДЗ вы выяснили, что `cd` не является самостоятельной  программой. Это `shell builtin`, поэтому запустить `strace` непосредственно на `cd` не получится. Вы можете запустить `strace` на `/bin/bash -c 'cd /tmp'`. В этом случае увидите полный список системных вызовов, которые делает сам `bash` при старте. 

    Вам нужно найти тот единственный, который относится именно к `cd`. Обратите внимание, что `strace` выдаёт результат своей работы в поток stderr, а не в stdout.
```
Ответ:
vagrant@vagrant:~$ strace bash -c 'cd /tmp/'
execve("/usr/bin/bash", ["bash", "-c", "cd /tmp/"], 0x7ffe28380910 /* 23 vars */) = 0
brk(NULL)                               = 0x561bc3273000

stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")
```

2. Попробуйте использовать команду `file` на объекты разных типов в файловой системе. Например:

    ```bash
    vagrant@netology1:~$ file /dev/tty
    /dev/tty: character special (5/0)
    vagrant@netology1:~$ file /dev/sda
    /dev/sda: block special (8/0)
    vagrant@netology1:~$ file /bin/bash
    /bin/bash: ELF 64-bit LSB shared object, x86-64
    ```
    
    Используя `strace`, выясните, где находится база данных `file`, на основании которой она делает свои догадки.
```
Ответ:
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
```

3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удалён (deleted в lsof), но сказать сигналом приложению переоткрыть файлы или просто перезапустить приложение возможности нет. Так как приложение продолжает писать в удалённый файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков, предложите способ обнуления открытого удалённого файла, чтобы освободить место на файловой системе.
```
Ответ:
 - По pid процесса, найти номер файлового дескриптора.
 - В дескриптор отправить пустую строку, например, echo '' > /путь/до/дескриптора/8
```

4. Занимают ли зомби-процессы ресурсы в ОС (CPU, RAM, IO)?
```
Ответ:
Зомби-процессы в операционной системе не занимают никаких ресурсов, кроме некоторого объема памяти для хранения записей о завершении процесса в таблице процессов.
```
5. В IO Visor BCC есть утилита `opensnoop`:

    ```bash
    root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
    /usr/sbin/opensnoop-bpfcc
    ```
    
    На какие файлы вы увидели вызовы группы `open` за первую секунду работы утилиты? Воспользуйтесь пакетом `bpfcc-tools` для Ubuntu 20.04. Дополнительные сведения по установке [по ссылке](https://github.com/iovisor/bcc/blob/master/INSTALL.md).
```
Ответ:
vagrant@vagrant:~$ sudo /usr/sbin/opensnoop-bpfcc
PID    COMM               FD ERR PATH
931    VBoxService         5   0 /var/run/utmp
684    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
684    dbus-daemon        21   0 /usr/share/dbus-1/system-services
684    dbus-daemon        -1   2 /lib/dbus-1/system-services
684    dbus-daemon        21   0 /var/lib/snapd/dbus-1/system-services/
1      systemd            12   0 /proc/666/cgroup
431    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
431    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
931    VBoxService         5   0 /var/run/utmp

```
6. Какой системный вызов использует `uname -a`? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в `/proc` и где можно узнать версию ядра и релиз ОС.
```
Ответ:
 - Команда uname -a использует системный вызов uname(), который возвращает информацию о системе в структуре utsname, включая название операционной системы, версию ядра, имя хоста и другую информацию.
 - Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}
```
7. Чем отличается последовательность команд через `;` и через `&&` в bash? Например:

    ```bash
    root@netology1:~# test -d /tmp/some_dir; echo Hi
    Hi
    root@netology1:~# test -d /tmp/some_dir && echo Hi
    root@netology1:~#
    ```
    
    Есть ли смысл использовать в bash `&&`, если применить `set -e`?
```
Ответ:
 - ";" позволяет выполнить несколько команд независимо от их результатов, тогда как использование "&&" гарантирует выполнение только при успешном завершении предыдущей команды.
 - не имеет смысла т.к. "set -e" завершит сессию в случае безуспешного выполнения команды.
```
8. Из каких опций состоит режим bash `set -euxo pipefail`, и почему его хорошо было бы использовать в сценариях?
```
Ответ:
"e" - остановить выполнение сценария, если какая-либо команда завершится с ненулевым статусом (например, ошибка в сценарии)
"u" - остановить выполнение сценария, если используется неустановленная переменная
"x" - выводить на экран все команды, которые будут выполняться в сценарии (включая значения переменных и другую отладочную информацию)
"o pipefail" - остановить выполнение сценария, если любая команда в конвейере завершится с ненулевым статусом.
Использование режима set -euxo pipefail в сценариях помогает быстро обнаруживать и исправлять ошибки в сценариях, что может значительно ускорить разработку и поддержку сценариев.
```
9. Используя `-o stat` для `ps`, определите, какой наиболее часто встречающийся статус у процессов в системе. В `man ps` изучите (`/PROCESS STATE CODES`), что значат дополнительные к основной заглавной букве статуса процессов. Его можно не учитывать при расчёте (считать S, Ss или Ssl равнозначными).
```
Ответ:
Самый частый
vagrant@vagrant:~$ ps -Ao stat  | sort | uniq -c | sort -nr
     51 I<
     42 S
     16 Ss
      9 Ssl
      7 I
      6 S<
      4 Ss+
      3 S+
      2 SN
      2 Sl
      1 STAT
      1 S<s
      1 SLsl
      1 R+
_________
PROCESS STATE CODES
       Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process:

               D    uninterruptible sleep (usually IO)
               I    Idle kernel thread
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped by job control signal
               t    stopped by debugger during the tracing
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by its parent

       For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group

```
----
