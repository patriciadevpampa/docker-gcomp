#!/usr/bin/env python3
"""
Script AUTOMÁTICO de migração que roda dentro do container Docker
Processa arquivo .mwb e aplica mudanças no banco automaticamente
"""

import os
import sys
import time
import hashlib
import mysql.connector
from datetime import datetime
from mwb_parser import parse_mwb_file

# Configurações
MWB_FILE = "/migrations/ER_GComp.mwb"
VERSION_FILE = "/migrations/.migration_version"
MIGRATIONS_DIR = "/migrations/history"

# Configurações do banco (lidas do ambiente)
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'gcomp-db'),
    'port': int(os.getenv('DB_PORT', '3306')),
    'user': os.getenv('DB_USER', 'gcomp'),
    'password': os.getenv('DB_PASSWORD', 'gcomp123'),
    'database': os.getenv('DB_NAME', 'gestorgcomp')
}

def wait_for_database(max_retries=30):
    """Aguarda o banco estar disponível"""
    print("⏳ Aguardando banco de dados...")
    
    for i in range(max_retries):
        try:
            conn = mysql.connector.connect(
                host=DB_CONFIG['host'],
                port=DB_CONFIG['port'],
                user=DB_CONFIG['user'],
                password=DB_CONFIG['password']
            )
            conn.close()
            print(f"✅ Banco de dados está disponível!")
            return True
        except Exception as e:
            if i < max_retries - 1:
                time.sleep(2)
            else:
                print(f"❌ Banco não ficou disponível após {max_retries} tentativas")
                return False
    
    return False

def get_file_hash(filepath):
    """Calcula hash MD5 do arquivo"""
    if not os.path.exists(filepath):
        return None
    
    with open(filepath, 'rb') as f:
        return hashlib.md5(f.read()).hexdigest()

def get_current_version():
    """Lê versão atual"""
    if os.path.exists(VERSION_FILE):
        with open(VERSION_FILE, 'r') as f:
            return f.read().strip()
    return None

def save_version(version_hash):
    """Salva versão atual"""
    os.makedirs(os.path.dirname(VERSION_FILE), exist_ok=True)
    with open(VERSION_FILE, 'w') as f:
        f.write(version_hash)

def get_existing_tables():
    """Lista tabelas existentes no banco"""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        
        cursor.execute("SHOW TABLES")
        tables = [row[0] for row in cursor.fetchall()]
        
        cursor.close()
        conn.close()
        
        return set(tables)
    except Exception as e:
        print(f"⚠️  Erro ao listar tabelas: {e}")
        return set()

def get_table_columns(table_name):
    """Lista colunas de uma tabela"""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        
        cursor.execute(f"SHOW COLUMNS FROM `{table_name}`")
        columns = {row[0]: row[1] for row in cursor.fetchall()}
        
        cursor.close()
        conn.close()
        
        return columns
    except Exception as e:
        print(f"⚠️  Erro ao listar colunas de {table_name}: {e}")
        return {}

