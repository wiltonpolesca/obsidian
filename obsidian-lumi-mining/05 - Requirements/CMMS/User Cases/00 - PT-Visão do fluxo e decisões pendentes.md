# CMMS — Visão do fluxo e decisões pendentes

## Fluxo coberto

1. [[01 - PT-Usuário reporta uma falha no equipamento]] — registro do relato e resposta inicial do CCO.
2. [[02 - PT-Equipe de manutenção analisa problema relatado pelo CCO]] — triagem, prioridade e atribuição.
3. [[03 - PT-Tratamento inicial da demanda solicitada]] — diagnóstico inicial, segurança, planejamento e disponibilidade de recursos.
4. [[04 - PT-Atendimento da demanda de manutenção]] — execução e apontamentos.
5. [[05 - PT-Liberação do equipamento para a operação da mina]] — testes, comunicação e encerramento.
6. [[06 - PT-Registro e ciclo de vida dos componentes]] — registro transversal de identidade, localização, movimentos, restauração e períodos de uso dos componentes.
7. [[07 - PT-Previsão de troca de componentes e custo futuro]] — previsão de trocas e custos por período, com base na vida útil por horímetro e na projeção de uso dos equipamentos; apoia o orçamento e o estoque de reposição.

## Vocabulário recomendado

- **Centro de Controle Operacional (CCO):** sala operacional com visão sistêmica do que ocorre na mina, atendida por diversos operadores e ponto de contato dos operadores em campo, normalmente por rádio e, em algumas situações, por sistema de mensagem embarcado. Nos casos, o CCO é o ponto de contato e encaminhamento; não se presume que seja um sistema integrado ao CMMS.
- **Solicitação / Ordem de serviço (OS):** **são o mesmo registro** (decisão 3). A OS nasce do relato do CCO e agrupa todas as tarefas de trabalho, que ficam ligadas a ela.
- **Tarefa (atividade):** unidade de trabalho dentro da OS, com responsável, estado, estimativa em horas e critério de conclusão.
- **Histórico de componente:** sequência imutável de eventos de instalação, remoção e reinstalação/restauração, vinculada ao componente, equipamento e posição em que foi utilizado.
- **Componente serializado:** componente individual rastreado por número de série. Itens sem série são consumíveis (óleo, filtros): não têm rastreabilidade individual, apenas registro de uso e custo.
- **Disponibilidade técnica:** condição informada pela manutenção após a intervenção e os testes.
- **Liberação operacional:** decisão de retorno à operação, realizada pela autoridade definida pela mina. Não deve ser presumida a partir do encerramento da solicitação.

Use esses termos de forma consistente na interface e nas regras; se o produto não separar solicitação e OS, defina explicitamente que representam o mesmo registro.

## Regras de fluxo recomendadas

- Manter o histórico de alterações de estado, prioridade, responsável, escopo e aprovações, incluindo autor, data/hora e justificativa.
- Rastrear cada instalação, remoção e reinstalação/restauração de componente sem sobrescrever eventos anteriores. Registrar a identificação do componente (incluindo série/lote quando aplicável), equipamento e posição/localização, data/hora efetiva, responsável, motivo, condição e origem/destino do movimento. O período de uso deve ser calculável entre a instalação e a remoção; componentes ainda instalados permanecem com período aberto. Uma recuperação ou recondicionamento e a reinstalação posterior devem ser registradas como eventos distintos, vinculados ao mesmo histórico.
- Registrar a identidade e a localização/estado atual do componente como uma visão derivada dos eventos; uma mudança de localização ou estado não pode apagar o histórico de movimentos.
- Atribuir um responsável pela próxima ação para qualquer item em fila ou aguardando; espera não deve tornar a solicitação invisível.
- Controlar o estado da solicitação/OS separadamente do estado das atividades. Uma OS pode ter atividades concluídas e outras bloqueadas.
- Não permitir início de tarefa sem a confirmação de local seguro e sem as aprovações previstas no fluxo configurado da mina. O CMMS não gerencia procedimentos de segurança.
- Tratar os controles abaixo como **proposta inicial**; como cada mina define seu próprio fluxo (decisões 1 e 4), estados, prioridades e aprovações devem ser **configuráveis** por mina, com um conjunto padrão:
  - OS: `Nova` → `Em triagem` → `Planejada` → `Em execução` → `Em validação` → `Encerrada`;
  - estados de espera: `Aguardando informação`, `Aguardando material` ou `Impedida (local não seguro)`, com motivo e responsável pela próxima ação. O tempo em cada espera é medido em horas (decisão 8);
  - encerramentos excepcionais: `Cancelada` ou `Duplicada`, sempre com justificativa e referência relacionada;
  - atividade: `Não iniciada` → `Em execução` → `Concluída`, com estado `Aguardando/Bloqueada` e motivo quando não puder avançar.

