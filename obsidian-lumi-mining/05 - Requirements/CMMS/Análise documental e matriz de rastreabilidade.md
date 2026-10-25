# Análise documental e matriz de rastreabilidade — CMMS

## Objetivo e método

Comparar os casos de uso atuais do CMMS com as referências da pasta `Maintenance Asset Management`, localizar evidências relevantes e registrar lacunas e decisões para os requisitos de software.

A análise foi realizada localmente. O inventário encontrou 150 arquivos: 144 documentos extraídos por texto (107 PDF, 30 planilhas XML `.xls`, 3 DOCX, 2 XLSX, 1 PPTX e 1 clipping de texto), quatro arquivos com extensão `.png` que na verdade são PDFs rasterizados sem texto extraível, e dois JPEGs idênticos. Os documentos textuais foram extraídos com marcadores de página, parágrafo, slide ou linha de planilha. A deduplicação por conteúdo identificou 39 cópias exatas, totalizando 111 fontes únicas: 108 fontes textuais e três recursos visuais. Os PDFs `.pdf` tinham texto extraível; as páginas rasterizadas e o cartaz JPEG não passaram por OCR.

Foi feita busca textual no corpus completo e leitura dirigida das referências que descrevem componentes serializados, mudanças em ordens de serviço, localização/estado e relatórios. Não foi necessário criar uma base RAG para a análise de componentes: a extração local, a deduplicação e a busca por texto com referências verificáveis foram suficientes. Depois, para o tema financeiro, foi criada a base híbrida (semântica + BM25) em [CMMS_RAG](<../CMMS_RAG/README.md>), restrita a `Maintenance Asset Management`. A análise não reproduz nem presume que a funcionalidade do produto AMT seja uma regra da Lumi Mining. Manuais de produto, referências de framework e exemplos de implantação são evidências de referência; políticas da mina e decisões de negócio continuam precisando de validação.

## Inventário resumido

| Pasta | Arquivos | Extraídos por texto | Conteúdo principal |
|---|---:|---:|---|
| `AMT_Reference` | 75 | 72 | Manuais AMT, release notes, treinamento, relatórios, integração e referências AMF; há cópias idênticas de documentos na pasta de framework. |
| `Asset Management Framework Reference` | 39 | 36 | PDFs de framework, dicionários de interface e documento de criticidade de sobressalentes; inclui dois PDFs rasterizados com extensão `.png` e um JPEG. |
| `Asset Management Product Reference` | 31 | 31 | Hierarquia de menus XLSX e 30 tabelas administrativas em formato SpreadsheetML `.xls`. |
| `Field Solutions` | 4 | 4 | PDFs de soluções/oficinas de campo. |
| `Meetings_MoM` | 1 | 1 | Apresentação de estrutura e roadmap do CMMS LumiMining. |
| **Total** | **150** | **144** | **111 fontes únicas após remoção de 39 cópias exatas; quatro PDFs rasterizados com extensão `.png` e dois JPEGs sem OCR.** |

As versões foram identificadas pelos nomes/conteúdo onde disponíveis (por exemplo, AMT 8.26 e release notes 8.16–8.27). O inventário não presume uma ordem de autoridade entre revisões sem confirmação do responsável pelo acervo.

## Evidências relevantes

| Fonte | Evidência observada | Uso nesta análise |
|---|---|---|
| [LumiMining CMMS — Estrutura Asset Management, slides 4, 6, 10–12](<./Maintenance Asset Management/Meetings_MoM/LumiMining_CMMS_Estrutura_Asset Management.pptx>) | A proposta para discussão já cita identidade de componentes serializados e histórico de instalação/remoção/recuperação; coloca componentes serializados numa etapa de planejamento/controle e recuperação/Core Tracker como expansão a detalhar. Também propõe CMMS como dono do fluxo/ordens/histórico e estoque/ERP conforme o sistema mestre do cliente. | Evidência específica do produto LumiMining e da necessidade de separar requisito funcional, fronteira de integração e fase de entrega; o deck é proposta, não aceite de escopo. |
| [AMT Handbook iSolutions, parágrafos 288–299](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/AMT_Handbook_iSolutions.docx>) | Descreve acompanhamento de componentes reparáveis/trocáveis (rotables) ao longo da vida, histórico, estado/localização, componentes serializados, integração com manutenção e relatórios de estoque/reconstruções. | Referência para tratar o componente individual como entidade rastreável, além do material consumido numa OS. |
| [AMT 8.26 — Work Execution and Finalisation, pp. 43 e 45–47](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Work Execution and Finalisation - RPM Training.cleaned.pdf>) | P. 43: troca temporária Swing In/Out e previsão da reinstalação por data ou uso. P. 46: número de série removido e instalado em campos separados e consulta do histórico por número de série. P. 47: registro de componente serializado em várias ordens/equipamentos e consulta da vida histórica. | Evidência de eventos de entrada/saída, relação de troca temporária e histórico que acompanha o componente entre ativos. |
| [AMT Release Notes 8.16–8.27, pp. 4–5 e 13](<./Maintenance Asset Management/AMT_Reference/AMT_Release Notes/AMT Release Notes 8.16_8.27.pdf>) | Descreve campos separados para número de série de entrada/saída, cálculo de vida que considera instalações anteriores e controles configuráveis para compatibilidade do componente com a tarefa e para evitar uso simultâneo em outro ativo. | Reforça que o histórico deve acumular períodos anteriores e que prevenção de incompatibilidade/dupla instalação é uma regra configurável a validar. |
| [Critical Equipment.docx, parágrafos 35–56 e 64–76](<./Maintenance Asset Management/Asset Management Framework Reference/Critical Equipment.docx>) | É uma diretriz de criticidade de sobressalentes: relaciona risco do ativo e consequência da indisponibilidade; declara inventário, compras e armazenagem como processos fora do escopo da própria diretriz. | Ajuda a não confundir prioridade da manutenção com criticidade de estoque; a classificação e os processos de supply chain precisam de validação local. |
| [AMT User Reports.xlsx](<./Maintenance Asset Management/AMT_Reference/AMT_Reporting/AMT User Reports.xlsx>) | Na aba `Sheet1`, o catálogo descreve Component Status (linha 120), Component History (linha 347) e Forecast Rotables Stock (linha 516); o relatório Component History lista detalhes técnicos das trocas e o forecast reporta disponibilidade mensal. | Evidência de consulta histórica e visões de estado/estoque que não aparecem nos casos de uso atuais. |
| [Hierarquia de menus AMT](<./Maintenance Asset Management/Asset Management Product Reference/00 - AMT_Menu_Hierarquia.xlsx>) | Na aba `AMT Menu`, lista Serialised Component Manager (linha 266), Component Status (linha 327) e Component History (linha 456). | Corrobora que cadastro, estado e histórico são superfícies funcionais distintas; não define quais devem entrar no escopo Lumi. |

