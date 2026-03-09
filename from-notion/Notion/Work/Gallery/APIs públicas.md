---

---
## Cotação de ações

[Free Stock APIs in JSON & Excel | Alpha Vantage](https://www.alphavantage.co/)

[https://albertosouza.net/artigos/22-importando-dados-bovespa](https://albertosouza.net/artigos/22-importando-dados-bovespa)

## Obter informações de fornecedor a partir do CNPj

[https://receitaws.com.br/](https://receitaws.com.br/)

Exemplo de uso:

[https://www.receitaws.com.br/v1/cnpj/45453214000151](https://www.receitaws.com.br/v1/cnpj/45453214000151)

```javascript
{
    "atividade_principal": [
        {
            "text": "Comércio atacadista de medicamentos e drogas de uso humano",
            "code": "46.44-3-01"
        }
    ],
    "data_situacao": "03/11/2005",
    "complemento": "BLOCO P SALA 301",
    "tipo": "MATRIZ",
    "nome": "PROFARMA DISTRIBUIDORA DE PRODUTOS FARMACEUTICOS SA",
    "uf": "RJ",
    "telefone": "(21) 4009-0200",
    "email": "fiscalcorporativo@profarma.com.br",
    "atividades_secundarias": [
        {
            "text": "Comércio atacadista especializado em outros produtos alimentícios não especificados anteriormente",
            "code": "46.37-1-99"
        },
        {
            "text": "Comércio atacadista de produtos alimentícios em geral",
            "code": "46.39-7-01"
        },
        {
            "text": "Comércio atacadista de instrumentos e materiais para uso médico, cirúrgico, hospitalar e de laboratórios",
            "code": "46.45-1-01"
        },
        {
            "text": "Comércio atacadista de próteses e artigos de ortopedia",
            "code": "46.45-1-02"
        },
        {
            "text": "Comércio atacadista de cosméticos e produtos de perfumaria",
            "code": "46.46-0-01"
        },
        {
            "text": "Comércio atacadista de produtos de higiene pessoal",
            "code": "46.46-0-02"
        },
        {
            "text": "Comércio atacadista de outros equipamentos e artigos de uso pessoal e doméstico não especificados anteriormente",
            "code": "46.49-4-99"
        }
    ],
    "qsa": [
        {
            "qual": "16-Presidente",
            "nome": "SAMMY BIRMARCKER"
        },
        {
            "qual": "10-Diretor",
            "nome": "MAXIMILIANO GUIMARAES FISCHER"
        }
    ],
    "situacao": "ATIVA",
    "bairro": "BARRA DA TIJUCA",
    "logradouro": "AV AYRTON SENNA",
    "numero": "2.150",
    "cep": "22.775-003",
    "municipio": "RIO DE JANEIRO",
    "porte": "DEMAIS",
    "abertura": "05/02/1981",
    "natureza_juridica": "204-6 - Sociedade Anônima Aberta",
    "cnpj": "45.453.214/0001-51",
    "ultima_atualizacao": "2020-08-22T13:40:52.834Z",
    "status": "OK",
    "fantasia": "",
    "efr": "",
    "motivo_situacao": "",
    "situacao_especial": "",
    "data_situacao_especial": "",
    "capital_social": "1159065001.53",
    "extra": {},
    "billing": {
        "free": true,
        "database": true
    }
}
```