# Desafio Prático – Analista de Dados

Este projeto importa dados de clientes a partir de uma planilha `.xlsx` para um banco PostgreSQL, validando e organizando em 3 tabelas:

- `tbl_clientes`
- `tbl_cliente_contratos`
- `tbl_cliente_contatos`

#Tecnologias

- Python 3
- Pandas
- Psycopg2
- PostgreSQL 17

#Como executar

1. Instale as dependências:
    ```
    pip install -r requirements.txt
    ```

2. Configure os dados do banco no script `importador.py`

3. Execute:
    ```
    python importador.py
    ```

#O que o script faz

- Valida CPF/CNPJ
- Evita duplicidade de clientes
- Verifica plano/status antes de inserir contrato
- Registra contatos telefônicos e e-mail

#Resultado

Ao final, o script informa:
- Total de registros importados
- Erros encontrados com número da linha e motivo



#Obs:

O script foi alterado schema_database_pgsql por um erro de sintaxe (\. — por isso dá erro de sintaxe)
estrutura é a mesma