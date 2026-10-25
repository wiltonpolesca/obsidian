# UC-04 — Equipe executa as atividades de manutenção

## Objetivo

Executar o plano de trabalho aprovado, registrar evidências e materiais utilizados e tratar alterações ou impedimentos de forma rastreável.

## Atores

- **Principal:** técnico ou profissional de manutenção designado.
- **Apoio:** líder da equipe, almoxarifado e áreas de operação/segurança quando necessário.

## Gatilho e pré-condições

- Há uma ou mais atividades liberadas para execução no plano de trabalho.
- A equipe confirmou local, equipamento, recursos e controles de segurança aplicáveis.

## Fluxo principal

1. O profissional consulta as atividades liberadas, sua prioridade, dependências, instruções, materiais reservados e critérios de conclusão.
2. Antes de começar, confirma que a identificação do equipamento e as condições de segurança correspondem ao serviço. Se houver divergência, interrompe o início e informa o líder.
3. Ao iniciar cada atividade, registra o início e o responsável. Durante o trabalho, atualiza o estado e registra horas trabalhadas, observações e evidências conforme necessário.
4. Para cada material ou componente utilizado, registra o item e a quantidade. Para cada componente instalado, removido ou reinstalado/restaurado, registra um evento próprio, vinculado à solicitação/OS, com:
   - identificação do componente (incluindo número de série ou lote quando aplicável), ou a identificação alternativa permitida pela política de rastreabilidade;
   - equipamento e posição/localização no equipamento;
   - tipo de evento, data/hora em que ocorreu, profissional responsável e motivo;
   - condição observada e origem/destino do componente, quando aplicável.
   
   A remoção encerra o período de uso iniciado pela instalação. O CMMS mantém os eventos anteriores e permite consultar em quais equipamentos/posições o componente foi utilizado e por quanto tempo; componentes ainda instalados têm um período de uso em aberto. Se um componente removido for recuperado ou recondicionado e voltar a ser instalado, registra a recuperação/recondicionamento e a nova instalação como eventos separados no mesmo histórico, sem reabrir ou alterar o período anterior.
5. Ao concluir uma atividade, registra o serviço executado, resultados, medições/testes aplicáveis e atende aos critérios de conclusão definidos no plano.
6. O líder revisa as atividades concluídas e as pendências antes de encaminhar o equipamento para os testes finais descritos em [[05 - PT-Liberação do equipamento para a operação da mina]].

## Fluxos alternativos e exceções

- **Componente ou defeito adicional encontrado:** o profissional registra o achado, evidências e risco; o líder avalia o impacto e atualiza o diagnóstico e o plano de trabalho. Atividades afetadas ficam aguardando aprovação/liberação quando exigido. O trabalho já concluído permanece registrado e não é reiniciado ou apagado.
- **Material, ferramenta ou informação indisponível:** o profissional marca a atividade como aguardando, registra o motivo, o item/apoio necessário e notifica o líder. Atividades independentes podem prosseguir se isso for seguro e estiver autorizado.
- **Risco, condição insegura ou divergência de identificação:** o profissional interrompe a atividade, preserva a área conforme procedimento e aciona o líder e o responsável operacional/segurança.
- **Atividade não concluída ou teste reprovado:** registra-se o resultado observado, a pendência e a próxima ação; não se altera o estado para concluído.
- **Componente sem número de série ou identificação legível:** registra-se a indisponibilidade da identificação e os dados alternativos permitidos pela política de rastreabilidade, sem inventar um identificador; os eventos de instalação, remoção e reinstalação continuam vinculados ao registro do componente.

## Resultado esperado

Atividades executadas com segurança e com registros suficientes para rastrear mão de obra, componentes, evidências, alterações de escopo e pendências.

## Critérios de aceitação

- Estados e horários das atividades ficam registrados com o usuário que fez a alteração.
- Materiais consumidos, componentes removidos/instalados e quantidades podem ser rastreados segundo a política de estoque.
- O histórico de cada componente mostra, em ordem cronológica, instalações, remoções, recuperações/recondicionamentos e reinstalações, com equipamento, posição/localização, responsável e data/hora; os períodos de uso podem ser consultados, inclusive quando o período atual ainda está aberto.
- O achado de novo defeito cria ou atualiza uma pendência/plano sem apagar o histórico já executado.
- Uma atividade não pode ser concluída sem atender aos critérios definidos ou sem registrar uma exceção aprovada.
