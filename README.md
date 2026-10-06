# Projeto agrodados-sql
Banco de dados relacional de safras e vendas do agronegócio, com dados fictícios (MySQL)

# Modelo de dados:
Nosso modelo tem 7 tabelas, todas elas estão ligadas por relações N:1:

- `estado` -> `cidade`
- `cidade` -> `fazenda`
- `cultura` -> `safra`
- `cidade` -> `comprador`
- `fazenda` -> `safra`
- `comprador` -> `venda`
- `safra` -> `venda`

A safra resolve o modelo N:N entre `fazenda` e `cultura`. A `venda` liga o `comprador` à `safra`.

O modelo completo em texto está em [`docs/modelo.dbml`](docs/modelo.dbml)

Segue imagem do Diagrama completo
![Minha imagem local](img/agrodados_diagrama.png)