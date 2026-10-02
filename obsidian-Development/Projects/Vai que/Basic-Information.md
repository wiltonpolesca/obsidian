# Requirements

- On-Promisse
- Cloud compatible
- Scalable
- With integrated chat (IA)

# Technologies

- PostgreSQL
	- Production and Visualization (copy)
- C#
- Angular
- NATS
- RAG (integrar a base de dados histórica a uma LLM para obter respostas)
- Zitadel (SSO)
	- Microsoft integration

# Licenses

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