## Matriz de rastreabilidade

Estado da cobertura refere-se aos casos existentes antes das atualizações feitas junto com esta análise.

| Requisito/evidência | Casos atuais relacionados | Cobertura anterior | Lacuna e encaminhamento |
|---|---|---|---|
| Identificar componente removido e instalado durante o serviço | [[04 - PT-Atendimento da demanda de manutenção]] | Parcial: já pedia identificação de ambos “quando disponível”, condição e destino, mas não definia eventos completos nem série de entrada/saída. | Tornar explícitos os eventos de instalação/remoção, os campos de rastreabilidade e o vínculo com o histórico do componente. Atualizado em [[04 - PT-Atendimento da demanda de manutenção]]. |
| Preservar histórico por número de série entre diferentes equipamentos | [[04 - PT-Atendimento da demanda de manutenção]]; [[00 - PT-Visão do fluxo e decisões pendentes]] | Ausente: a associação estava limitada ao atendimento atual e não definia consulta da vida do componente em diferentes ativos. | Criar o caso transversal [[06 - PT-Registro e ciclo de vida dos componentes]] para linha do tempo por componente, equipamento e posição. |
| Controlar troca temporária enquanto um componente está em reparo | [[03 - PT-Tratamento inicial da demanda solicitada]] e [[04 - PT-Atendimento da demanda de manutenção]] | Ausente: não descrevia vínculo entre a unidade retirada, a substituta temporária e a previsão de retorno. | Registrar os dois movimentos separadamente e relacioná-los; prever data ou leitura de uso para o retorno quando definida. Atualizado em [[03 - PT-Tratamento inicial da demanda solicitada]] / [[04 - PT-Atendimento da demanda de manutenção]] e detalhado em [[06 - PT-Registro e ciclo de vida dos componentes]]. |
| Calcular duração de cada período de instalação e vida acumulada | [[04 - PT-Atendimento da demanda de manutenção]] e [[05 - PT-Liberação do equipamento para a operação da mina]] | Ausente: não definia o início/fim do período, a leitura operacional ou a agregação de instalações anteriores. | Fechar período na remoção, abrir novo período na reinstalação, calcular duração por data/hora e agregar os períodos anteriores; permitir variação de horímetro/odômetro quando disponível. |
| Registrar retorno de reparo/recondicionamento e reinstalação | [[03 - PT-Tratamento inicial da demanda solicitada]] / [[04 - PT-Atendimento da demanda de manutenção]] / [[05 - PT-Liberação do equipamento para a operação da mina]] | Parcial/ausente: havia condição e destino do componente removido, mas não um evento de restauração nem sua localização/estado antes da próxima instalação. | Registrar restauração com resultado como evento próprio; a reinstalação abre outro período sem alterar o anterior. |
| Consultar localização e estado atual, movimentos e histórico | Casos [[00 - PT-Visão do fluxo e decisões pendentes]] a [[05 - PT-Liberação do equipamento para a operação da mina]] | Parcial: o histórico geral da solicitação é previsto, mas não uma consulta por componente nem uma localização atual derivada dos movimentos. | [[06 - PT-Registro e ciclo de vida dos componentes]] exige consulta cronológica por identificador/componente, equipamento, posição, estado/localização e períodos de uso. |
| Controlar compatibilidade e instalação simultânea | [[03 - PT-Tratamento inicial da demanda solicitada]] / [[04 - PT-Atendimento da demanda de manutenção]] / [[06 - PT-Registro e ciclo de vida dos componentes]] | Não definido. | Validar se o sistema deve impedir ou alertar quando o componente não corresponde à tarefa/equipamento/posição ou já consta instalado em outro ativo; definir critérios e exceções aprovadas. |
| Controlar estoque, previsão de rotables, reconstrução e integrações | [[03 - PT-Tratamento inicial da demanda solicitada]] e [[00 - PT-Visão do fluxo e decisões pendentes]] | Não definido. | Não ampliar silenciosamente o escopo: confirmar se o CMMS deve controlar estoque/reparos e previsões ou se manterá apenas a trilha técnica; definir integração com almoxarifado/ERP. |
| Definir fase e limite do escopo de componentes | [[00 - PT-Visão do fluxo e decisões pendentes]] e [[06 - PT-Registro e ciclo de vida dos componentes]] | A apresentação de 15/10/2026 menciona histórico de instalação/remoção/recuperação, mas posiciona a gestão de componentes e a recuperação em etapas distintas do roadmap proposto. | Confirmar o mínimo de rastreabilidade necessário desde a primeira versão e quais funções de gestão de rotables/recuperação ficam para uma fase posterior. Não tratar a apresentação como escopo aprovado. |
| Tratar preventiva, inspeção e condição como outras origens de demanda | [[01 - PT-Usuário reporta uma falha no equipamento]] | Os casos atuais cobrem principalmente relato corretivo de falha; a apresentação também lista inspeção, preventiva e condição como gatilhos do fluxo. | Confirmar se essas origens fazem parte desta entrega ou se exigem casos de uso separados. |
| Registrar relato, triagem, segurança, execução e validação da solicitação | [[01 - PT-Usuário reporta uma falha no equipamento]] a [[05 - PT-Liberação do equipamento para a operação da mina]] | Coberto em nível de fluxo pelos casos atuais; a documentação de produto não substitui regras locais do CCO, segurança ou autoridade para liberar equipamentos. | Manter esses fluxos como baseline e validar regras operacionais locais separadamente. |

