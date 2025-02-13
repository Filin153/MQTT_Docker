#!/bin/bash

CONFIG_PATH="./mosquitto/config"
PASSWD_FILE="$CONFIG_PATH/passwd"

read -p "Введите имя пользователя для удаления: " USERNAME

if [ ! -f "$PASSWD_FILE" ]; then
    echo "Ошибка: файл паролей не найден!"
    exit 1
fi

echo "Удаляем пользователя..."
docker run --rm -v $(pwd)/$CONFIG_PATH:/mosquitto/config eclipse-mosquitto mosquitto_passwd -D /mosquitto/config/passwd "$USERNAME"

echo "Перезапуск Mosquitto..."
docker-compose restart
echo "Пользователь $USERNAME удален!"