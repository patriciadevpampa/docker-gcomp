#!/bin/bash
# Script para aplicar migrações SQL manuais

echo "🔄 Aplicando migrações SQL manuais..."

# Aguarda banco
until mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD $DB_NAME -e "SELECT 1" > /dev/null 2>&1; do
    sleep 1
done

echo "✅ Banco disponível"

# Aplica cada arquivo .sql em ordem
for sql_file in /migrations/manual/*.sql; do
    if [ -f "$sql_file" ]; then
        echo "📝 Aplicando: $(basename $sql_file)"
        mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD $DB_NAME < "$sql_file"
        if [ $? -eq 0 ]; then
            echo "   ✅ OK"
        else
            echo "   ❌ ERRO"
        fi
    fi
done

echo "✅ Migrações manuais concluídas"
