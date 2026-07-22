# Introdução a correlação e regressão linear
D
## Conceitos

![[section-3-regressão-linear.png]]
Tabela com custos de um plano de saúde

| Idade | Custo |
| ----- | ----- |
| 18    | 871   |
| 23    | 1132  |
| 28    | 1242  |
| 33    | 1356  |
| 38    | 1488  |
| 43    | 1638  |
| 48    | 2130  |
| 53    | 2454  |
| 58    | 3066  |
| 63    | 4090  |
## Variáveis

- Existe uma relação matemática entre estas duas variáveis?
- Se existe, como posso medir sua força?
- Poderia usar essa relação para fazer previsões?
	- Exemplo, quanto custa um cliente com 45 anos?

## Gráfico de dispersão

![[section-3 - gráfico de dispersão.png]]

**Eixo y**: Corresponde a **variável de resposta ou dependente**
- Na regressão é o que queremos prever 

**Eixo x**: Corresponde a **variável exploratória ou independente**
- Na regressão é o que explica, ou usamos para prever

## Correlação

Ela pode ser um valor entre -1 e 1.

![[section-3-correlação.png]]
![[Udemy/2026 - Formação completa em IA/sessão 3/imgs/section-3-correlação-força.png]]

A correlação pode ser **positiva** e/ou **negativa**.

Exemplo, relação casaco vs temperatura
- Quanto MAIOR a temperatura MENOR a venda de casacos
- Quanto MENOR a temperatura MAIOR a venda de casacos

![[section-3-correlação-coeficiente-de-determinação.png]]

Exemplo:

![[section-3-correlação-coeficiente-de-determinação-exemplo-1.png]]

## Como fazer a previsão?

Qual a previsão de um cliente com 45 anos de idade?

- Cria-se a reta e obtem-se o valor na intersecção entre os eixos x e y na idade de 45 anos.

![[section-3-correlacão-como-constuir-a-linha.png]]