## Mapeamento financeiro: orçamento, previsão, previsto vs. realizado e tipos de custo

Esta seção cobre uma lacuna da primeira versão da análise, que tratava de componentes. Foi construída com a base RAG semântica em `../CMMS_RAG` (somente `Maintenance Asset Management`) e leitura integral do manual de Budgeting & Forecasting. Citações de páginas do Help File referem-se ao índice de página do PDF (o rodapé impresso é uma página acima). Tudo abaixo descreve o comportamento do AMT como **referência**; não é regra aprovada da Lumi Mining.

### Cobertura atual dos casos de uso

Os casos 00–06 **não** definem requisitos financeiros. Apenas citam custo como pergunta aberta (em [[00 - PT-Visão do fluxo e decisões pendentes]], item 4 sobre aprovação por orçamento e item 8 sobre métricas de custo). O deck de 15/10/2026 cita o tema em alto nível: slide 8 ("planejado versus realizado, apropriação e conciliação com o ERP"), slide 9 (desvios de custo, orçamento e previsão; separar previsão calculada de valor realizado) e slide 12 (custos em "Planejamento e controle" e orçamento/previsões em "Gestão de longo prazo").

### Modelo conceitual no AMT: quatro "versões" do custo

| Conceito | Definição na referência | Origem do dado | Fonte |
|---|---|---|---|
| **Projeção (previsto, ciclo de vida)** | Custos futuros por tarefa de estratégia, calculados a partir de frequência, custo estimado, uso e vida do equipamento. Existem a projeção *Current* e projeções *Alternate* (cenários "what-if"). | Estratégia de manutenção + perfil de uso. | [Help File, pp. 378–379](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>); [Budgeting & Forecasting, pp. 32–36](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>) |
| **Orçamento (budget)** | Fotografia (*snapshot*) da projeção para um período, versionada, com status e escopo por equipamento e centro de custo. Alterações no orçamento **não** retornam ao AMT "vivo", e mudanças no AMT vivo não atualizam o orçamento automaticamente. | Importação de equipamentos reais e de modelagem, mais overheads, capex e manpower. | [Help File, pp. 659–660](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>); [Manual B&F, pp. 6–7, 9, 12](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>) |
| **Realizado (actuals)** | Custo real de peças, mão de obra e diversos (*Parts/Labour/Misc*) vindo de **work order settlements** (liquidações de OS) importadas do ERP, ou criadas manualmente. Valores reais aparecem em azul no orçamento e não podem ser editados. | ERP (interface de settlement e de GL) ou lançamento manual. | [Help File, pp. 579–581](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>); [Manual B&F, p. 15](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>) |
| **Forecast (reprojeção)** | No AMT, "forecast" é um **orçamento nomeado** que mistura realizado até o mês corrente e projetado dali em diante (ver rotinas de atualização abaixo). Há também o "Live Forecasting" (Forecast Worksheet) baseado em dados vivos. | Rotinas *Replace costs with actuals/current projection* e *Replace actual costs to Month 'x'*. | [Help File, pp. 670–672](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>); [Hierarquia de menus](<./Maintenance Asset Management/Asset Management Product Reference/00 - AMT_Menu_Hierarquia.xlsx>) |

O orçamento do AMT cobre custo **direto de manutenção** dos ativos. No desenho do cliente Mopani, a decisão registrada foi "AMT produz orçamento de custos diretos e não de overheads de manutenção" ([Mopani Solution Design, p. 53](<./Maintenance Asset Management/AMT_Reference/AMT_Client Design/Mopani  - AMT Solution Design 27082024 v.pdf>)); na Glencore, custos reais de overhead e de mão de obra não são importados do SAP, apenas as horas reais (digitadas por escriturários), com reconciliação mensal manual entre AMT e SAP ([Glencore Solution Design, p. 11](<./Maintenance Asset Management/AMT_Reference/AMT_Client Design/Glencore - AMT Solution Design and Deployment Approach V1.0 20190828.cleaned.pdf>)). Isso mostra que a fronteira com o ERP é uma decisão por cliente.

