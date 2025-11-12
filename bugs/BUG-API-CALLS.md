# 🐛 BUG CRÍTICO: Inconsistência nas Chamadas de API

## ⚠️ AÇÃO URGENTE NECESSÁRIA

**Branch:** `wo-patricia-config`

**Problema:** Ao migrar para usar variáveis de ambiente (`.env`), apenas ALGUNS DAOs foram atualizados para adicionar barra inicial nas URLs, mas OUTROS NÃO foram.

**Impacto:** Aplicacão QUEBRADA - login funciona mas categorias não, ou vice-versa.

**Solução:** Padronizar TODOS os DAOs para usar o mesmo formato (recomendado: COM barra inicial).

---

## Problema Identificado

O código Java do frontend (gcomp-sistema) tem **inconsistência** na forma como concatena URLs para chamar o backend Node.js.

### Exemplos do Código Atual (Confirmado via Bytecode)

**❌ ERRADO - DaoCategoria.java:**
```java
client.resource(url_node + "categorias" + "/buscarPorIdSistema/?id=" + id)
//                         ^^^^^^^^^^^^ SEM barra inicial!
// Com URL_NODE=.../api  → resulta: .../apicategorias/buscarPorIdSistema  (404 Not Found)
// Com URL_NODE=.../api/ → resulta: .../api/categorias/buscarPorIdSistema (✓ funciona)
```

**❌ ERRADO - DaoUsuario.java:**
```java
client.resource(url_node + "usuarios" + "/procurarUsuarioLogin")
//                         ^^^^^^^^^^ SEM barra inicial!
// Com URL_NODE=.../api  → resulta: .../apiusuarios/procurarUsuarioLogin  (404 Not Found)
// Com URL_NODE=.../api/ → resulta: .../api/usuarios/procurarUsuarioLogin (✓ funciona)
```

**❌ ERRADO - DaoTime.java:**
```java
client.resource(url_node + "times" + "/buscarAtestadoTime")
//                         ^^^^^^^ SEM barra inicial!
// Com URL_NODE=.../api  → resulta: .../apitimes/buscarAtestadoTime  (404 Not Found)
// Com URL_NODE=.../api/ → resulta: .../api/times/buscarAtestadoTime (✓ funciona)
```

## Impacto

**INCONSISTÊNCIA na branch wo-patricia-config!**

Alguns DAOs foram atualizados para usar barra inicial (`/usuarios/...`), mas outros NÃO (`categorias/...`).

**DAOs identificados:**
- `DaoUsuario` - usa `/usuarios/...` (COM barra inicial) ✓
- `DaoCategoria` - usa `categorias/...` (SEM barra inicial) ❌
- `DaoTime` - usa `times/...` (SEM barra inicial) ❌
- Outros DAOs - status desconhecido

**Resultado:**
- Com `URL_NODE=.../api` (sem barra): 
  - ✅ Login/usuários funciona
  - ❌ Categorias, times, etc. quebram (gera `/apicategorias`)
  
- Com `URL_NODE=.../api/` (com barra):
  - ❌ Login/usuários quebra (gera `/api//usuarios`)
  - ✅ Categorias, times, etc. funcionam

**NÃO HÁ CONFIGURAÇÃO DE `.env` QUE FUNCIONE PARA TUDO!**

## 📚 Histórico do Problema

**Branch WO (original):**
```java
// URLs hardcoded COM barra final
protected final String URL_NODE = "https://api.gerenciadorcompeticoes.com.br/api/";

// DAOs chamam SEM barra inicial
methodPostUrlPropria("usuarios/procurarUsuarioLogin", json)
// Resulta: .../api/ + usuarios/... = .../api/usuarios/... ✅ FUNCIONA
```

**Branch wo-patricia-config (atual) - PROBLEMA REAL:**
```java
// URL vem do .env (adaptado por Patricia)
protected final String URL_NODE = ENV.URL_NODE;

// MAS: Alguns DAOs foram atualizados, outros NÃO!
// DaoUsuario (atualizado):
methodPostUrlPropria("/usuarios/procurarUsuarioLogin", json)  // COM /

// DaoCategoria (NÃO atualizado):
methodPostUrlPropria("categorias/buscarPorIdSistema", json)   // SEM /

// RESULTADO:
// Com URL_NODE=.../api  (sem /): usuarios funciona, categorias quebra
// Com URL_NODE=.../api/ (com /): categorias funciona, usuarios quebra
```

## ✅ Solução Correta (para os Desenvolvedores)

### PASSO 1: Identificar Todos os DAOs Inconsistentes (URGENTE)

Procurar no código-fonte por TODAS as chamadas:

