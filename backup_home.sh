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
