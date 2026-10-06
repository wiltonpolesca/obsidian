# Requirements

- On-Promisse first
- Cloud compatible
- Scalable
- Multi-tenant by design
- With integrated chat (IA)

# Technologies

- PostgreSQL
	- Production and Visualization (second readonly database that must be a clone from Prouction)
- C#
- Angular
- NATS
- RAG (integrar a base de dados histórica a uma LLM para obter respostas)
- Zitadel (SSO)
	- Microsoft integration

# Licenses

The system must have 2 levels of licence:

- Number of users
- Features

# Authorization

- Admin
- Read only
- Personalized (\*)

# Soft-Delete

- Track all deletes entries into a different table/schema (nosql format)

# Async

- Inbox/outbox patterns
- 
# Notifications

- Email
- SMS
- Teams ?
- Whatsapp ?

# Deploy

- docker compose?
- Windows server?
---

---

RAG (fabrício)
- [paquino11/chatpdf-rag-deepseek-r1](https://github.com/paquino11/chatpdf-rag-deepseek-r1)
- [Running DeepSeek R1 Locally on a Raspberry Pi - DEV Community](https://dev.to/jeremycmorgan/running-deepseek-r1-locally-on-a-raspberry-pi-1gh8)

---

Integrar com API's de sistemas de terceiros?
- Hexagon
- Sandvik/Newtrax
- Outros...

---

## tests

Considere um scenário onde tenho um sistema responsável por registrar a manutenção de equipamentos.

Esse sistema terá, em sua base de dados:
- Lista de produtos (insumos a serem utilizados nas manutençòes)
- Controle de estoque de produtos
	- controle de compras (entrada e saída)
- Ordens de manutenção
- Detalhes da manutenção
	- Equipamento
	- horímetro do equipamento (geralmente as manutenções corretivas/preditivas se baseiam nessa informação)
	- tempo da manutenção (desde a chegada ao término da manutenção)
	- Material utilizado na manutenção e profissional responsável (um mesmo equipamento, em uma mesma ordem de serviço, poderá envolver diferentes materiais e diferentes profissionais)

Considerando que o sistema tem todo o histórico de suas transações, como isso pode ser usado para alimentar uma llm e, quando o usuário fizer uma pergunta, a LLM utilizar desses dados (somente consulta) para elaborar as respostas?


---


# Tecnologias normalmente usadas

### Banco

- PostgreSQL
- SQL Server
- Oracle

### Camada de IA

- Azure OpenAI
- OpenAI
- Claude
- Gemini

### Orquestração

- LangChain
- LangGraph
- Semantic Kernel
- Azure AI Foundry

### Busca semântica (opcional)

- PostgreSQL + pgvector
- Azure AI Search
- Elasticsearch

---
2026-10-05

# Data sync

- Cada serviço (módulo) independente, ocasionalmente, precisará sincronizar dados com outro serviço.
	- Cada serviço terá sua rota própria para receber os dados de syncronismo
	- O formato dos dados será o mesmo para todos os serviços, somente a rota poderá ser diferente

- Todos os serviços irão escutar um tópico asincrono de pedido de sincronismo, o payload que definirá quem deverá responder e com o quê.
	- Serviços que receberem e que não são responsáveis pela resposta, simplesmente ignorarão a mensagem.

## Fluxo

1 -> Serviço A solicita, no tópico geral, dados de sincronismo da entidade de dispositivos
2 -> Serviço C, responsável pelos dispositivos, reconhece a mensagem e inicia o envio de dados para uma rota definida no payload da mensagem de requisição
3 -> Serviço A consome os dados disponibilizados pelo serviço C

### Importante !

Os dados para sincronismo devem ser persistentes na camada intermediária entre o emissor e o receptor, evitando perda dos dados em caso de queda de energia ou desligamento do sistema

# -- NOTIFICAÇÕES

TBD