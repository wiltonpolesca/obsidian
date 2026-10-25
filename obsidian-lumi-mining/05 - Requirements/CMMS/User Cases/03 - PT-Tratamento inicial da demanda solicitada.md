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
2. Antes da intervenção, a equipe confirma e registra que o equipamento está em local seguro para a manutenção. A gestão da segurança (isolamento de energias, bloqueio e etiquetagem, permissões, controle de área) é responsabilidade dos procedimentos da mina e **não** do CMMS, que registra apenas essa confirmação (decisão 2 do [[00 - PT-Visão do fluxo e decisões pendentes|UC-00]]).
3. A equipe inspeciona o equipamento e registra:
   - sintomas confirmados, diagnóstico inicial e evidências;
   - horímetro/odômetro observado, unidade, data e responsável pela leitura. **Esta leitura é validada no início dos trabalhos e é a referência real**; a informada no relato (UC-01) é apenas previsão;
   - sistemas, subsistemas e componentes afetados, com condição encontrada;
   - riscos identificados e controles aplicados.
4. O líder define o escopo inicial e divide o trabalho em tarefas (atividades), todas agrupadas e vinculadas à mesma OS. Para cada tarefa registra responsável ou equipe, prioridade, dependências, estimativa em horas e critérios de conclusão.
5. A equipe identifica materiais, peças, ferramentas e serviços necessários. O CMMS **controla o estoque** da mina (é o consumidor dele): consulta saldos por local, reserva os itens disponíveis e, para os indisponíveis, gera a solicitação de material. A compra em si e a gestão de fornecedores ficam fora do CMMS; o ERP troca com ele apenas informações comerciais/financeiras (custos, pedidos), e outras integrações dependem do cliente.
   - Para um componente serializado a remover, substituir ou enviar para reparo/recondicionamento, identifica a unidade e sua posição atual. Se for instalada uma unidade temporária, relaciona a retirada e a instalação temporária e registra a previsão de retorno do componente reparado por data ou leitura de uso, quando aplicável.
6. O líder libera as atividades que tenham escopo, recursos e local seguro confirmado. Aprovações exigidas antes da liberação seguem o fluxo configurado pela mina, sem engessar a equipe.
7. Se algum item estiver indisponível, o líder registra a pendência, o responsável e a previsão:
   - se o trabalho puder avançar com segurança e sem criar retrabalho ou risco, libera somente as atividades independentes dos itens faltantes;
   - caso contrário, mantém as atividades afetadas bloqueadas e marca a solicitação como aguardando material/compra.
8. O CMMS mantém a solicitação e suas atividades visíveis, com estado, pendências e próximo passo atualizados.

## Fluxos alternativos e exceções

- **Diagnóstico inconclusivo:** registra-se a incerteza e a próxima ação diagnóstica; a equipe não declara a falha resolvida sem evidência.
- **Local não seguro para a manutenção:** não se libera a atividade. O CMMS registra o impedimento e a equipe aciona a operação/segurança pelos procedimentos da mina, fora do CMMS.
- **Necessidade de escopo adicional:** registra-se a alteração proposta, sua justificativa e o impacto em horas/recursos; a aprovação só é exigida se o fluxo configurado pela mina a prever.
- **Itens parcialmente disponíveis:** a equipe separa atividades liberadas das bloqueadas e registra as dependências; não marca toda a solicitação como liberada se ainda houver atividade impeditiva.
- **Espera por fornecedor ou compras:** registra-se o item, quantidade, referência do pedido de compra recebida do ERP, responsável e previsão, sem confundir o estado da OS com o estado do pedido. O CMMS não gerencia o fornecedor.

## Resultado esperado

Plano de trabalho com atividades, responsáveis, recursos, controles de segurança e pendências claramente registrados. Atividades sem condições de execução permanecem bloqueadas.

## Critérios de aceitação

- Cada atividade tem estado, responsável ou equipe e critério de conclusão.
- A leitura de horímetro/odômetro é rastreável e não sobrescreve leituras anteriores.
- Materiais indisponíveis e atividades dependentes deles são identificáveis.
- Componentes a remover, instalar temporariamente ou enviar para reparo/recondicionamento estão identificados e vinculados ao plano; a previsão de retorno é registrada quando houver troca temporária.
- A liberação para execução exige a confirmação de local seguro e as aprovações previstas no fluxo configurado pela mina.
- Reservas e solicitações de material refletem os saldos de estoque controlados pelo CMMS.
- A leitura de horímetro/odômetro da análise preliminar é validada antes do início dos trabalhos.

## Referências

- A execução das atividades segue o fluxo descrito em [[04 - PT-Atendimento da demanda de manutenção]].
