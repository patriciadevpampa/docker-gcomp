#!/bin/bash
set -e

# Inicia MariaDB em background
echo "Iniciando MariaDB..."
mysqld_safe --datadir=/var/lib/mysql &

# Espera MariaDB iniciar
until mysqladmin ping >/dev/null 2>&1; do
  echo "Aguardando MariaDB iniciar..."
  sleep 2
done

# Cria banco e importa dump
echo "Criando banco e importando dump..."
mysql -e "CREATE DATABASE IF NOT EXISTS \`servidorgerencia_gcomp\`;"
mysql servidorgerencia_gcomp < /docker-entrypoint-initdb.d/dump.sql

# Inicia WildFly
echo "Iniciando WildFly..."
/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -c standalone.xml
