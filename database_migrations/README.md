# 🗄️ Sistema AUTOMÁTICO de Migrações do Banco de Dados

Sistema 100% automatizado para aplicar atualizações do esquema do banco a partir do arquivo `.mwb` do MySQL Workbench.

---

## 🚀 Uso (Super Simples!)

### Quando houver mudanças no modelo do banco:

```bash
# 1. Atualize o modelo ER_GComp.mwb no MySQL Workbench
# 2. Salve o arquivo (Ctrl+S)

# 3. Execute o container de migração
docker compose --profile migrations up gcomp-migrations
```

**Pronto!** O sistema faz tudo sozinho:
- ✅ Lê o arquivo `.mwb` automaticamente
- ✅ Detecta mudanças no esquema
- ✅ Cria novas tabelas
- ✅ Adiciona novas colunas
- ✅ Aplica no banco Docker
- ✅ Salva histórico
- ✅ Para sozinho quando terminar

---

## 📁 Arquivos do Sistema

**✅ USADOS:**
- `ER_GComp.mwb` - Modelo do banco (você edita)
- `auto_migrate.py` - Script automático principal
- `mwb_parser.py` - Parser de arquivos .mwb
- `.gitignore` - Controle de versão

**📂 AUTO-GERADOS:**
- `.migration_version` - Hash da versão atual
- `history/` - Logs de migrações aplicadas

---

## 🔍 Ver Logs

```bash
# Logs da migração
docker logs gcomp-migrations

# Histórico
ls database_migrations/history/
```

---

## 🔧 Comandos Úteis

### Forçar reaplicação
```bash
rm database_migrations/.migration_version
docker compose --profile migrations up gcomp-migrations
```

### Rebuild container
```bash
docker compose build gcomp-migrations
docker compose --profile migrations up gcomp-migrations
```

---

## 🐛 Problemas Comuns

### Container não roda

Certifique-se que o banco está rodando:
```bash
docker compose up -d gcomp-db
docker compose up gcomp-migrations
```

### Ver erros detalhados
```bash
docker logs gcomp-migrations
```

---

## ⚠️ Mudanças Complexas

Para remoções ou migrações de dados complexas, crie script SQL manual:

```bash
# 1. Crie arquivo SQL
echo "ALTER TABLE foo DROP COLUMN bar;" > database_migrations/manual/fix.sql

# 2. Aplique manualmente
docker cp database_migrations/manual/fix.sql gcomp-db:/tmp/
docker exec -i gcomp-db mysql -u gcomp -pgcomp123 gestorgcomp < /tmp/fix.sql
```

---

## 📚 Fluxo de Trabalho

**Desenvolvedor:**
1. Edita `ER_GComp.mwb` → Salva
2. `docker compose up gcomp-migrations`
3. Testa aplicação
4. Comita `.mwb` no Git

**Testador:**
1. Baixa código atualizado
2. `docker compose up gcomp-migrations`
3. Testa features

---

## 🔄 Alternativa: Recrear Tudo

Se houver problemas:
```bash
docker compose down -v
docker compose up -d --build
```

---

**Última atualização**: 12/11/2025  
**Sistema**: 100% Automático 🚀
