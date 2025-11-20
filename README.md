# 🐳 GComp - Ambiente Docker

Ambiente Docker completo para o sistema GComp com banco de dados, backends (Java e Node.js) e frontend.

---

## 📋 Pré-requisitos

- **Docker Desktop** instalado e rodando
- **Git** (para clone dos repositórios durante o build)
- **8GB de RAM** livres (recomendado)
- **Portas disponíveis**: 3000, 3307, 8080, 8081

---

## 🚀 Primeira Execução (Build Completo)

### 1. Configure o arquivo `.env`

Certifique-se de que o arquivo `.env` existe com o token do GitHub:

```env
GIT_TOKEN=seu_token_aqui
BRANCH_JAVA_BACKEND=WO
BRANCH_JAVA_SISTEMA=wo-patricia-config
BRANCH_NODE=WO
URL=http://gcomp-backend-java:8080/service/
URL_NODE=http://gcomp-backend-node:3003/api
ENVIRONMENT=DOCKER
URL_LOCAL=http://localhost:8080/wsgcomp/service/
URL_NODE_LOCAL=http://localhost:3000/api/
URL_PROD=https://api.java.servidor.gerenciadorcompeticoes.com.br/service/
URL_NODE_PROD=https://api.gerenciadorcompeticoes.com.br/api/
```

> ⚠️ **Importante**: Substitua `seu_token_aqui` por um token válido do GitHub com acesso aos repositórios privados.

### 2. Prepare o dump do banco de dados

Certifique-se de que existe um arquivo de dump SQL em:
```
dump/dump_temp.sql.data
```

### 3. Execute o build e inicialização

```bash
docker compose up -d --build
```

**O que acontece:**
- 📦 Clona os repositórios do GitHub (Java Backend, Java Sistema, Node Backend)
- 🔨 Compila o código Java com Maven
- 🏗️ Constrói as imagens Docker personalizadas
- 🗄️ Importa o dump do banco de dados (pode demorar ~5min)
- ⚙️ Configura datasources e conexões
- 🚀 Inicia todos os containers

**Tempo estimado**: 10-15 minutos na primeira vez

---

## ⚡ Uso Diário (Sem Build)

Quando os containers já foram buildados e você só quer iniciar/parar:

### Iniciar containers
```bash
docker compose up -d
```

### Parar containers
```bash
docker compose down
```

### Ver status
```bash
docker compose ps
```

### Ver logs em tempo real
```bash
# Todos os containers
docker compose logs -f

# Container específico
docker compose logs -f gcomp-backend-java
```

---

## 🔄 Quando Fazer Rebuild

Você **precisa** fazer rebuild nos seguintes casos:

### 1. Mudança de Branch

Se você alterou as variáveis `BRANCH_*` no `.env`:

```bash
# Rebuild de um serviço específico
docker compose up -d --build gcomp-backend-java

# Rebuild de todos
docker compose up -d --build
```

### 2. Mudança de Código (Pull/Commit novo)

Se houve alterações no código dos repositórios:

```bash
docker compose up -d --build
```

### 3. Mudança de Dockerfile

Se você modificou algum `Dockerfile.*`:

```bash
docker compose up -d --build
```

### ❌ NÃO precisa rebuild quando:

- ✅ Apenas iniciar/parar containers
- ✅ Mudar apenas variáveis de ambiente em `.env` (requer recreate)
- ✅ Ver logs
- ✅ Acessar shell do container

---

## 🔧 Comandos Úteis

### Recriar container sem rebuild (aplicar mudanças do .env)
```bash
docker compose up -d --force-recreate gcomp-sistema
```

### Remover tudo (incluindo volumes do banco)
```bash
docker compose down -v
```

### Acessar shell de um container
```bash
# Exemplo: acessar backend Java
docker exec -it gcomp-backend-java bash
```

### Ver logs de erro específico
```bash
docker compose logs gcomp-backend-java | Select-String -Pattern "ERROR"
```

### Verificar saúde dos containers
```bash
docker ps --filter "name=gcomp"
```

---

## 🌐 Acessar a Aplicação

Após os containers estarem rodando (status `healthy`):

| Serviço | URL | Descrição |
|---------|-----|-----------|
| **Frontend** | http://localhost:8081 | Interface principal do sistema |
| **Backend Java** | http://localhost:8080 | API REST Java |
| **Backend Node** | http://localhost:3000 | API REST Node.js |
| **Banco de Dados** | localhost:3307 | MariaDB (use cliente MySQL) |

**Credenciais do banco:**
- Host: `localhost`
- Porta: `3307`
- Usuário: `gcomp`
- Senha: `gcomp123`
- Database: `servidorgerencia_gcomp`

---

## 🐛 Solução de Problemas

### Container não inicia (status "Exited")

```bash
# Ver o erro
docker logs gcomp-backend-java

# Forçar rebuild
docker compose up -d --build --force-recreate gcomp-backend-java
```

### Backend Java retorna 404

Verifique se o datasource foi configurado:
```bash
docker exec gcomp-backend-java ls -la /opt/jboss/wildfly/standalone/deployments/

# Se houver ROOT.war.failed, veja o erro:
docker exec gcomp-backend-java cat /opt/jboss/wildfly/standalone/deployments/ROOT.war.failed
```

### Backend Node não conecta ao banco

```bash
# Verificar configuração do banco
docker exec gcomp-backend-node cat /app/src/config/database.json

# Deve mostrar:
# {
#   "host": "gcomp-db",
#   "user": "gcomp",
#   "pass": "gcomp123",
#   "nome_banco": "servidorgerencia_gcomp"
# }
```

### Container "unhealthy"