Não tratar esses nomes como requisitos fechados até confirmar as transições, permissões e impactos nos relatórios.

## Decisões tomadas

Respostas do negócio às dez decisões, incluindo o segundo ciclo de esclarecimentos (5, 7, 8 e 9).

| # | Tema | Decisão | Impacto nos casos |
|---|---|---|---|
| 1 | Prioridade e SLA | Estrutura genérica e configurável por mina (critérios e prazos variam até dentro do mesmo grupo). | UC-02 |
| 2 | Segurança | Fora do escopo do CMMS. O sistema só precisa saber se o equipamento está em local seguro para a manutenção. | UC-03, 04, 05 |
| 3 | Solicitação × OS | Mesmo registro. Uma OS gera várias tarefas, agrupadas e ligadas a ela. | UC-00, 03 |
| 4 | Aprovações | Fluxo configurável por mina; o sistema não deve engessar os profissionais. | UC-03, 04, 05 |
| 5 | Estoque e compras | O item 10 prevalece: o CMMS **controla o estoque**, pois é o consumidor dele. A integração com ERP se restringe, inicialmente, à troca de informações comerciais/financeiras (custos, pedidos); pode ser expandida se o cliente pedir. O CMMS não realiza compras nem gerencia fornecedores. | UC-03, 04 |
| 6 | Dados do equipamento | Por ora, apenas horímetro/odômetro; a vida útil dos componentes se baseia em um deles. Esse uso, junto com a projeção de uso de cada máquina, sustenta a previsão de trocas e custos (UC-07). | UC-03, 06, 07 |
| 7 | Comunicação | Entrada manual no CMMS; sem integração para criar OS. Registros offline são recebidos automaticamente ao ficar online, em até 24 h entre geração e reconhecimento; acima disso exigem aceite manual (evita duplicidade). Documentos podem ser anexados à OS; gravações devem ser transcritas, e só a transcrição é registrada. | UC-01 |
| 8 | Métricas e custo | Medidas em horas: espera, trabalho de manutenção, tempo total entre falha e disponibilidade. **Custo = material/equipamento (custo vindo do ERP) + mão de obra (horas × valor-hora do cadastro de profissionais, ou de sistema interno se integrado).** O CMMS não gere custo externo. O valor recebido do ERP é a verdade, e o CMMS o usa apenas para relatórios; divergências de saldo ou custo prevalecem pelo ERP. Reincidências seguem o mesmo fluxo de atendimento, e a tarefa é marcada com a flag de reincidente **manualmente**; se o sistema detectar uma possível reincidência, apenas sugere ao usuário. | UC-02 a 05 |
| 9 | Rastreabilidade | Identificador único por componente: localização, tempo em operação (horímetro do componente), equipamentos usados, recuperações. O horímetro é validado no início dos trabalhos (análise preliminar); o valor do relato é só previsão, então datas retroativas não afetam o cálculo. Itens sem série são consumíveis (óleo, filtros): sem rastreabilidade, só registro de uso e custo. Componentes que precisam de correção (reparo/recondicionamento) são marcados como tal; um terceiro ou equipe especializada assume a atividade, **fora do controle do CMMS**. Hierarquia de localização e compatibilidade vêm de cadastros do sistema. **Correção de lançamentos, lançamento contingencial e lançamento de anotações de campo** (sem tablet/PC ou sem rede) são feitos em telas especializadas de acesso restrito. | UC-01, 03, 04, 06 |
| 10 | Estoque de componentes | O CMMS controla estoque, reserva, previsão de rotatividade e rastreabilidade técnica. O ERP é integrado para ordem de compras e, se o cliente pedir, baixas de estoque. | UC-03, 06 |

