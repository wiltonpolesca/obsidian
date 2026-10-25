# CMMS — Visão do fluxo e decisões pendentes

## Fluxo coberto

1. [[01 - PT-Usuário reporta uma falha no equipamento]] — registro do relato e resposta inicial do CCO.
2. [[02 - PT-Equipe de manutenção analisa problema relatado pelo CCO]] — triagem, prioridade e atribuição.
3. [[03 - PT-Tratamento inicial da demanda solicitada]] — diagnóstico inicial, segurança, planejamento e disponibilidade de recursos.
4. [[04 - PT-Atendimento da demanda de manutenção]] — execução e apontamentos.
5. [[05 - PT-Liberação do equipamento para a operação da mina]] — testes, comunicação e encerramento.

## Vocabulário recomendado

- **Centro de Controle Operacional (CCO):** sala operacional com visão sistêmica do que ocorre na mina, atendida por diversos operadores e ponto de contato dos operadores em campo, normalmente por rádio e, em algumas situações, por sistema de mensagem embarcado. Nos casos, o CCO é o ponto de contato e encaminhamento; não se presume que seja um sistema integrado ao CMMS.
- **Solicitação:** registro do problema ou necessidade comunicado ao CMMS.
- **Ordem de serviço (OS):** unidade de trabalho planejada e autorizada para execução. Uma solicitação pode gerar uma ou mais OS, conforme decisão do negócio; os casos atuais tratam a solicitação e o trabalho como um único fluxo, sem definir essa relação.
- **Atividade:** tarefa executável dentro do plano/OS, com responsável, estado e critério de conclusão.
- **Histórico de componente:** sequência imutável de eventos de instalação, remoção e reinstalação/restauração, vinculada ao componente, equipamento e posição em que foi utilizado.
- **Disponibilidade técnica:** condição informada pela manutenção após a intervenção e os testes.
- **Liberação operacional:** decisão de retorno à operação, realizada pela autoridade definida pela mina. Não deve ser presumida a partir do encerramento da solicitação.

Use esses termos de forma consistente na interface e nas regras; se o produto não separar solicitação e OS, defina explicitamente que representam o mesmo registro.

## Regras de fluxo recomendadas

- Manter o histórico de alterações de estado, prioridade, responsável, escopo e aprovações, incluindo autor, data/hora e justificativa.
- Rastrear cada instalação, remoção e reinstalação/restauração de componente sem sobrescrever eventos anteriores. Registrar a identificação do componente (incluindo série/lote quando aplicável), equipamento e posição/localização, data/hora efetiva, responsável, motivo, condição e origem/destino do movimento. O período de uso deve ser calculável entre a instalação e a remoção; componentes ainda instalados permanecem com período aberto. Uma recuperação ou recondicionamento e a reinstalação posterior devem ser registradas como eventos distintos, vinculados ao mesmo histórico.
- Atribuir um responsável pela próxima ação para qualquer item em fila ou aguardando; espera não deve tornar a solicitação invisível.
- Controlar o estado da solicitação/OS separadamente do estado das atividades. Uma OS pode ter atividades concluídas e outras bloqueadas.
- Não permitir início de atividade sem autorização e controles de segurança exigidos pelos procedimentos da mina.
- Tratar os controles abaixo como **proposta inicial**, sujeita a validação com operação e manutenção:
  - solicitação: `Nova` → `Em triagem` → `Planejada` → `Em execução` → `Em validação` → `Encerrada`;
  - estados de espera: `Aguardando informação`, `Aguardando material/compra` ou `Bloqueada por segurança`, com motivo e responsável pela próxima ação;
  - encerramentos excepcionais: `Cancelada` ou `Duplicada`, sempre com justificativa e referência relacionada;
  - atividade: `Não iniciada` → `Em execução` → `Concluída`, com estado `Aguardando/Bloqueada` e motivo quando não puder avançar.

Não tratar esses nomes como requisitos fechados até confirmar as transições, permissões e impactos nos relatórios.

## Decisões necessárias antes de detalhar requisitos e construir

1. **Prioridade e resposta:** quais critérios determinam a prioridade, quem pode defini-la/alterá-la e quais prazos ou SLAs se aplicam? “Urgente”, “moderado” e “não urgente” precisam de critérios objetivos; ordenação no topo da fila não substitui alerta e prazo.
2. **Segurança e retorno à operação:** quais regras de isolamento, permissões, parada segura, testes e autoridades de liberação são obrigatórias em cada tipo de equipamento e unidade? Quais são os pontos de integração com procedimentos externos ao CMMS?
3. **Solicitação versus OS:** são registros separados? Uma solicitação pode gerar múltiplas OS, atividades ou equipes? Como tratar recorrência, falhas correlatas e ordens preventivas?
4. **Escopo e aprovações:** quais alterações exigem aprovação do líder, engenharia, segurança, operação ou orçamento? Quem pode aceitar pendências não impeditivas?
5. **Estoque e compras:** o CMMS apenas solicita materiais ou também reserva, baixa e integra com ERP/compras? Como lidar com substitutos, devoluções, lote/série, indisponibilidade e previsão de entrega?
6. **Dados do equipamento:** quais identificadores e leituras são obrigatórios por classe de ativo (horímetro, odômetro ou outro)? Quais unidades, limites, leituras inválidas e regras de histórico se aplicam?
7. **Comunicação e conectividade:** como registrar e preservar relatos recebidos pelo CCO por rádio ou mensagem embarcada? Há operação offline, áreas sem sinal, anexos, gravações ou requisitos de integração que precisem ser considerados?
8. **Métricas e evidências:** quais dados são obrigatórios para medir indisponibilidade, tempo de resposta, mão de obra, custo, reincidência e cumprimento de manutenção?
9. **Rastreabilidade de componentes:** quais identificadores e níveis de localização (equipamento, conjunto/posição) são obrigatórios? Quais perfis podem registrar ou corrigir eventos e como tratar datas retroativas, componentes sem série/lote e componentes recuperados ou recondicionados?

## Principais problemas corrigidos nos casos

- Papéis e passagem de responsabilidade estavam implícitos; agora cada etapa identifica atores e resultado esperado.
- A prioridade não tinha critérios, justificativa nem prazos associados.
- A decisão de mover o equipamento podia ser entendida como autorização para operá-lo; agora segurança e condição de deslocamento são tratadas separadamente.
- Faltavam tratamento de dados incompletos, duplicidade, espera, falha adicional e teste reprovado.
- Estados da solicitação e das atividades estavam misturados ou indefinidos.
- Não havia rastreabilidade suficiente para mudanças, materiais, testes, aprovações e comunicação de retorno.
- O histórico de componentes precisa registrar todos os períodos e locais de uso, inclusive remoção, recuperação/recondicionamento e reinstalação, sem perder a trilha anterior.
- O encerramento da manutenção podia ser confundido com liberação operacional; os casos agora separam as duas decisões.