```bash
# Na pasta src/ do projeto gcomp-sistema:
grep -r 'methodPostUrlPropria("' .
grep -r 'methodoGetURLPropria("' .
grep -r 'methodDeleteUrlPropria("' .
```

Listar quais usam:
- **COM barra:** `methodPostUrlPropria("/usuarios/...")`
- **SEM barra:** `methodPostUrlPropria("categorias/...")`

### PASSO 2: Escolher Um Padrão

**Recomendado:** Usar sempre COM barra inicial (`/usuarios`, `/categorias`, `/times`)

Atualizar TODOS os DAOs para:
```java
// DaoCategoria.java - CORRIGIR
methodPostUrlPropria("/categorias/buscarPorIdSistema/?id=" + id, json)
//                   ^ adicionar barra aqui

// DaoTime.java - CORRIGIR  
methodPostUrlPropria("/times/buscarAtestadoTime", json)
//                   ^ adicionar barra aqui

// etc... TODOS os DAOs
```

E no `.env`:
```bash
URL_NODE=http://gcomp-backend-node:3003/api  # SEM barra final
```

### PASSO 3 (Alternativa): Método Helper (MELHOR A LONGO PRAZO)

Adicionar na classe `Dao.java`:

```java
/**
 * Normaliza URL do backend Node, garantindo barra entre base e endpoint
 */
protected String buildNodeUrl(String endpoint) {
    // Remove barra inicial do endpoint se existir
    String cleanEndpoint = endpoint.startsWith("/") ? endpoint.substring(1) : endpoint;
    
    // Garante que URL_NODE termina com barra
    String baseUrl = URL_NODE.endsWith("/") ? URL_NODE : URL_NODE + "/";
    
    return baseUrl + cleanEndpoint;
}
```

Atualizar métodos:
```java
public ClientResponse methodPostUrlPropria(String urlPropria, String json) {
    Client client = Client.create();
    WebResource webResource = client.resource(buildNodeUrl(urlPropria)); // USAR HELPER
    return webResource.type(MediaType.APPLICATION_JSON).post(ClientResponse.class, json);
}

public WebResource methodoGetURLPropria(String urlPropria) {
    Client client = Client.create();
    return client.resource(buildNodeUrl(urlPropria)); // USAR HELPER
}

// etc... atualizar TODOS os métodos que usam URL_NODE
```

**Vantagens:**
- Aceita `.env` com ou sem barra final
- Aceita chamadas com ou sem barra inicial
- NÃO quebra código existente
- Funciona em TODAS as branches

### Opção 2: Garantir Barra Final no `.env` (Temporário)

```bash
URL_NODE=http://gcomp-backend-node:3003/api/  # COM barra final
```

**Desvantagens:**
- Não resolve o problema estrutural
- Mascara o bug
- Pode confundir outros desenvolvedores

## 📝 Arquivos que Precisam ser Corrigidos

Procurar no código Java por padrões como:
```java
url_node + "categorias
url_node + "competicoes
url_node + "times
url_node + "jogos
// qualquer concatenação sem barra inicial
```

E substituir por:
```java
url_node + "/categorias
url_node + "/competicoes
url_node + "/times
url_node + "/jogos
// sempre com barra inicial
```

## 🔧 Workaround Temporário (Escolha Um)

Enquanto o código não for corrigido, escolha qual funcionalidade precisa:

### Opção A: Priorizar Login/Usuários
```bash
URL_NODE=http://gcomp-backend-node:3003/api  # SEM barra
```
✅ Login funciona  
❌ Categorias, times, jogos quebram

### Opção B: Priorizar Categorias/Times/Jogos
```bash
URL_NODE=http://gcomp-backend-node:3003/api/  # COM barra
```
❌ Login quebra  
✅ Categorias, times, jogos funcionam

**Não é possível ter tudo funcionando sem corrigir o código Java!**

## Branch Atual

Este bug existe na branch: `wo-patricia-config`

Os desenvolvedores devem:
1. Criar uma branch nova
2. Padronizar TODAS as chamadas para usar barra inicial
3. Testar login, categorias, times, jogos, etc.
4. Fazer merge

---

**Configuração Atual do Docker:**
```bash
URL_NODE=http://gcomp-backend-node:3003/api/  # COM barra final (temporário)
```

⚠️ **STATUS:** Configuração COM barra permite usar categorias/times/jogos, mas quebra login.

🔴 **AÇÃO NECESSÁRIA:** Desenvolvedores DEVEM padronizar todos os DAOs na branch `wo-patricia-config`.

**Após correção dos DAOs:**
1. Todos os DAOs usarão `/usuarios`, `/categorias`, `/times` (COM barra)
2. `.env` usará `URL_NODE=.../api` (SEM barra)
3. Tudo funcionará corretamente em qualquer ambiente (Docker, local, produção)
