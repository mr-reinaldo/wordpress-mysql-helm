#!/usr/bin/env bash

kubectl create namespace virtualizacao &>/dev/null

if [ $? -eq 0 ]; then
    echo "[✓] Namespace criado."
else
    echo "[✗] Namespace já existe."
fi

# Uninstall wordpress
helm uninstall wordpress --namespace virtualizacao &>/dev/null

if [ $? -eq 0 ]; then
    echo "[✓] Wordpress deletado."
else
    echo "[✗] Wordpress não encontrado."
fi

# Uninstall mysql
helm uninstall mysql --namespace virtualizacao &>/dev/null

if [ $? -eq 0 ]; then
    echo "[✓] Mysql deletado."
else
    echo "[✗] Mysql não encontrado."
fi

# Install mysql
helm install mysql -f wordpress/values-mysql.yaml bitnami/mysql --version '9.15.0' --namespace virtualizacao &> mysql.log

if [ $? -eq 0 ]; then
    echo "[✓] Mysql instalado."
else
    echo "[✗] Mysql não instalado."
fi

helm install wordpress -f wordpress/values-wordpress.yaml bitnami/wordpress --version '19.0.4' --namespace virtualizacao &> wordpress.log

if [ $? -eq 0 ]; then
    echo "[✓] Wordpress instalado."
else
    echo "[✗] Wordpress não instalado."
fi
