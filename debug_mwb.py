from mwb_parser import parse_mwb_file
data = parse_mwb_file('/migrations/ER_GComp.mwb')
for t in data['tables'][:3]:
    print(f"\nTabela: {t['name']}")
    cols = [c['name'] for c in t['columns']]
    print(f"Total colunas: {len(cols)}")
    print(f"Primeiras 5: {cols[:5]}")
