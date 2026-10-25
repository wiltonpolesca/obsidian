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

**Relatório de disponibilidade para reposição (objetivo prático):** a partir de uma data de referência e de um horizonte (hoje, 3 meses, etc.), o CMMS informa quais equipamentos precisarão de qual componente e se há saldo disponível em estoque. Exemplo: o equipamento X precisará do componente Y em 3 meses e há unidade em estoque; o equipamento Z precisará do componente D em 2 meses e não há unidade disponível. Assim a mina pode adquirir o material com antecedência e evitar paradas operacionais.

**Vida útil:** definida em horas por componente. Alguns componentes podem ser reformados, o que amplia a vida útil, e **não há limite de reformas**; outros não são reformáveis e, ao fim da vida, são descartados. A regra da vida útil após cada reforma está decidida: o cadastro do componente é atualizado com a nova vida útil em horas, e todas as vidas úteis anteriores ficam guardadas em histórico. O uso acumulado é a soma das horas em todos os equipamentos em que o componente foi instalado.

**Vencimento de componentes:** componentes que têm data de vencimento (por exemplo, por validade) têm essa data controlada pelo CMMS. O sistema notifica a aproximação do vencimento a 90, 60, 30, 15 e 10 dias e, depois de vencido, mostra a indicação de forma clara. Por padrão o uso do componente vencido **não é impedido**; o cliente pode configurar explicitamente a interdição do uso de componentes vencidos. A previsão considera o vencimento, além da vida útil em horas.

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
3. O CMMS projeta o uso futuro de cada equipamento. Proposta inicial: média diária dos últimos 90 dias a partir das leituras validadas, com ajuste manual identificado pelo planejador e perfil padrão do modelo quando faltar histórico (alerta de baixa confiança). Perfil sazonal ou plano da mina são evolução.
4. O CMMS calcula a data prevista de cada troca e gera as ocorrências futuras (troca prevista). Componentes já vencidos aparecem destacados, sem duplicar custo de troca já realizada.
5. O CMMS valora cada ocorrência: material (custo do ERP, com escalonamento opcional por período) e mão de obra (horas estimadas × valor-hora). Também registra a paralisação estimada, quando informada.
6. O CMMS consolida o resultado por período (mês, trimestre, ano), por equipamento, modelo, frota e tipo de custo, e mostra a quantidade de unidades de reposição necessárias (rotables) por período.
7. O CMMS compara a necessidade prevista de cada componente, por equipamento e data, com o saldo disponível nos estoques da mina (e reservas), e sinaliza as faltas para ação preventiva de aquisição.
8. O planejador revisa, ajusta premissas (uso, custo, reagendar ou excluir ocorrências) e exporta ou consulta o relatório. As edições manuais ficam identificadas.
9. Quando o uso real se afasta do projetado, ou quando uma troca é feita antes ou depois do previsto, o CMMS recalcula a projeção.

## Fluxos alternativos e exceções

- **Componente sem vida útil esperada cadastrada:** não entra no cálculo e aparece em lista de pendências de cadastro.
- **Equipamento sem perfil de uso ou sem leitura recente:** o cálculo usa o perfil padrão do modelo, com alerta de baixa confiança.
- **Componente vencido (data ou vida):** destacado de forma clara, sem bloquear o uso por padrão; o bloqueio depende de configuração explícita do cliente. O planejador decide a data de troca.
- **Componente reparável (rotable):** a previsão considera a reentrada da unidade recondicionada em estoque, de modo que a necessidade líquida de compra não duplique unidades.
- **Mudança de custo de reposição:** o custo da ocorrência futura é recalculado com o valor mais recente recebido do ERP; custos já realizados não são alterados.
- **Troca antecipada ou adiada:** a troca real (UC-04) substitui a ocorrência prevista e reinicia a vida do componente novo.

## Resultado esperado

Previsão de trocas e de custos por período e escopo, com premissas visíveis e rastreáveis, apoiando o orçamento e o estoque de reposição.

## Critérios de aceitação

- A previsão usa a vida útil medida pelo horímetro/odômetro do componente e a projeção de uso do equipamento, e inclui tarefas preventivas e todos os custos que o CMMS consegue prever; custos fora do escopo do CMMS são excluídos.
- Para um horizonte escolhido, o relatório indica por equipamento e componente se a necessidade prevista está coberta pelo estoque ou em falta.
- Se o ERP não tiver o custo de um item, o custo informado manualmente pelo usuário é usado e identificado como tal.
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