```bash
# Ver detalhes do healthcheck
docker inspect gcomp-backend-node | Select-String -Pattern "Health" -Context 10

# Testar manualmente o healthcheck
docker exec gcomp-backend-node curl http://localhost:3003/
```

### Porta já está em uso

Pare o serviço que está usando a porta ou mude no `docker-compose.yml`:
```yaml
ports:
  - "8082:8080"  # Muda porta do host (esquerda)
```

---

## 📁 Estrutura do Projeto

```
gcomp-docker/
├── docker-compose.yml          # Orquestração dos containers
├── .env                        # Variáveis de ambiente (NÃO COMMITAR TOKEN!)
├── Dockerfile.java-backend     # Build do backend Java
├── Dockerfile.java-sistema     # Build do frontend (WildFly)
├── Dockerfile.node             # Build do backend Node.js
├── entrypoint-node.sh          # Script de inicialização do Node
├── dump/
│   ├── 01-init.sql            # Script de inicialização do banco
│   └── dump_temp.sql.data     # Dump do banco (dados)
└── README.md                   # Este arquivo
```

---

## 🔐 Segurança

### ⚠️ IMPORTANTE

- **NUNCA** commite o arquivo `.env` com o `GIT_TOKEN` real
- Use `.gitignore` para ignorar `.env`
- Em produção, use Docker Secrets ou variáveis de ambiente do CI/CD

### Gerar novo token GitHub

1. GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token (classic)
3. Selecione: `repo` (acesso completo)
4. Copie o token e adicione no `.env`

---

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────┐
│         Docker Network (bridge)         │
│                                         │
│  ┌─────────────┐                       │
│  │  gcomp-db   │ MariaDB 10.6          │
│  │  :3306      │ (exposto como :3307)  │
│  └──────┬──────┘                       │
│         │                               │
│    ┌────┴─────────────┐                │
│    │                  │                │
│  ┌─▼──────────────┐ ┌─▼──────────────┐│
│  │ backend-node   │ │ backend-java   ││
│  │ Node.js + MySQL│ │ WildFly + MySQL││
│  │ :3003 (:3000)  │ │ :8080          ││
│  └────────┬───────┘ └───┬────────────┘│
│           │             │              │
│           └──────┬──────┘              │
│                  │                     │
│          ┌───────▼────────┐           │
│          │ gcomp-sistema  │           │
│          │ WildFly/JSF    │           │
│          │ :8080 (:8081)  │           │
│          └────────────────┘           │
└─────────────────────────────────────────┘
```

---

## 📝 Mudanças Implementadas

### 1. Banco de Dados (gcomp-db)
- ✅ Desabilitado verificação de foreign keys durante import
- ✅ Script `01-init.sql` para importar dump automaticamente

### 2. Backend Node (gcomp-backend-node)
- ✅ Script de inicialização que gera `database.json` dinamicamente
- ✅ Configuração via variáveis de ambiente (`DB_HOST`, `DB_USER`, etc)
- ✅ Porta corrigida para 3003
- ✅ Healthcheck ajustado

### 3. Backend Java (gcomp-backend-java)
- ✅ Trocado **Tomcat → WildFly** (compatibilidade com `persistence.xml`)
- ✅ Driver MySQL instalado como módulo do WildFly
- ✅ Datasource `java:/gCompDS` configurado via JBoss CLI
- ✅ Modo `--admin-only` para configurar antes do deploy

### 4. Frontend (gcomp-sistema)
- ✅ URLs corretas no `.env`:
  - `URL=http://gcomp-backend-java:8080/service/`
  - `URL_NODE=http://gcomp-backend-node:3003/api`
- ✅ Classe `Env.java` lê variáveis de ambiente em runtime

---

## 📚 Referências

- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [WildFly Documentation](https://docs.wildfly.org/)
- [MariaDB Docker Hub](https://hub.docker.com/_/mariadb)

---

## 🔄 Migrações do Banco de Dados (AUTOMÁTICO)

Quando houver atualizações no esquema do banco:

```bash
# 1. Edite o modelo ER_GComp.mwb no MySQL Workbench
# 2. Salve o arquivo (Ctrl+S)

# 3. Execute o container de migração
docker compose --profile migrations up gcomp-migrations
```

**O sistema faz TUDO automaticamente:**
- ✅ Lê o arquivo `.mwb` direto (sem exportação manual!)
- ✅ Detecta mudanças no schema (compara com banco atual)
- ✅ Cria novas tabelas e adiciona novas colunas
- ✅ Aplica no banco Docker
- ✅ Salva histórico e versão
- ✅ Para sozinho quando terminar

📚 **Documentação completa**: [database_migrations/README.md](database_migrations/README.md)

### Como funciona internamente

1. **Parser Automático**: O arquivo `.mwb` é um ZIP com XML. O script Python extrai a estrutura automaticamente.
2. **Comparação Inteligente**: Compara o modelo com o banco atual (`SHOW TABLES`, `SHOW COLUMNS`).
3. **Aplicação Segura**: Apenas **adiciona** tabelas/colunas (nunca remove, para não perder dados).
4. **Versionamento**: Usa hash MD5 do `.mwb` para não reaplicar a mesma versão.

### Logs e histórico

```bash
# Ver logs da migração
docker logs gcomp-migrations

# Ver histórico de migrações aplicadas
ls database_migrations/history/
```

### Forçar reaplicação (se necessário)

```bash
rm database_migrations/.migration_version
docker compose up gcomp-migrations
```

---

## 🆘 Suporte

Se encontrar problemas:

1. Verifique os logs: `docker compose logs`
2. Veja o status: `docker compose ps`
3. Verifique as portas: `netstat -an | Select-String "8080|3000|3307|8081"`
4. Recrie tudo: `docker compose down -v && docker compose up -d --build`

---

**Última atualização**: 12/11/2025  
**Versão**: 1.0