### Processo de orçamento

1. **Pré-requisitos** de dados saudáveis: estratégia que prevê 100% dos custos esperados, plano de longo prazo atualizado, uso/termo confirmados, settlements importados e vinculados, equipamentos futuros com preço e data de compra, e abordagem de orçamento acordada ([Manual B&F, p. 7](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>); [Help File, p. 659](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>)). O *Health Assessment* verifica orçamento, projeção atual (realizado e projetado), utilização, escalonamento, *standard jobs*, problemas de manutenção de estratégia, rotables e financeiros de contrato ([Health Assessment, p. 6](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Health Assessment - RPM Training Manual.cleaned.pdf>)).
2. **Criar o orçamento**: cenário, versão, tipo (define o número de períodos), ano, mês inicial/final, **moeda** (todos os custos importados são convertidos) e grupo de mensagens (notificado a cada mudança de status). O processamento é enfileirado e refeito até três vezes; falha final grava em tabela de erros ([Help File, pp. 659–660](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>)).
3. **Ajustar**: usos, custos por ocorrência, reagendar/excluir/criar ocorrências, downtime, horas de mão de obra e taxas, risco, códigos financeiros em lote, overheads, capex, manpower, receita de plant hire e **escalonamentos** (aritméticos, não compostos, por peças/mão de obra/diversos e por período; só afetam custos projetados e não são reversíveis a não ser por novo fator). Edições manuais ficam em vermelho e comentários em verde ([Manual B&F, pp. 15–30, 35](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>); [Help File, p. 666](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>)).
4. **Recalcular** (status de cálculo "Required" → "OK") e **aprovar** por fluxo de status.
5. **Exportar** custos e horas por equipamento, centro de custo, elemento de despesa e mês, inclusive para o EPF (Enterprise Planning Framework); a exportação marca o orçamento como *Exported* ([Manual B&F, pp. 7, 41](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>)).

**Status e governança.** O fluxo observado é In Progress → For Review → For Authorisation → Authorised (ou Revoked) → Exported, e o desenho Mopani usa "Locked". Os status e as transições são **configuráveis** na tabela *Budget Status*; cada usuário tem permissão por status; alguns status são somente leitura; há trilha de alterações (*Budget Change History*) e comentários ([Manual B&F, pp. 6–7, 10](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>); [Help File, p. 666](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>); [Mopani, p. 52](<./Maintenance Asset Management/AMT_Reference/AMT_Client Design/Mopani  - AMT Solution Design 27082024 v.pdf>)). A visibilidade do orçamento também segue as permissões de equipamento e centro de custo do usuário; dados de outros usuários aparecem em itálico e somente leitura.

### Previsto vs. realizado vs. forecast