Pendências remanescentes: nenhuma das dez decisões originais. Resta uma pesquisa: o algoritmo de sugestão de reincidência (provavelmente aprendizado de máquina), sem impacto no fluxo, já que a marcação é manual.

**Perfis e permissões:** o cliente cria grupos de usuários e define, por grupo, as permissões de acesso a telas e recursos (incluindo as telas de correção e lançamento contingencial).

**Localização:** a mina registra sua hierarquia de locais de trabalho, geralmente Mina → Unidade Operacional → Level → Local.

**Compatibilidade:** é a relação entre componente e máquina e fica no cadastro do componente. Exemplo: o componente A é compatível com os modelos md-1, md-2 e md-3.

**Correção e lançamento contingencial:** o CMMS terá telas especializadas, de acesso restrito, para (a) corrigir lançamentos errados, (b) fazer lançamento contingencial e (c) lançar dados recolhidos de anotações de campo, quando a mina não usa tablets/PCs na manutenção ou não tem cobertura de rede suficiente. Esses lançamentos devem ficar identificados pela origem e preservar autor, data/hora, justificativa e o valor anterior.

**Previsão de troca de componentes e custo futuro (requisito central):** cada componente tem vida útil baseada no seu horímetro/odômetro, e o uso de cada máquina pode ser projetado no tempo. Combinando os dois, o CMMS estima quando cada componente será trocado e quanto custará a troca no curto, médio e longo prazo, para planejar o orçamento dos próximos trimestres e anos e o estoque de reposição. Isso exige registrar desde a primeira versão: vida útil esperada por componente e modelo, perfil de uso por equipamento e custo de reposição. **A previsão em si (cálculo e relatórios) fica para uma fase posterior**, por decisão do negócio. Detalhes no [[07 - PT-Previsão de troca de componentes e custo futuro|UC-07]]. Aprovação de orçamento, versões, cenários e previsto × realizado ficam como camada posterior sobre essa previsão.

## Decisões originais (histórico)

1. **Prioridade e resposta:** quais critérios determinam a prioridade, quem pode defini-la/alterá-la e quais prazos ou SLAs se aplicam? “Urgente”, “moderado” e “não urgente” precisam de critérios objetivos; ordenação no topo da fila não substitui alerta e prazo.

- Resposta: Uma estrutura genérica deverá permitir que o cliente defina esses critérios, eles são diferentes de Mina para Mina, mesmo dentro de um mesmo grupo.

2. **Segurança e retorno à operação:** quais regras de isolamento, permissões, parada segura, testes e autoridades de liberação são obrigatórias em cada tipo de equipamento e unidade? Quais são os pontos de integração com procedimentos externos ao CMMS?

- Resposta: O sistema somente precisa saber se o equipamento está em local seguro para a equipe de manutenção, não é de responsabilidade do CMMS gerir a questão de segurança

3. **Solicitação versus OS:** são registros separados? Uma solicitação pode gerar múltiplas OS, atividades ou equipes? Como tratar recorrência, falhas correlatas e ordens preventivas?

- Resposta: Uma solicitação e uma OS são a mesma coisa. Uma OS poderá gerar diversas tarefas para trabalho e, todas essas tarefas deverão estar agrupadas e ligadas a OS.

4. **Escopo e aprovações:** quais alterações exigem aprovação do líder, engenharia, segurança, operação ou orçamento? Quem pode aceitar pendências não impeditivas?

