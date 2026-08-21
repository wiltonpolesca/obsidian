# 03 - Estudo de algoritmos de machine learning
## Como prever?

`previsão = intreseccão + (INCLINAÇÃO * VALOR A PREVER)`

- Quanto vai custar um cliente com 56 anos de idade?
`X = -558,94 + (61,86 * 56)` (Valores obtidos no vídeo 19 16m00s)
`X = 2.905,22`

## Outros elementos a estudar

- A linha de regressão é uma generalização, é um ajuste nos dados, geralmente não teremos valores sobre a linha.
	- A diferença entre o valor real e o valor em cima da linha de generalização se chama `resíduo`
	- O `resíduo` é zero sobre a linha, positivo acima da linha e negativo abaixo da linha
	- Quando se utiliza um valor na linha de regressão, e este valor não é originalmente nesta posição, temos o `valor ajustado`
Exemplo:
        ![[section-3-linha-de-regressão.png]]
## Condição: Correlação

- Moderada ou forte
- Coeficiente de Determinação (R<sup>2</sup>)
	- > 0.7: ótimo
	- Entre eles: ? (tem que avaliar, provavelmente não é um bom modelo)
	- 0 e 0.3: Ruim
- Residuais padronizados
	- Próximos de uma distribuição normal
		- Histograma
		- Diagrama de normalidade
		- Teste de Shapiro-Wilk
- Simples e Múltipla
	- Simples
		- Uma variável explanatória para prever uma variável dependente
		- Y ~ X
	- Múltipla
		- Duas ou mais variáveis exploratórias para prever uma variável dependente
		- Y ~ X<sub>1</sub> + X<sub>2</sub> + X<sub>n</sub> 
		- Analisar cada X com cada Y
			- Analisar cada variável independente com y independente
			- Gerar gráficos de dispersão individuais
			- Buscar redundâncias (mesmos efeitos de x sobre y)
		- Coeficiente de determinação (R<sup>2</sup>)
			- Lembrando que R<sup>2</sup> é o percentual de variação da variável de resposta que é explicado pelo modelo
			- Quando se colocam mais variáveis no modelo, a tendência é que R<sup>2</sup> aumente, mesmo que a adição da variável não aumente a precisão do modelo
			- Para isso, utiliza-se R<sup>2</sup>ajustado, que ajusta a variação do modelo de acordo com o número de variáveis independentes que é incluída no modelo
			- R<sup>2</sup>ajustado vai ser sempre menor que R<sup>2</sup>
- Colinearidade e Parcimônia
	- **Colinearidade**: duas variáveis independentes que são correlacionadas
	- Incluir variáveis independentes colineares pode prejudicar o modelo, criando previsões não confiáveis.
	- **Parcimônia**: não colocar variáveis que não melhorem o modelo em nada: criar modelos parcimoniosos
- Requisitos básicos
	- Linearidade entre a variável dependente e as variáveis independentes
	- Pouca ou nenhuma colinearidade
- Resíduos
	- Próximos a distribuição normal
	- Variância constante em relação a linha de melhor ajuste
	- Independentes (sem padrão)
- Correlograma (forma de verificar a correlação entre as variáveis)