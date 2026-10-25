# UC-02 — Manutenção faz a triagem da solicitação

## Objetivo

Analisar a solicitação recebida do CCO, definir sua prioridade, atribuir responsabilidade e deixar claro o próximo passo.

## Atores

- **Principal:** planejador, supervisor ou profissional designado pela manutenção.
- **Apoio:** CCO e líder da equipe responsável.

## Gatilho e pré-condições

- A solicitação foi registrada no CMMS e encaminhada para a fila de triagem.
- O equipamento e o relato estão identificados, mesmo que ainda existam informações pendentes.

## Fluxo principal

1. O responsável pela triagem revisa o relato, o estado do equipamento, os riscos informados, a localização e as evidências disponíveis.
2. Confere se há solicitações abertas relacionadas ao mesmo equipamento ou falha; quando aplicável, relaciona os registros para preservar o histórico. Se o problema já ocorreu antes, o atendimento segue o mesmo fluxo e o responsável marca manualmente a tarefa como reincidente, referenciando a OS anterior. Se o CMMS identificar uma possível reincidência, apenas sugere a marcação ao usuário.
3. Classifica a prioridade usando critérios operacionais aprovados, considerando, no mínimo, segurança, impacto na produção, indisponibilidade do equipamento e consequências de atraso.
4. Registra a justificativa da prioridade e o prazo ou tempo-alvo de resposta aplicável.
5. Define a equipe responsável e, quando possível, o responsável inicial e a previsão de atendimento.
6. O CMMS atualiza a fila da equipe, ordenada segundo a prioridade e os critérios de desempate definidos, e notifica os responsáveis conforme as regras de comunicação.
7. O CCO pode consultar a prioridade, o responsável, o estado e a previsão registrada.

## Fluxos alternativos e exceções

- **Dados insuficientes:** a manutenção solicita ao CCO as informações necessárias e marca a solicitação como aguardando informação, sem apagar os dados já registrados.
- **Não é uma demanda de manutenção ou há duplicidade:** o responsável registra o motivo, relaciona o registro correspondente quando aplicável e encaminha ou encerra conforme a regra aprovada. O solicitante/CCO recebe a justificativa.
- **Risco ou urgência não reconhecidos na triagem inicial:** o responsável reavalia a prioridade e registra a alteração, seu autor, horário e justificativa.
- **Equipe indisponível ou responsabilidade incerta:** a solicitação permanece visível em uma fila de exceções, com um responsável pela próxima ação; não deve desaparecer de uma fila sem transferência rastreável.

## Resultado esperado

Solicitação triada, priorizada com justificativa, atribuída a uma equipe e com próximo passo visível para manutenção e CCO.

## Critérios de aceitação

- A prioridade, a justificativa, o responsável e o histórico de alterações ficam registrados.
- A notificação informa a solicitação e a prioridade; alertas de urgência não dependem apenas da posição na lista.
- Solicitações aguardando informação, sem equipe ou com prioridade contestada continuam visíveis e têm responsável pelo acompanhamento.
- Alterações de prioridade ou atribuição não apagam o histórico anterior.
