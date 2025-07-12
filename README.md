# Задание 1

1. Составьте команду rsync, которая позволяет создавать зеркальную копию домашней директории пользователя в директорию /tmp/backup
2. Необходимо исключить из синхронизации все директории, начинающиеся с точки (скрытые)
3. Необходимо сделать так, чтобы rsync подсчитывал хэш-суммы для всех файлов, даже если их время модификации и размер идентичны в источнике и приемнике.
4. На проверку направить скриншот с командой и результатом ее выполнения

# Решение 1

```
rsync -a --checksum --verbose --delete --progress --exclude '.*' /home/vboxuser/ /tmp/backup
```

![alt text](https://github.com/llenar/-_-/blob/main/screen/Screenshot_1.png)

![alt text](https://github.com/llenar/-_-/blob/main/screen/Screenshot_2.png)

![alt text](https://github.com/llenar/-_-/blob/main/screen/Screenshot_3.png)
