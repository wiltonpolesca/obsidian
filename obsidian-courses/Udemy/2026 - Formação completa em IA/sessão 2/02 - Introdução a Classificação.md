# Classificação

Quando se quer prever ou descrever a classe de um evento.

>Normalmente a classe em uma relação esta representada em um atributo especial, posicionado como último atributo da relação.

## Medir o desempenho

- Treino: Algoritmo processo dados e cria modelo
- Validação: Dados são usados para ajustar o modelo
- Teste: Dados são usados para avaliar a performance do modelo

### Matriz de confusão

m **LLMs e Machine Learning**, uma **matriz de confusão** (_confusion matrix_) é uma tabela usada para avaliar o desempenho de um modelo de classificação, mostrando quantas previsões foram corretas e quantas foram confundidas com outras classes.

Por exemplo, em uma tarefa binária ("spam" ou "não spam"):

|                   | Previsto Spam            | Previsto Não Spam        |
| ----------------- | ------------------------ | ------------------------ |
| **Real Spam**     | Verdadeiro Positivo (TP) | Falso Negativo (FN)      |
| **Real Não Spam** | Falso Positivo (FP)      | Verdadeiro Negativo (TN) |

#### Interpretação

- **TP (True Positive)**: o modelo acertou um caso positivo.
- **TN (True Negative)**: o modelo acertou um caso negativo.
- **FP (False Positive)**: o modelo indicou positivo quando era negativo.
- **FN (False Negative)**: o modelo indicou negativo quando era positivo.

### Como se divide os dados de acordo com o grupo

1) Dados de treino
	1) Separar uma parte dos dados históricos para testar
	2) 70% dos dados
2) Dados de validação
	1) Dados para verificar o resultado do modelo
3) Dados de teste
	1) Dados para testar o modelo, não podem ser os mesmos dados utilizados no treino
	2) 30% dos dados

### Validação cruzada

Divide os dados em vários conjuntos menores

![[section-2-cross-validation.png]]

---

### Overfitting

Ocorre quando o modelo se ajusta bem aos dados de treinamento, mas não generaliza bem para novos dados.

### Underfitting

Ocorre quando o modelo não se ajusta bem nem aos dados de treinamento.


---

## Algoritmos

### Algorítimo de regressão

Sua principal função é realizar previsões numéricas com base em dados históricos.

---

### IRIS 

IRIS é um conjunto de dados típico para aprendizado de ML.


---

## Role Play