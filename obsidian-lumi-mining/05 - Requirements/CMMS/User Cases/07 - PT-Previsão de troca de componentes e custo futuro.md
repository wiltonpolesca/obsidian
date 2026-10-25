# UC-07 — Previsão de troca de componentes e custo futuro

## Fase de entrega

Decisão do negócio: a previsão (cálculo, relatórios e planejamento) será entregue em **fase posterior**. A primeira versão deve registrar os dados de base: vida útil esperada por item e modelo, leituras de horímetro/odômetro e uso acumulado (UC-06), perfil de uso por equipamento e custo de reposição vindo do ERP.

## Objetivo

Estimar quando cada componente rastreável atingirá o fim da vida útil e quanto custará substituí-lo no curto, médio e longo prazo, para subsidiar o planejamento de manutenção, de estoque de reposição e do orçamento dos próximos trimestres e anos.

## Princípio

A previsão combina três informações:

1. **Vida útil do componente**, medida em horímetro ou odômetro (decisões 6 e 9 do [[00 - PT-Visão do fluxo e decisões pendentes|UC-00]]): intervalo esperado de troca e uso acumulado já consumido, vindos do histórico do [[06 - PT-Registro e ciclo de vida dos componentes|UC-06]].
2. **Projeção de uso do equipamento:** estimativa das horas (ou km) que cada máquina vai acumular ao longo do tempo.
3. **Custo de reposição:** custo do material vindo do ERP e custo de mão de obra (horas × valor-hora), conforme decisão 8.

Horas restantes do componente ÷ uso diário projetado da máquina = data prevista da troca. Cada troca prevista é valorada e agregada por período.

## Atores

- **Principal:** planejador de longo prazo / planejador de manutenção.
- **Apoio:** responsável por estoque (previsão de reposição) e gestão/finanças (orçamento).

## Pré-condições

- Os componentes têm identificador único, vida útil esperada e uso acumulado registrado (UC-06).
- Os equipamentos têm leituras de horímetro/odômetro validadas e um perfil de uso.
- Há custo de reposição disponível (ERP) e valor-hora cadastrado.

## Fluxo principal

1. O planejador define o horizonte (por exemplo, trimestres e anos) e o escopo (mina, unidade, frota, modelo, equipamento).
2. O CMMS calcula, para cada componente instalado, as horas de vida restantes (vida esperada − uso acumulado, incluindo períodos anteriores).
3. O CMMS projeta o uso futuro de cada equipamento a partir do perfil de uso configurado. Quando houver leituras recentes, o perfil pode ser recalibrado por elas.
4. O CMMS calcula a data prevista de cada troca e gera as ocorrências futuras (troca prevista). Componentes já vencidos aparecem destacados, sem duplicar custo de troca já realizada.
5. O CMMS valora cada ocorrência: material (custo do ERP, com escalonamento opcional por período) e mão de obra (horas estimadas × valor-hora). Também registra a paralisação estimada, quando informada.
6. O CMMS consolida o resultado por período (mês, trimestre, ano), por equipamento, modelo, frota e tipo de custo, e mostra a quantidade de unidades de reposição necessárias (rotables) por período.
7. O planejador revisa, ajusta premissas (uso, custo, reagendar ou excluir ocorrências) e exporta ou consulta o relatório. As edições manuais ficam identificadas.
8. Quando o uso real se afasta do projetado, ou quando uma troca é feita antes ou depois do previsto, o CMMS recalcula a projeção.

## Fluxos alternativos e exceções

- **Componente sem vida útil esperada cadastrada:** não entra no cálculo e aparece em lista de pendências de cadastro.
- **Equipamento sem perfil de uso ou sem leitura recente:** o cálculo usa o perfil padrão do modelo, com alerta de baixa confiança.
- **Componente vencido:** destacado e tratado separadamente; o planejador decide a data.
- **Componente reparável (rotable):** a previsão considera a reentrada da unidade recondicionada em estoque, de modo que a necessidade líquida de compra não duplique unidades.
- **Mudança de custo de reposição:** o custo da ocorrência futura é recalculado com o valor mais recente recebido do ERP; custos já realizados não são alterados.
- **Troca antecipada ou adiada:** a troca real (UC-04) substitui a ocorrência prevista e reinicia a vida do componente novo.

## Resultado esperado

Previsão de trocas e de custos por período e escopo, com premissas visíveis e rastreáveis, apoiando o orçamento e o estoque de reposição.

## Critérios de aceitação

- A previsão usa a vida útil medida pelo horímetro/odômetro do componente e a projeção de uso do equipamento.
- Cada ocorrência prevista mostra componente, equipamento, data prevista, custo de material, custo de mão de obra e premissas usadas.
- O resultado pode ser agrupado por mês, trimestre e ano, e por equipamento, modelo e tipo de custo.
- A previsão é recalculada quando o uso real, a troca real ou o custo mudam.
- Custo de material vem do ERP, que é a fonte da verdade; o CMMS não gere custo externo.
- Componentes sem dados suficientes são listados, e não ignorados silenciosamente.

## Fora do escopo nesta etapa

Aprovação de orçamento, versões, cenários *what-if* e comparação previsto × realizado × forecast. Esses itens usam esta previsão como base e estão descritos em [[Análise documental e matriz de rastreabilidade]].

## Referências

- [[Análise documental e matriz de rastreabilidade]] — seção "Previsão de troca de componentes e custo futuro" com as fontes do AMT.
- [[06 - PT-Registro e ciclo de vida dos componentes]] — fonte do uso acumulado.
- [[04 - PT-Atendimento da demanda de manutenção]] — origem das trocas realizadas.
