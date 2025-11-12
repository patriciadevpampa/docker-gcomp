#!/bin/sh
cat > /app/src/config/database.json <<JSON
{
    "host": "${DB_HOST:-localhost}",
    "user": "${DB_USER:-root}",
    "pass": "${DB_PASSWORD:-}",
    "nome_banco": "${DB_NAME:-gestorgcomp}"
}
JSON
exec node app.js --host 0.0.0.0
