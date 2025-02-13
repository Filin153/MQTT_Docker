#!/bin/bash

CONFIG_PATH="./mosquitto/config"
PASSWD_FILE="$CONFIG_PATH/passwd"

if [ ! -f "$PASSWD_FILE" ]; then
    echo "Ошибка: файл паролей не найден!"
    exit 1
fi

echo "Список пользователей:"
cut -d ':' -f 1 "$PASSWD_FILE"