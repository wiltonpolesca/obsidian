# UC-03 — Manutenção avalia e planeja o atendimento

## Objetivo

Confirmar o problema, avaliar riscos e recursos necessários e preparar um plano de trabalho executável, sem perder o que já foi registrado na triagem.

## Atores

- **Principal:** líder ou planejador da equipe de manutenção.
- **Apoio:** profissionais de manutenção, CCO, almoxarifado/compras e áreas de segurança, quando necessário.

## Gatilho e pré-condições

- A solicitação foi triada e atribuída a uma equipe.
- O atendimento foi iniciado ou a equipe registrou a necessidade de avaliação técnica.

## Fluxo principal

1. O líder confirma o equipamento, o local, os riscos e as condições para iniciar o trabalho.
2. Antes da intervenção, a equipe identifica e registra os controles de segurança necessários segundo os procedimentos da mina, incluindo isolamento de energias, bloqueio e etiquetagem, permissões e controle de área quando aplicáveis.
3. A equipe inspeciona o equipamento e registra:
   - sintomas confirmados, diagnóstico inicial e evidências;
   - horímetro/odômetro observado, unidade, data e responsável pela leitura;
   - sistemas, subsistemas e componentes afetados, com condição encontrada;
   - riscos identificados e controles aplicados.
4. O líder define o escopo inicial e divide o trabalho em atividades. Para cada atividade registra responsável ou equipe, prioridade, dependências, estimativa e critérios de conclusão.
5. A equipe identifica materiais, peças, ferramentas e serviços necessários. O sistema permite verificar disponibilidade e reservar ou solicitar os itens conforme o processo de estoque/compras.
6. O líder libera as atividades que tenham escopo, recursos e condições de segurança adequados.
7. Se algum item estiver indisponível, o líder registra a pendência, o responsável e a previsão:
   - se o trabalho puder avançar com segurança e sem criar retrabalho ou risco, libera somente as atividades independentes dos itens faltantes;
   - caso contrário, mantém as atividades afetadas bloqueadas e marca a solicitação como aguardando material/compra.
8. O CMMS mantém a solicitação e suas atividades visíveis, com estado, pendências e próximo passo atualizados.

## Fluxos alternativos e exceções

- **Diagnóstico inconclusivo:** registra-se a incerteza e a próxima ação diagnóstica; a equipe não declara a falha resolvida sem evidência.
- **Risco não controlado ou condição de trabalho insegura:** não se libera a atividade. A equipe interrompe o trabalho e aciona o responsável operacional/de segurança conforme procedimento.
- **Necessidade de escopo adicional:** registra-se a alteração proposta, sua justificativa, impacto em prazo/recursos e aprovação exigida antes da execução.
- **Itens parcialmente disponíveis:** a equipe separa atividades liberadas das bloqueadas e registra as dependências; não marca toda a solicitação como liberada se ainda houver atividade impeditiva.
- **Espera por fornecedor ou compras:** registra-se o item, quantidade, solicitação de compra, responsável e previsão, sem confundir o estado da demanda com o estado do pedido de compra.

## Resultado esperado

Plano de trabalho com atividades, responsáveis, recursos, controles de segurança e pendências claramente registrados. Atividades sem condições de execução permanecem bloqueadas.

## Critérios de aceitação

- Cada atividade tem estado, responsável ou equipe e critério de conclusão.
- A leitura de horímetro/odômetro é rastreável e não sobrescreve leituras anteriores.
- Materiais indisponíveis e atividades dependentes deles são identificáveis.
- A liberação para execução não pode ignorar controles de segurança obrigatórios nem aprovações de mudança de escopo.

## Referências

- A execução das atividades segue o fluxo descrito em [[04 - PT-Atendimento da demanda de manutenção]].
