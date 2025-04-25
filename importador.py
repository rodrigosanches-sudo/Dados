import pandas as pd
import psycopg2
import re
from datetime import datetime

# Conexão com o PostgreSQL
conn = psycopg2.connect(
    dbname="entrevista_dados",
    user="postgres",
    password="SUA_SENHA",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

df = pd.read_excel("dados_importacao.xlsx")

# Renomear colunas
df.columns = [
    'nome_razao_social', 'nome_fantasia', 'cpf_cnpj', 'data_nasc', 'data_cadastro',
    'celular', 'telefone', 'email', 'endereco', 'numero', 'complemento', 'bairro',
    'cep', 'cidade', 'uf', 'plano', 'plano_valor', 'vencimento', 'status', 'isento'
]

falhas = []
importados = 0

def limpa_doc(doc):
    return re.sub(r'\D', '', str(doc))

for i, row in df.iterrows():
    try:
        cpf_cnpj = limpa_doc(row['cpf_cnpj'])
        if not cpf_cnpj or len(cpf_cnpj) not in [11, 14]:
            falhas.append((i + 2, "CPF/CNPJ inválido"))
            continue

        cur.execute("SELECT id FROM tbl_clientes WHERE cpf_cnpj = %s", (cpf_cnpj,))
        cliente = cur.fetchone()

        if cliente:
            cliente_id = cliente[0]
        else:
            cur.execute("""
                INSERT INTO tbl_clientes (nome_razao_social, nome_fantasia, cpf_cnpj, data_nascimento, data_cadastro)
                VALUES (%s, %s, %s, %s, %s) RETURNING id
            """, (
                row['nome_razao_social'],
                row['nome_fantasia'],
                cpf_cnpj,
                row['data_nasc'] if not pd.isna(row['data_nasc']) else None,
                row['data_cadastro'] if not pd.isna(row['data_cadastro']) else datetime.now()
            ))
            cliente_id = cur.fetchone()[0]

        # Plano
        cur.execute("SELECT id FROM tbl_planos WHERE descricao = %s", (row['plano'],))
        plano = cur.fetchone()
        if not plano:
            falhas.append((i + 2, f"Plano '{row['plano']}' não encontrado"))
            continue
        plano_id = plano[0]

        # Status
        cur.execute("SELECT id FROM tbl_status_contrato WHERE status = %s", (row['status'],))
        status = cur.fetchone()
        if not status:
            falhas.append((i + 2, f"Status '{row['status']}' não encontrado"))
            continue
        status_id = status[0]

        # Contrato
        cur.execute("""
            INSERT INTO tbl_cliente_contratos (
                cliente_id, plano_id, dia_vencimento, isento,
                endereco_logradouro, endereco_numero, endereco_bairro,
                endereco_cidade, endereco_complemento, endereco_cep,
                endereco_uf, status_id
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            cliente_id,
            plano_id,
            int(row['vencimento']),
            str(row['isento']).lower() == 'true',
            row['endereco'],
            str(row['numero']) if not pd.isna(row['numero']) else None,
            row['bairro'],
            row['cidade'],
            row['complemento'],
            str(row['cep']),
            row['uf'],
            status_id
        ))

        # Contatos
        contatos = [
            ("Telefone", row['telefone']),
            ("Celular", row['celular']),
            ("E-Mail", row['email'])
        ]
        for tipo, valor in contatos:
            if pd.isna(valor):
                continue
            cur.execute("SELECT id FROM tbl_tipos_contato WHERE tipo_contato = %s", (tipo,))
            tipo_id = cur.fetchone()
            if tipo_id:
                cur.execute("""
                    INSERT INTO tbl_cliente_contatos (cliente_id, tipo_contato_id, contato)
                    VALUES (%s, %s, %s)
                    ON CONFLICT DO NOTHING
                """, (cliente_id, tipo_id[0], str(valor)))

        importados += 1

    except Exception as e:
        falhas.append((i + 2, str(e)))

conn.commit()
cur.close()
conn.close()

print(f" Importados: {importados}")
print(f" Falhas: {len(falhas)}")

if falhas:
    print("\nErros encontrados:")
    for linha, motivo in falhas:
        print(f" - Linha {linha}: {motivo}")
