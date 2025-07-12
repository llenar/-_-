# Задание 1

1. Составьте команду rsync, которая позволяет создавать зеркальную копию домашней директории пользователя в директорию /tmp/backup
2. Необходимо исключить из синхронизации все директории, начинающиеся с точки (скрытые)
3. Необходимо сделать так, чтобы rsync подсчитывал хэш-суммы для всех файлов, даже если их время модификации и размер идентичны в источнике и приемнике.
4. На проверку направить скриншот с командой и результатом ее выполнения

# Решение 1

```
rsync -a --checksum --verbose --delete --progress --exclude '.*' /home/vboxuser/ /tmp/backup
```

![alt text](https://github.com/llenar/-_-/blob/main/screen/Screen_1.png)

![alt text](https://github.com/llenar/-_-/blob/main/screen/Screen_2.png)

![alt text](https://github.com/llenar/-_-/blob/main/screen/Screen_3.png)


# Задание 2

1. Написать скрипт и настроить задачу на регулярное резервное копирование домашней директории пользователя с помощью rsync и cron.
2. Резервная копия должна быть полностью зеркальной
3. Резервная копия должна создаваться раз в день, в системном логе должна появляться запись об успешном или неуспешном выполнении операции
4. Резервная копия размещается локально, в директории /tmp/backup
5. На проверку направить файл crontab и скриншот с результатом работы утилиты.

# Решение 2

https://github.com/llenar/-_-/blob/main/backup_home.sh
```
#!/bin/bash

# Переменные
SOURCE="$HOME/"
DESTINATION="/tmp/backup/$(date +%Y-%m-%d)/"
LOGFILE="/var/log/backup_home.log"

# Создаем директорию назначения, если не существует
mkdir -p "$DESTINATION"

# Выполняем резервное копирование с опцией --delete для зеркальности
rsync -a --delete "$SOURCE" "$DESTINATION" >> "$LOGFILE" 2>&1

# Проверка результата выполнения rsync
if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Резервное копирование успешно выполнено" >> "$LOGFILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Ошибка при выполнении резервного копирования" >> "$LOGFILE"
fi

```

https://github.com/llenar/-_-/blob/main/crontab
![alt text](https://github.com/llenar/-_-/blob/main/screen/2/Screen_1.png)

```
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
0 10 * * 1 /usr/local/bin/backup_home.sh /home/vboxuser/ /tmp/backup
```


