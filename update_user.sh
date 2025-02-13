#!/bin/bash

CONFIG_PATH="./mosquitto/config"
PASSWD_FILE="$CONFIG_PATH/passwd"

read -p "Введите имя пользователя: " USERNAME
read -s -p "Введите новый пароль: " PASSWORD
echo

if [ ! -f "$PASSWD_FILE" ]; then
    echo "Ошибка: файл паролей не найден!"
    exit 1
fi

echo "Обновляем пароль пользователя..."
echo "$PASSWORD" | docker run --rm -i -v $(pwd)/$CONFIG_PATH:/mosquitto/config eclipse-mosquitto sh -c "mosquitto_passwd -b /mosquitto/config/passwd $USERNAME $PASSWORD"

echo "Перезапуск Mosquitto..."
docker-compose restart
echo "Пароль для $USERNAME обновлен!"