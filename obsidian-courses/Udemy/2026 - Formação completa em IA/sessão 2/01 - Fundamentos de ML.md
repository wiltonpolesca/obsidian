# Fundamentos de Machine Learning

O modelo é uma tabela no qual os dados serão submetidos e, a partir dos dados, o modelo irá definir o resultado

### Exemplo de modelo
![[section-2-model.png]]
### Exemplo de utilização do modelo
![[section-2-using-the-model.png]]

---

## Aplicações

- Medicina
- Educação
- Processamento de linguagem natural (GPT por exemplo)
- Bioinformática
- Detecção de fraude
- Reconhecimento de fala
- Fincanças
- Robóticas
- ...

### Exemplos

#### Marketing

- Quais clientes irão responder a quais promoções?
	- Direcionamento das promoções
- Qual combinação de produtos que mais vendem juntos?
- Quais clientes irão comprar mesmo sem ofertas?
	- Para quê uma oferta se o cliente vai pagar o preço de tabela?
- Identificação de consumadores alfa
- Churn Analysis: quais clientes tendem a abandonar a empresa?
	- Tentativa de manter o cliente
#### Educação

- Quais alunos tem maior probabilidade de  abandonar o curso?
- Quais alunos têm maior probabilidade de voltar a fazer novos cursos?
- Quais alunos são mais fiéis?
- Quais cursos tendem a ser mais rentáveis?
- Quais características atraem mais alunos?

#### RH

- Qual o perfil de talentos é mais adequado para e para quais vagas?
- Qual o perfil de funcionários que tendem a abandonar o emprego e quando?
- Quais ações efetivas melhoram a produtividade?
- Quais funcionários tendem a ser mais bem sucedidos?

#### Finanças / Contabilidade

- Detecção de fraudes em transações financeiras
- Análise de risco de crédito
- Análise de mercado e previsão de tendências
- Detecção de padrões em grandes conjuntos de dados financeiros (algorítimos estatísticos)

---

## Estrutura de dados
![[section-2-data-structure.png]]
Esse é o formato de dados padrão utilizados por ML (dados tabulares)

### Considerando a tabela acima

- Uma **coluna** é conhecida como "dimensão" e/ou "característica" do dado
- Os atributos variam de acordo com o negócio.
- Uma **Instância** é a representação de algo que já aconteceu, na tabela é a linha (cada linha é uma instância)
- Um **Classe** é utilizada na técnica "classificação", essa técnica utiliza um atributo especial (classe) para definir o resultado da operação
	- a coluna não precisa, obrigatoriamente, se chamar classe, porém é largamente utilizado.
- **Tipo de dado**
	- Categóricos (texto)
	- Numéricos
	- No processamento, atributos numéricos podem ser categorizados, ou seja, transformados em texto e o inverso também um texto ser categorizado em número.

---

## Conceitos vitais

A machine learning é dividia em 4 principais tipos (tarefas):

![[section-2-ml-types.png]]
### Classificação

O mais importante dentro do processo.
Descrever ou prever um atributo especial (a classe)

Usa-se características e ou diagnósticos do domínio para prever um resultado.

A classificação pode prever algo **Categórico**, para valores numéricos, utiliza-se a *Regressão*

### Regressão

Para a previsão de um **valor**, monetário ou não, utiliza-se a Regressão.

Exemplo:

![[section-2-regression-house-price.png]]

A partir das características, é possível prever o custo do imóvel

### Agrupamentos

Não existe classe ou previsão em agrupamentos, o objetivo é separar os dados de acordo com as características/semelhanças dos dados.
- Nova espécie de animal
- Acessos fraudulentos ou não

Exemplo de segmentação de clientes

![[section-2-example-client-segmentation.png]]

### Regras de associação

Exemplo de recomendação de produto por cliente

![[section-2-product-recommendation.png]]

A partir dessa lista, o algorítimo detecta quais produtos tem mais chance de ser comprados juntos.
### Outras menos priorizadas

- Detecção de anomalias
- Aprendizado por reforço
- Processamento de linguagem natural (NLP) - modelos GPT são os mais conhecidos
- Redes neurais (\*)
- Redução de dimensionalidade/Seleção de recursos
- Aprendizado semi supervisionado
	- Está entre *classificação* e *agrupamento*

(\*) -> é também um tipo de algorítimo

![[section-2-supervisoned-vs-no-supervisioned.png]]

---

