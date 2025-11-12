#!/usr/bin/env python3
"""
Parser para extrair SQL de arquivos .mwb do MySQL Workbench
Arquivo .mwb é basicamente um ZIP com XML interno
"""

import zipfile
import xml.etree.ElementTree as ET
from io import BytesIO

def parse_mwb_file(mwb_path):
    """
    Extrai informações do arquivo .mwb
    
    Retorna dicionário com:
    - tables: lista de tabelas
    - schema_name: nome do schema
    """
    
    result = {
        'tables': [],
        'schema_name': 'gestorgcomp',
        'sql': []
    }
    
    try:
        with zipfile.ZipFile(mwb_path, 'r') as zip_ref:
            # O arquivo document.mwb.xml contém o modelo
            if 'document.mwb.xml' in zip_ref.namelist():
                xml_content = zip_ref.read('document.mwb.xml')
                root = ET.fromstring(xml_content)
                
                # Namespace do MySQL Workbench
                ns = {'grt': 'http://www.mysql.com/grt'}
                
                # Busca o schema
                for schema in root.findall('.//value[@struct-name="db.mysql.Schema"]', ns):
                    schema_name = schema.find('.//value[@key="name"]', ns)
                    if schema_name is not None:
                        result['schema_name'] = schema_name.text
                    
                    # Busca as tabelas
                    for table in schema.findall('.//value[@struct-name="db.mysql.Table"]', ns):
                        table_name_elem = table.find('.//value[@key="name"]', ns)
                        if table_name_elem is not None:
                            table_info = {
                                'name': table_name_elem.text,
                                'columns': []
                            }
                            
                            # Busca as colunas
                            for column in table.findall('.//value[@struct-name="db.mysql.Column"]', ns):
                                col_name = column.find('.//value[@key="name"]', ns)
                                col_type = column.find('.//value[@key="simpleType"]', ns)
                                
                                if col_name is not None:
                                    table_info['columns'].append({
                                        'name': col_name.text,
                                        'type': col_type.text if col_type is not None else 'VARCHAR(255)'
                                    })
                            
                            result['tables'].append(table_info)
                
                print(f"✅ Arquivo .mwb parseado com sucesso!")
                print(f"   Schema: {result['schema_name']}")
                print(f"   Tabelas encontradas: {len(result['tables'])}")
                
                return result
    
    except Exception as e:
        print(f"❌ Erro ao parsear .mwb: {e}")
        return None

def generate_sql_from_mwb(mwb_path):
    """
    Gera SQL básico a partir do .mwb
    Nota: Esta é uma versão simplificada. 
    Para SQL completo, use Forward Engineer do Workbench.
    """
    
    data = parse_mwb_file(mwb_path)
    if not data:
        return None
    
    sql_statements = []
    sql_statements.append(f"-- Schema: {data['schema_name']}")
    sql_statements.append(f"USE `{data['schema_name']}`;")
    sql_statements.append("")
    
    for table in data['tables']:
        sql_statements.append(f"-- Table: {table['name']}")
        
        # Gera CREATE TABLE básico
        cols = []
        for col in table['columns']:
            cols.append(f"  `{col['name']}` {col['type']}")
        
        if cols:
            sql_statements.append(f"CREATE TABLE IF NOT EXISTS `{table['name']}` (")
            sql_statements.append(",\n".join(cols))
            sql_statements.append(");")
            sql_statements.append("")
    
    return "\n".join(sql_statements)


if __name__ == "__main__":
    # Teste
    import sys
    if len(sys.argv) > 1:
        result = generate_sql_from_mwb(sys.argv[1])
        if result:
            print(result)