def apply_schema_changes(mwb_data):
    """
    Aplica mudanças do schema de forma incremental
    - Cria tabelas novas
    - Adiciona colunas novas (não remove para não perder dados)
    """
    
    if not mwb_data or not mwb_data['tables']:
        print("❌ Nenhuma tabela encontrada no .mwb")
        return False
    
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        
        # Desabilita verificação de foreign keys temporariamente
        cursor.execute("SET FOREIGN_KEY_CHECKS=0")
        
        existing_tables = get_existing_tables()
        changes_made = False
        
        for table in mwb_data['tables']:
            table_name = table['name']
            
            if table_name not in existing_tables:
                # Tabela nova - criar
                print(f"📝 Criando tabela nova: {table_name}")
                
                columns_sql = []
                for col in table['columns']:
                    columns_sql.append(f"  `{col['name']}` {col['type']}")
                
                create_sql = f"CREATE TABLE `{table_name}` (\n" + ",\n".join(columns_sql) + "\n);"
                
                try:
                    cursor.execute(create_sql)
                    print(f"   ✅ Tabela {table_name} criada")
                    changes_made = True
                except Exception as e:
                    print(f"   ⚠️  Erro ao criar {table_name}: {e}")
            
            else:
                # Tabela existe - verificar colunas
                existing_columns = get_table_columns(table_name)
                
                for col in table['columns']:
                    col_name = col['name']
                    
                    if col_name not in existing_columns:
                        # Coluna nova - adicionar
                        print(f"📝 Adicionando coluna {table_name}.{col_name}")
                        
                        try:
                            alter_sql = f"ALTER TABLE `{table_name}` ADD COLUMN `{col_name}` {col['type']}"
                            cursor.execute(alter_sql)
                            print(f"   ✅ Coluna adicionada")
                            changes_made = True
                        except Exception as e:
                            print(f"   ⚠️  Erro: {e}")
        
        # Reabilita verificação de foreign keys
        cursor.execute("SET FOREIGN_KEY_CHECKS=1")
        
        conn.commit()
        cursor.close()
        conn.close()
        
        if changes_made:
            print(f"\n✅ Migração aplicada com sucesso!")
        else:
            print(f"\n✅ Schema já está atualizado (nenhuma mudança necessária)")
        
        return True
        
    except Exception as e:
        print(f"❌ Erro ao aplicar migração: {e}")
        return False

def save_migration_log(version_hash, mwb_data):
    """Salva log da migração aplicada"""
    os.makedirs(MIGRATIONS_DIR, exist_ok=True)
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_file = f"{MIGRATIONS_DIR}/{timestamp}_{version_hash[:8]}.log"
    
    with open(log_file, 'w') as f:
        f.write(f"Migration applied at: {datetime.now().isoformat()}\n")
        f.write(f"Version hash: {version_hash}\n")
        f.write(f"Schema: {mwb_data['schema_name']}\n")
        f.write(f"Tables: {len(mwb_data['tables'])}\n")
        f.write("\nTables:\n")
        for table in mwb_data['tables']:
            f.write(f"  - {table['name']} ({len(table['columns'])} columns)\n")

def main():
    print("=" * 60)
    print("🔄 SISTEMA AUTOMÁTICO DE MIGRAÇÕES - GComp Database")
    print("=" * 60)
    print()
    
    # Verifica se arquivo .mwb existe
    if not os.path.exists(MWB_FILE):
        print(f"❌ Arquivo {MWB_FILE} não encontrado!")
        print("   Monte o volume corretamente: -v ./database_migrations:/migrations")
        sys.exit(1)
    
    # Aguarda banco estar disponível
    if not wait_for_database():
        sys.exit(1)
    
    print()
    
    # Calcula hash do arquivo atual
    current_hash = get_file_hash(MWB_FILE)
    last_version = get_current_version()
    
    print(f"📊 Status:")
    print(f"   Versão anterior: {last_version[:8] if last_version else 'nenhuma'}")
    print(f"   Versão atual: {current_hash[:8]}")
    print()
    
    # Verifica se precisa migrar
    if current_hash == last_version:
        print("✅ Banco de dados JÁ ESTÁ ATUALIZADO")
        print("   Nenhuma migração necessária.")
        sys.exit(0)
    
    print("📝 NOVA VERSÃO DETECTADA - Iniciando migração...")
    print()
    
    # Parse do arquivo .mwb
    print("🔍 Analisando arquivo .mwb...")
    mwb_data = parse_mwb_file(MWB_FILE)
    
    if not mwb_data:
        print("❌ Falha ao parsear arquivo .mwb")
        sys.exit(1)
    
    print()
    
    # Aplica mudanças
    print("⚙️  Aplicando mudanças no banco de dados...")
    print()
    
    if apply_schema_changes(mwb_data):
        # Salva nova versão
        save_version(current_hash)
        save_migration_log(current_hash, mwb_data)
        
        print()
        print("=" * 60)
        print("🎉 MIGRAÇÃO CONCLUÍDA COM SUCESSO!")
        print(f"   Nova versão: {current_hash[:8]}")
        print("=" * 60)
        sys.exit(0)
    else:
        print()
        print("❌ Falha na migração")
        sys.exit(1)

if __name__ == "__main__":
    main()