- Resposta: Uma estrutura genérica deverá permitir a Mina configurar o que deve e o que não deve ser aprovado, cada Mina tem sua própria regra/fluxo de trabalho. O sistema não deve engessar os profissionais.

5. **Estoque e compras:** o CMMS apenas solicita materiais ou também reserva, baixa e integra com ERP/compras? Como lidar com substitutos, devoluções, lote/série, indisponibilidade e previsão de entrega?

- Resposta: Somente solicita, o CMMS deverá integrar com outros sistemas para ter informação de custos, mas não realizar compras ou gerenciar problemas com fornecedores. No final do dia, o que importa é saber quais materiais/componentes estão diponíveis para uso nos diferentes estoques da mina.

6. **Dados do equipamento:** quais identificadores e leituras são obrigatórios por classe de ativo (horímetro, odômetro ou outro)? Quais unidades, limites, leituras inválidas e regras de histórico se aplicam?

- Resposta: Nesse primeiro momento, apenas o horímetro/odômetro são necessários, a vida útil dos componentes são baseadas em uma dessas duas informações, por isso da importância delas.

7. **Comunicação e conectividade:** como registrar e preservar relatos recebidos pelo CCO por rádio ou mensagem embarcada? Há operação offline, áreas sem sinal, anexos, gravações ou requisitos de integração que precisem ser considerados?

- Os dados devem ser inseridos manualmente no CMMS, não haverá integração para criação de OS.

8. **Métricas e evidências:** quais dados são obrigatórios para medir indisponibilidade, tempo de resposta, mão de obra, custo, reincidência e cumprimento de manutenção?

- Resposta: A métrica usada para a mina são horas. Tempo de espera, tempo de trabalho da manutenção, tempo total do equipamento entre a falha e a disponibilidade para a operação, etc.

9. **Rastreabilidade de componentes:** quais identificadores e níveis de localização (equipamento, conjunto/posição) são obrigatórios? Quais perfis podem registrar ou corrigir eventos e como tratar datas retroativas, componentes sem série/lote e componentes recuperados ou recondicionados?

- Resposta: cada componente deverá ter um identificador único, isso permitirá o controle de onde ele está, quanto tempo está em operação (horímetro do componente), quais equipamentos o utilizaram, quando foi recuperado/recondicionado, etc.

10. **Ciclo de vida e estoque de componentes:** quais estados e eventos são necessários para inspeção, reparo/recondicionamento, disponibilidade, transferência e descarte? O CMMS deve controlar estoque, reserva, previsão de rotable e integração com ERP, ou apenas manter a rastreabilidade técnica?

- Resposta: O CMMS deve controlar estoque, reserva, previsão de rotatividade e a rastreabilidade técnica. A integração com ERP deve ser tida para ordem de compras e, se solicitado pelo cliente, baixas de estoque (caso o ERP a mina faça esse controle também.)

## Principais problemas corrigidos nos casos

- Papéis e passagem de responsabilidade estavam implícitos; agora cada etapa identifica atores e resultado esperado.
- A prioridade não tinha critérios, justificativa nem prazos associados.
- A decisão de mover o equipamento podia ser entendida como autorização para operá-lo; agora segurança e condição de deslocamento são tratadas separadamente.
- Faltavam tratamento de dados incompletos, duplicidade, espera, falha adicional e teste reprovado.
- Estados da solicitação e das atividades estavam misturados ou indefinidos.
- Não havia rastreabilidade suficiente para mudanças, materiais, testes, aprovações e comunicação de retorno.
- O histórico de componentes precisa registrar todos os períodos e locais de uso, inclusive remoção, recuperação/recondicionamento e reinstalação, sem perder a trilha anterior.
- O encerramento da manutenção podia ser confundido com liberação operacional; os casos agora separam as duas decisões.

## Referência complementar

- [[Análise documental e matriz de rastreabilidade]] — compara os casos atuais com os documentos de referência, registra as evidências e identifica decisões ainda pendentes.
