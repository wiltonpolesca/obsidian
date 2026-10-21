Prompt:
Considere um scenário onde tenho um sistema responsável por registrar a manutenção de equipamentos. Esse sistema terá, em sua base de dados:

- Lista de produtos (insumos a serem utilizados nas manutençòes)
- Controle de estoque de produtos
- - controle de compras (entrada e saída)
- Ordens de manutenção
- Detalhes da manutenção
- - Equipamento
    - horímetro do equipamento (geralmente as manutenções corretivas/preditivas se baseiam nessa informação)
    - tempo da manutenção (desde a chegada ao término da manutenção)
    - Material utilizado na manutenção e profissional responsável (um mesmo equipamento, em uma mesma ordem de serviço, poderá envolver diferentes materiais e diferentes profissionais)

Considerando que o sistema tem todo o histórico de suas transações, como isso pode ser usado para alimentar uma llm e, quando o usuário fizer uma pergunta, a LLM utilizar desses dados (somente consulta) para elaborar as respostas?

---


Sim. Esse é um dos melhores cenários para usar uma LLM corporativa porque você já possui uma base histórica extremamente rica e estruturada.

O ponto mais importante é entender que **a LLM não deve ser treinada novamente com seus dados operacionais**. Na maioria dos casos, a melhor arquitetura é usar **RAG (Retrieval Augmented Generation)**, onde a LLM consulta os dados da sua aplicação em tempo real e usa os resultados para construir a resposta.

## Arquitetura recomendada

Usuário

   |

   v

LLM

   |

   v

Camada de consulta (API)

   |

   +--> Banco de Dados

           |

           +--> Produtos

           +--> Estoque

           +--> Compras

           +--> Ordens de Serviço

           +--> Equipamentos

           +--> Horímetros

           +--> Materiais utilizados

           +--> Profissionais envolvidos

Fluxo:

1. Usuário faz uma pergunta.
2. A LLM identifica quais dados são necessários.
3. A LLM chama uma ferramenta (API ou consulta SQL).
4. O banco retorna os dados.
5. A LLM gera a resposta usando apenas os resultados retornados.

---

# Exemplos de perguntas

## Estoque

Pergunta:

> Quantos litros de óleo hidráulico temos disponíveis?

A LLM poderia executar:

SELECT quantidade

FROM estoque

WHERE produto = 'Óleo Hidráulico';

Resposta:

> Atualmente existem 1.250 litros de óleo hidráulico disponíveis no estoque.

---

## Custos

Pergunta:

> Quanto gastamos com peças nos últimos 12 meses?

Consulta:

SELECT SUM(valor_total)

FROM movimentacao_estoque

WHERE tipo = 'SAIDA'

AND data >= CURRENT_DATE - INTERVAL '12 months';

Resposta:

> Nos últimos 12 meses foram gastos R$ 320.450,00 em materiais de manutenção.

---

## Manutenção por equipamento

Pergunta:

> Qual equipamento apresentou o maior custo de manutenção este ano?

A consulta pode agregar ordens de serviço, materiais e mão de obra:

SELECT equipamento,

       SUM(custo_total)

FROM manutencao

GROUP BY equipamento

ORDER BY 2 DESC;

Resposta:

> O equipamento TR-102 acumulou R$ 185.000 em custos de manutenção em 2026.

---

# Casos mais interessantes

O verdadeiro poder aparece quando a LLM combina várias tabelas.

Pergunta:

> Por que a Escavadeira E-301 ficou parada por muito tempo nos últimos meses?

A LLM consulta:

- Ordens de manutenção
- Tempo de parada
- Tempos de execução
- Materiais faltantes
- Compras associadas

E responde algo como:

> A análise do histórico mostra que 72% do tempo de indisponibilidade ocorreu devido à espera de peças. Em três das quatro ocorrências foi necessário aguardar a chegada da bomba hidráulica modelo XZ-30, cujo prazo médio de entrega foi de 18 dias.

Esse tipo de resposta seria extremamente difícil com SQL puro, mas é natural para uma LLM.

---

# Perguntas analíticas

Você pode transformar o histórico em indicadores.

Por exemplo:

### Confiabilidade

Pergunta:

> Qual equipamento apresenta mais falhas?

A LLM calcula:

Quantidade de ordens corretivas

--------------------------------

E-301 = 25

E-105 = 12

T-204 = 30

Resposta:

> O equipamento T-204 apresenta a maior frequência de falhas, com 30 intervenções corretivas registradas.

---

### MTBF

(Média de horas entre falhas)

Pergunta:

> Qual o MTBF da máquina E-301?

A LLM usa:

- Horímetros
- Datas das manutenções corretivas

E responde:

> O MTBF estimado da E-301 é de 482 horas de operação.

---

### MTTR

(Média de tempo de reparo)

Pergunta:

> Quanto tempo normalmente levamos para reparar a E-301?

A LLM utiliza:

- Hora de início
- Hora de término

Resposta:

> O MTTR médio da E-301 é de 6,2 horas.

---

# Predição

Embora a LLM não seja ideal para cálculos preditivos, você pode integrar modelos de Machine Learning.

Por exemplo:

Dados históricos:

Equipamento: E-301

100h -> troca filtro

500h -> troca óleo

1000h -> bomba hidráulica

1500h -> troca óleo

2000h -> bomba hidráulica

Pergunta:

> O que provavelmente precisará de manutenção nas próximas 100 horas?

Resposta:

> Com base no histórico, a bomba hidráulica apresenta um padrão de substituição próximo a cada 1.000 horas. Como o equipamento está atualmente com 1.950 horas, recomenda-se inspeção preventiva.

---

# Estrutura ideal para IA

Além das tabelas transacionais, eu criaria uma camada analítica.

Exemplo:

vw_equipamento_indicadores

    MTBF

    MTTR

    Custo anual

    Custo mensal

    Disponibilidade

vw_consumo_materiais

vw_falhas_frequentes

vw_historico_horimetro

A LLM consultaria essas views em vez das tabelas brutas.

Isso reduz:

- complexidade
- tempo de resposta
- risco de erro

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

# O que eu faria no seu caso

Com os dados que você descreveu, eu implementaria:

1. PostgreSQL como fonte principal.
2. Views analíticas para indicadores de manutenção.
3. API REST para consultas controladas.
4. Azure OpenAI com Function Calling.
5. Permitir apenas leitura.
6. Registrar todas as consultas executadas pela IA.

Assim, o usuário poderia fazer perguntas em linguagem natural como:

> Quais equipamentos tiveram maior custo este ano?

> Quais materiais estão causando mais atrasos?

> Quais máquinas devem entrar em manutenção preventiva nos próximos 30 dias?

> Qual profissional tem participado da maior quantidade de reparos corretivos?

E a LLM transformaria essas perguntas em consultas ao banco, consolidaria os resultados e entregaria uma resposta amigável, sem nunca alterar os dados.

### Correção de português

Seu texto:

> "Considere um scenário"

Melhor:

> **"Considere um cenário"**

Correção: a palavra correta em português é **cenário**.