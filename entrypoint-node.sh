#!/bin/sh
cat > /app/src/config/database.json <<JSON
{
    "host": "${DB_HOST:-localhost}",
    "user": "${DB_USER:-root}",
    "pass": "${DB_PASSWORD:-}",
    "nome_banco": "${DB_NAME:-servidorgerencia_gcomp}"
}
JSON
exec node app.js --host 0.0.0.0
