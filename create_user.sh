#!/bin/bash

CONFIG_PATH="./mosquitto/config"
PASSWD_FILE="$CONFIG_PATH/passwd"

read -p "Введите имя пользователя: " USERNAME
read -s -p "Введите пароль: " PASSWORD
echo

# Проверяем, существует ли файл паролей
if [ ! -f "$PASSWD_FILE" ]; then
    echo "Файл паролей не найден. Создаем новый..."
    docker run --rm -v $(pwd)/$CONFIG_PATH:/mosquitto/config eclipse-mosquitto mosquitto_passwd -c /mosquitto/config/passwd "$USERNAME"
else
    echo "Добавляем пользователя..."
    echo "$PASSWORD" | docker run --rm -i -v $(pwd)/$CONFIG_PATH:/mosquitto/config eclipse-mosquitto sh -c "mosquitto_passwd -b /mosquitto/config/passwd $USERNAME $PASSWORD"
fi

echo "Перезапуск Mosquitto..."
docker-compose restart
echo "Пользователь $USERNAME успешно создан!"