| Necessidade | Como a referência trata | Relatórios/funções | Fonte |
|---|---|---|---|
| Comparar realizado do mês, acumulado do ano financeiro e projetado do ano contra o orçamento | Compara contra um orçamento criado no módulo de Budgeting (somente esses). | Budget Compliance (Rpt_494) | [Help File, p. 671](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Comparar orçamento, forecast e dados vivos | "Forecast" é um orçamento nomeado. Comparação por centro de custo (atividade, local, responsabilidade), elemento de despesa, categoria e *cost bearer*. | Budget Forecast Performance (Rpt_540); Budget Equipment Cost Analysis (Rpt_541); Budget Component Performance (Rpt_543: período do orçamento vs. realizado até a data vs. projetado futuro vs. total projetado) | [Help File, pp. 672–673](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Comparar duas versões de orçamento | Só compara períodos sobrepostos. Mede variação por mês/trimestre/ano e por MTD/YTD. | Cost Analysis, Cost Period Analysis, Cost Variance Analysis, YTS Comparison, Strategy Task Variance Analysis | [Help File, pp. 669–670](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>); [Manual B&F, pp. 36–37](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>) |
| Separar efeito de utilização do efeito de custo | Copia o orçamento aprovado, substitui o uso previsto pelo real (*Replace usage with actuals*), recalcula e compara; a diferença é atribuída à utilização. Recomendado apenas quando necessário. O relatório Strategy Task Variance Analysis distingue mudança de uso, falha precoce e custo puro. | Rotinas de atualização avançadas | [Manual B&F, pp. 38–39](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>); [Help File, p. 670](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Atualizar o forecast com o realizado | *Replace costs with actuals/current projection* substitui custos até a data e futuros. *Replace actual costs to Month 'x'* limita ao mês anterior. Pode duplicar custo quando a tarefa foi planejada em um mês e executada em outro (ex.: motor previsto em agosto e feito em julho). | Rotinas de atualização avançadas | [Help File, pp. 670–671](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Variação de ciclo de vida (orçamento de vida vs. realizado vs. projetado) | Quatro tipos de variação: negativa, positiva, realizado sem orçamento e orçamento sem realizado. Cada uma exige análise de causa. **PCV** (Projection Cost Variance) mostra estouro projetado frente à linha de base. | Life Cycle Cost Summary (Rpt_188), PCV Chart (Rpt_217), Costs Analysis to Date, Strategy Task Analyser, Work Order Settlement Interrogation | [Help File, pp. 378–379](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Gestão por exceção | KPIs Quick Watch: variação de custo da OS (% e valor mínimo, exemplo US$ 10 mil), custo alto (valor mínimo em OS não estratégica), mudança de PCV, **variação anual de custo** (exige o módulo de orçamento e um orçamento contábil ligado ao site) e mudança de custo no ano financeiro. | Quick Watch | [Quick Watch, pp. 5–6](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Quick Watch - RPM Training Manual.cleaned.pdf>) |
| Processo de análise periódica | Criar periodicamente um orçamento "ACTUALS" do ano financeiro, comparar com o orçamento base acordado, identificar variações-chave, determinar causa-raiz, atualizar projeções (revisão de estratégia, custos de jobs, custos não atribuídos) e o forecast, e distribuir ao gerenciamento. | Fluxo "Compare Actual to Budget Performance" | [Manual B&F, p. 8](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>) |

**Dependência crítica: qualidade do settlement.** Sem settlements confiáveis e com códigos que casem com a tarefa de estratégia, o AMT não reconhece a ocorrência da tarefa, não projeta a próxima e joga o custo em um balde *unassigned*. Isso degrada previsões de peças, mão de obra, componentes e finanças. Efeitos listados: onda de custos (*bow-wave*), acrual de manutenção pouco confiável, grandes baldes não atribuídos e impossibilidade de análise ([Help File, pp. 579–581](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>)). Tarefas *unassigned* existem justamente para prever custo de trabalho geral por subsistema e capturar custo real fora da estratégia ([Help File, p. 378](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>)).

### Tipos de custo e dimensões financeiras

| Dimensão | Conteúdo observado | Fonte |
|---|---|---|
| **Cost Type** (tabela do sistema) | 1 R&M, 2 Consumables, 3 Tyres, 4 Fuel and Power, 5 Capital, 6 Operator, 7 Other Financial. | [Cost Type.xls](<./Maintenance Asset Management/Asset Management Product Reference/01 - System Administration/01 - System Tables/01 - Maintenance/System Administration - Cost Type.xls>) |
| **Natureza do custo** | Peças, mão de obra e diversos (*Parts / Labour / Misc*); cada uma com valor *Cost@Cost* e *Cost@Sell* (margem, comum em ambiente OEM; caso contrário iguais) e duração real em horas. | [Integration SDK Overview, p. 40](<./Maintenance Asset Management/AMT_Reference/AMT_Integration/AMTIntegrationSDKOverview.pdf>) |
| **Centro de custo** | Agrupa custos por estrutura organizacional; chave para orçamento contábil. Campos CC Activity, CC Location, CC Responsibility alimentam os relatórios. | [System Administration, p. 15](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - System Administration - RPM Training Manual.cleaned.pdf>) |
| **Elemento de despesa** | Categorias contábeis (exemplos: ferramentas, emulsão, aço, combustível). Há padrão por equipamento e por peças, mão de obra e diversos na tarefa; flags para depreciação, custo de propriedade e CBD (depreciação por componente). Deve ser definido pela área financeira. | [System Administration, p. 16](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - System Administration - RPM Training Manual.cleaned.pdf>); [Help File, p. 860](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| **Responsabilidade de custo** | Agrupamento superior de centros de custo, usado em relatórios financeiros e de orçamento. | [System Administration, p. 16](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - System Administration - RPM Training Manual.cleaned.pdf>) |
| **Cost bearer** | Quem arca com o custo; settlements trazem divisão por centro de custo, cost bearer e grupo de trabalho. Em contrato, o custo é mostrado a preço de venda. | [Help File, pp. 578, 904](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| **Categorias de overhead** | Overhead por combinação de categoria, centro de custo e elemento de despesa, com flags *Cost of Sale* e *Capex*; identificador ERP do overhead liga o cronograma ao faturamento. | [System Administration, p. 19](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - System Administration - RPM Training Manual.cleaned.pdf>); [Manual B&F, p. 13](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Budgeting & Forecasting - RPM Training Manual.cleaned.pdf>) |
| **Moeda e câmbio** | Multimoeda: moeda de relatório por site, câmbio da transação (se vier do ERP) ou tabela histórica; atualizar câmbio todo mês. Settlements, jobs padrão, faturamento e custos reais podem estar em várias moedas. A primeira moeda é a primária e não pode mudar depois. | [Key Concepts, p. 37](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Key Concepts - RPM Training Manual.cleaned.pdf>); [System Administration, p. 17](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - System Administration - RPM Training Manual.cleaned.pdf>) |
| **Períodos financeiros** | Calendário contábil convertido para calendário (AAAAMM); relatórios financeiros usam o período contábil. | [System Administration, p. 19](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - System Administration - RPM Training Manual.cleaned.pdf>) |

### Integração com o ERP (realizado)

A referência lista as mensagens: criar pedido de compra (AMT → ERP), **Work Order Details** com status de peças (a tabela do documento indica AMT → ERP, mas a descrição fala em atualizar o AMT a partir do ERP; direção ambígua), **Work Order Details (Actuals)** (ERP → AMT), **Work Order Financial Summary** (settlements) e **General Ledger** (ERP → AMT) para reconciliar custo do AMT com o razão do ERP ([Mopani, p. 63](<./Maintenance Asset Management/AMT_Reference/AMT_Client Design/Mopani  - AMT Solution Design 27082024 v.pdf>)). A mensagem de reconciliação de GL usa ID do razão, número da OS (deve existir no AMT), nota fiscal, modelo e número de série ([Integration SDK Overview, p. 40](<./Maintenance Asset Management/AMT_Reference/AMT_Integration/AMTIntegrationSDKOverview.pdf>)). Um settlement editado manualmente no AMT fica marcado e não tem seus códigos sobrescritos na próxima importação ([Help File, p. 581](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>)). Obs.: a descrição da direção das mensagens vem do desenho do cliente e deve ser confirmada para a Lumi.

### Outros relatórios financeiros (referência)

Budget Summary (equipamento, overhead, capex e manpower), Total Cost Analysis, Total Cost per UOM (custo por hora), Capital Forecast, Headcount Forecast, Budget Change History ([Help File, pp. 666–667](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>)); P&L Forecast e projeção de orçamento/realizado/variação até o fim do prazo (Rpt_206, p. 718); Maintenance Accrual e Maintenance Accrual Details (provisão baseada em receitas e custos futuros, aplicável a contratos MARC; pp. 721–727). Os módulos de contratos/plant hire/MARC são marcados no deck como expansão comercial a validar (slide 11).

### Matriz de rastreabilidade financeira

| Requisito/evidência | Casos atuais | Cobertura | Lacuna e encaminhamento |
|---|---|---|---|
| Custo real da OS (peças, mão de obra, diversos) e vínculo com a tarefa/ocorrência | [[04 - PT-Atendimento da demanda de manutenção]] (registra horas e materiais) | Parcial: não define custo monetário nem a origem (ERP ou CMMS). | Definir fonte mestre do custo realizado, granularidade (peça/hora/serviço) e regra de apropriação; criar caso de uso de **fechamento de custos da OS**. |
| **Previsão de trocas e custo futuro por uso (vida útil do componente × projeção de uso da máquina)** | [[07 - PT-Previsão de troca de componentes e custo futuro]] (novo) e [[06 - PT-Registro e ciclo de vida dos componentes]] (uso acumulado) | **Requisito central, definido no UC-07.** Os casos 00–06 só tinham o histórico. | Registrar desde a primeira versão a vida útil esperada por componente/modelo, o perfil de uso por equipamento e o custo de reposição. Ver a seção "Previsão de troca de componentes e custo futuro". |
| Previsto (estimativa) por serviço/tarefa e custo esperado | [[07 - PT-Previsão de troca de componentes e custo futuro]] (para trocas de componentes) | Parcial: cobre trocas previstas de componentes; não cobre estimativa por serviço padrão. | Decidir se o CMMS mantém custo estimado nos serviços padrão e planos; é pré-requisito de qualquer previsão e comparação. |
| Orçamento versionado com ciclo de aprovação | [[00 - PT-Visão do fluxo e decisões pendentes]] (item 4: apenas pergunta) | Ausente. | Se entrar no escopo, criar caso de uso com cenário/versão/período/moeda, status configuráveis, permissões por status e trilha de auditoria. Fase de longo prazo conforme slide 12. |
| Previsto vs. realizado e variação | [[00 - PT-Visão do fluxo e decisões pendentes]] (item 8: apenas métricas) | Ausente. | Definir indicadores (variação %, valor mínimo, YTD/MTD), períodos e origem antes de exibir. Separar valor calculado de valor realizado (slide 9). |
| Forecast / reprojeção com realizado até a data | Nenhum | Ausente. | Definir se forecast é versão de orçamento e a regra para ocorrências planejadas em um mês e executadas em outro (risco de dupla contagem). |
| Custos não atribuídos (sem tarefa/estratégia) | Nenhum | Ausente. | Definir tratamento de OS corretivas sem tarefa de estratégia e rotina de saneamento. |
| Códigos financeiros: centro de custo, elemento de despesa, tipo de custo, responsabilidade | Nenhum | Ausente. | Obter plano de contas/estrutura do cliente; decidir quais códigos o CMMS recebe do ERP e quais cria. |
| Multimoeda e períodos contábeis | Nenhum | Ausente. | Confirmar necessidade de moeda de relatório, câmbio e calendário fiscal. |
| Reconciliação com ERP/razão | [[00 - PT-Visão do fluxo e decisões pendentes]] (menciona integrações) | Não definido. | Definir mensagens, frequência, chave de conciliação (OS, série, nota fiscal) e quem resolve divergências. |
| Escalonamento de custos e cenários *what-if* | Nenhum | Ausente. | Avaliar apenas na fase de longo prazo. |
| Overheads, capex, manpower, plant hire, contratos/accrual | Nenhum | Ausente; deck marca contratos/locação como expansão. | Fora da primeira versão; validar demanda de mercado antes de detalhar. |

### Decisões pendentes (financeiro)

1. O CMMS será **dono do custo** da manutenção ou apenas consumirá o realizado do ERP? Quem é o sistema mestre de custo, centro de custo e elemento de despesa?
2. O orçamento será de **custo direto de manutenção** por ativo (como no AMT) ou incluirá overhead, mão de obra e capex? A referência mostra clientes que escolheram não orçar overhead.
3. Quais **tipos de custo** a Lumi adotará (a lista do AMT tem sete itens e inclui pneus, combustível/energia e operador, o que pode extrapolar manutenção)?
4. Qual é a **granularidade** e a periodicidade do realizado (por OS, por mês) e a regra de atribuição de custo à ocorrência de tarefa?
5. Quais **status e aprovadores** de orçamento? Quem pode travar, revogar e exportar?
6. Como tratar custo realizado de mão de obra: horas apontadas × taxa, ou custo vindo do ERP (a Glencore importa só horas)?
7. Qual é o horizonte (ano fiscal, vida da mina) e a moeda/câmbio?
8. O que entra na primeira versão (custo da OS e realizado) e o que fica para a fase de longo prazo (orçamento aprovado, versões, variação)? A previsão de trocas e custos por uso (UC-07) é requisito central e **fica para uma fase posterior** (decisão do negócio); a primeira versão deve apenas registrar os dados que a alimentam.

## Previsão de troca de componentes e custo futuro

**Requisito central do sistema** (caso de uso [[07 - PT-Previsão de troca de componentes e custo futuro|UC-07]]). O entendimento do negócio é o seguinte:

1. Cada componente tem vida útil baseada no seu horímetro/odômetro.
2. Com base no uso de cada máquina, é possível estimar as horas de uso ao longo do tempo.
3. Combinando 1 e 2, estima-se o custo de troca de componentes no curto, médio e longo prazo, o que permite planejar o orçamento dos próximos trimestres e anos.

### Evidência na base de conhecimento (AMT)

A abordagem é a mesma do AMT, que a usa como base do orçamento:

| Conceito | Como o AMT trata | Fonte |
|---|---|---|
| Vida útil por uso | *Usage* é uma leitura cumulativa que mede a vida de um ativo ou componente (horas de máquina, toneladas, combustível). Cada tarefa da estratégia tem uma frequência (exemplo: motor a cada 10.000 h, custo de $100.000). | [Help File, pp. 866 e 947](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Projeção de uso da máquina | *Projected Daily Usage* = utilização média anual ÷ dias do ano. Há *Usage Profile* simples ou avançado, e a média dos últimos 90 dias de leituras alimenta a projeção. | [Help File, p. 939](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>); [Data Model Dictionary, p. 65](<./Maintenance Asset Management/AMT_Reference/AMT_Reporting/AMT Reporting Data Models Dictionary 8.26.pdf>); [Mopani Solution Design, p. 20](<./Maintenance Asset Management/AMT_Reference/AMT_Client Design/Mopani  - AMT Solution Design 27082024 v.pdf>) |
| Ocorrências futuras e custo | *Projected Occurrences* geram previsões de componentes, peças, rotables e financeiras. Componentes vencidos (*overdue*) distorcem a previsão e geram trocas desnecessárias se mal tratados. | [Help File, pp. 375 e 939](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Escalonamento do custo | Aumentos por data (exemplo: 5%, 3%, 4%) valoram custos projetados no tempo. | [Help File, p. 866](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Uso como base do orçamento | Mudança significativa do uso é feita no núcleo; as ocorrências são reprojetadas e reimportadas no orçamento. | [Help File, p. 664](<./Maintenance Asset Management/AMT_Reference/AMT_Handbook/8.26 AMT_Help_File_RPMGlobal.pdf>) |
| Planejamento de longo prazo | Processo do planejador de longo prazo, com insumos: estratégia, utilização atualizada, jobs padrão, mão de obra, metas de disponibilidade e monitoramento de condição. | [Manual Long-Term Planning, pp. 6 e 11](<./Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Long-Term Planning - RPM Training Manual.cleaned.pdf>) |
| Previsão de rotables | Relatório *Forecast Rotables Stock*, com disponibilidade mensal. | AMT User Reports.xlsx (linha 516) |

Estas são referências de um produto; fórmulas e premissas precisam ser confirmadas com a mina.

### Dados exigidos desde a primeira versão

Mesmo sem implementar a previsão no início, o modelo deve guardar:

| Dado | Onde |
|---|---|
| Vida útil esperada (em horas ou km) por componente e modelo | Cadastro do componente (`Item`, por `ModeloEquipamento`) |
| Uso acumulado por componente, incluindo períodos anteriores | Períodos de uso (UC-06) |
| Perfil de uso por equipamento (horas por dia projetadas) | Cadastro do equipamento |
| Leituras validadas de horímetro/odômetro | Leituras de medidor (UC-03) |
| Custo de reposição (material) e valor-hora | ERP e cadastro de profissionais (decisão 8) |
| Horas e paralisação estimadas da troca | Plano da troca |

### Regra de cálculo (proposta)

`data prevista da troca = hoje + (vida útil esperada − uso acumulado) ÷ uso diário projetado`

Cada ocorrência é valorada (material + mão de obra) e agregada por período. A troca real substitui a prevista e reinicia a vida do componente novo.

### Pontos a definir

1. Como projetar o uso: média dos últimos 90 dias, plano da mina ou perfil sazonal; quem atualiza e com que frequência.
2. Valor de reposição: último custo, custo padrão ou custo com escalonamento por inflação.
3. Tratamento de vencidos, de vida herdada de instalações anteriores e de componentes reparáveis que voltam ao estoque.
4. Horizonte e agregação (mês, trimestre, ano; por equipamento, modelo, frota, tipo de custo).
5. Se a previsão considera mão de obra e paralisação além do material.
6. ~~Fase de entrega~~ — decidido: a previsão de trocas fica para uma fase posterior; a primeira versão registra vida útil esperada, uso acumulado/leituras de horímetro, perfil de uso e custo de reposição. Orçamento com aprovação, versões e cenários continuam como camada posterior à previsão.

## Recomendação funcional

Manter como requisito de rastreabilidade a identidade do componente, eventos de instalação/remoção/restauração, equipamento/posição, data/hora, responsável, períodos de uso e consulta da vida acumulada entre ativos. A linha de base deve registrar eventos mesmo que controle de estoque e reconstrução ainda não façam parte da primeira versão. Definir a fase de entrega, a compatibilidade obrigatória e os fluxos de estoque/reparo antes de transformar os estados e integrações propostos em regras fechadas.

## Atualizações documentais resultantes

- [UC-03 — Tratamento inicial](<./User Cases/03 - PT-Tratamento inicial da demanda solicitada.md>): planejar componente temporário e previsão de retorno de componente em reparo.
- [UC-04 — Atendimento](<./User Cases/04 - PT-Atendimento da demanda de manutenção.md>): registrar eventos de instalação/remoção, campos de rastreabilidade, períodos de uso e componente enviado para reparo.
- [UC-05 — Liberação](<./User Cases/05 - PT-Liberação do equipamento para a operação da mina.md>): conferir os movimentos de componentes relacionados antes do encerramento.
- [UC-06 — Ciclo de vida dos componentes](<./User Cases/06 - PT-Registro e ciclo de vida dos componentes.md>): novo caso transversal de cadastro, localização, movimentos, restauração, reinstalação, histórico e duração de uso.
- [Visão do fluxo e decisões pendentes](<./User Cases/00 - PT-Visão do fluxo e decisões pendentes.md>): novos termos, regras e perguntas de escopo.

## Decisões já respondidas pelo negócio

As dez decisões do [[00 - PT-Visão do fluxo e decisões pendentes|UC-00]] foram respondidas e refletidas nos casos de uso, no [[Mapa de fluxos do sistema]] e no [[Diagrama de classes (sugestão)]]. Efeito nas decisões abaixo:

- **Resolvidas:** 4 (horímetro/odômetro como medida de vida útil, validado no início dos trabalhos), 8 (o CMMS controla saldo, reserva e previsão; o ERP troca informações comerciais/financeiras e, opcionalmente, baixa de estoque), parte da 1 (itens sem série são consumíveis, sem rastreabilidade individual) e parte da 7 (datas retroativas não afetam o período, pois o horímetro real é o validado na análise preliminar).
- **Ainda aberta:** pesquisa do algoritmo de sugestão de reincidência (provavelmente aprendizado de máquina) e os pontos de definição da previsão de trocas e custos (seção acima e UC-07). Perfis (grupos com permissões por tela e recurso), hierarquia de locais (Mina → Unidade Operacional → Level → Local) e compatibilidade (no cadastro do componente, por modelo de máquina) estão definidos. As dez decisões originais estão respondidas.
- **Financeiro:** o custo da OS fica definido como mão de obra (horas × valor-hora do cadastro de profissionais, ou de sistema interno se integrado) + material/equipamento (custo vindo do ERP). Isso fecha o item 8 financeiro para a primeira versão: custo da OS e realizado via ERP. Orçamento, forecast e variação permanecem como fase futura, sem requisitos.

## Decisões pendentes para validação com manutenção, operação e estoque

1. **Identidade:** número de série é obrigatório para quais classes? Como identificar peças sem serial, itens por lote e unidades reparáveis sem confundir componentes distintos?
2. **Compatibilidade e simultaneidade:** como relacionar componente, modelo, tipo, código/peça e posição? Deve haver bloqueio para instalação incompatível ou duplicada em outro ativo, e quem aprova exceções?
3. **Localização:** qual hierarquia deve ser registrada (equipamento, sistema, posição, oficina, estoque, quarentena, fornecedor)? Como representar transferências e custódia?
4. **Duração de uso:** data/hora é suficiente para o requisito de “por quanto tempo”, ou horímetro/odômetro é obrigatório em classes específicas? Como somar períodos anteriores e tratar leituras divergentes?
5. **Restauração:** o termo significa reparo, reconstrução, recondicionamento ou retorno de estoque? Quais inspeções e aprovações tornam o componente novamente disponível?
6. **Estados e eventos:** quais estados/transições são válidos para instalado, removido, em trânsito, aguardando inspeção, em reparo, disponível e descartado? A lista do [[06 - PT-Registro e ciclo de vida dos componentes]] é proposta, não fechada.
7. **Correções e permissões:** quem pode registrar, aprovar ou corrigir eventos? Como tratar lançamentos retroativos, correções de série e reconciliação de localização?
8. **Escopo de estoque e integração:** o CMMS controla saldo, reserva, compras, reparos e previsão de componentes, ou somente eventos técnicos? Há integração com ERP/almoxarifado e qual sistema é a fonte oficial?
9. **Trocas temporárias:** quem define a previsão de reinstalação e como lidar com mudança da previsão, componente reprovado ou troca definitivamente convertida em substituição?
10. **Fase de entrega e origens de demanda:** quais itens de rastreabilidade entram na primeira versão? Preventivas, inspeções e demandas por condição estão no mesmo escopo dos relatos de falha?

## Limitações

- As referências AMT são documentação de um produto e incluem exemplos/configurações que podem não refletir os processos aprovados para a mina.
- Os documentos de framework, tabelas de sistema, relatórios e exemplos de implantação foram inventariados e pesquisados; as conclusões da matriz usam as fontes que trazem evidência direta para o ciclo de componentes.
- Quatro arquivos nomeados como PNG são páginas PDF rasterizadas; foram reconhecidos pelo conteúdo e inspecionados visualmente, mas não têm camada de texto. Os dois JPEGs são cópias do mesmo cartaz de framework e não passaram por OCR. Os diagramas são referências gerais, não evidência direta de regras de rastreabilidade de componentes.
- Esta análise documenta requisitos funcionais e lacunas; não define arquitetura, esquema de dados, política de estoque nem integração.
