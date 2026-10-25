# UC-04 — Equipe executa as atividades de manutenção

## Objetivo

Executar o plano de trabalho aprovado, registrar evidências e materiais utilizados e tratar alterações ou impedimentos de forma rastreável.

## Atores

- **Principal:** técnico ou profissional de manutenção designado.
- **Apoio:** líder da equipe, almoxarifado e áreas de operação/segurança quando necessário.

## Gatilho e pré-condições

- Há uma ou mais atividades liberadas para execução no plano de trabalho.
- A equipe confirmou local, equipamento, recursos e que o equipamento está em local seguro para a manutenção.

## Fluxo principal

1. O profissional consulta as atividades liberadas, sua prioridade, dependências, instruções, materiais reservados e critérios de conclusão.
2. Antes de começar, confirma que a identificação do equipamento e a confirmação de local seguro correspondem ao serviço. Se houver divergência, interrompe o início e informa o líder.
3. Ao iniciar cada atividade, registra o início e o responsável. Durante o trabalho, atualiza o estado e registra horas trabalhadas, observações e evidências conforme necessário.
4. Para cada material utilizado, registra o item e a quantidade; o CMMS baixa o estoque e apropria o custo (obtido do ERP). Itens sem série (consumíveis como óleo e filtros) têm apenas registro de uso e custo, sem rastreabilidade individual. Para cada componente rastreável instalado, removido ou reinstalado/restaurado, registra um evento próprio, vinculado à OS, com:
   - identificador único do componente (e número de série);
   - equipamento e posição/localização no equipamento;
   - tipo de evento, data/hora em que ocorreu, profissional responsável e motivo;
   - condição observada, origem/destino do componente e leitura do horímetro/odômetro validada no início dos trabalhos.

   A remoção encerra o período de uso iniciado pela instalação. O CMMS mantém os eventos anteriores e permite consultar em quais equipamentos/posições o componente foi utilizado e por quanto tempo; componentes ainda instalados têm um período de uso em aberto. Quando uma unidade temporária é instalada enquanto o componente removido está em reparo/recondicionamento, registra os movimentos dos dois componentes separadamente e relaciona a troca. A restauração/recondicionamento e uma reinstalação posterior são eventos distintos no mesmo histórico, sem reabrir ou alterar o período anterior.
5. Ao concluir uma atividade, registra o serviço executado, resultados, medições/testes aplicáveis e atende aos critérios de conclusão definidos no plano.
6. O líder revisa as atividades concluídas e as pendências antes de encaminhar o equipamento para os testes finais descritos em [[05 - PT-Liberação do equipamento para a operação da mina]].

## Fluxos alternativos e exceções

- **Componente ou defeito adicional encontrado:** o profissional registra o achado, evidências e risco; o líder avalia o impacto e atualiza o diagnóstico e o plano de trabalho. Atividades afetadas ficam aguardando aprovação/liberação quando exigido. O trabalho já concluído permanece registrado e não é reiniciado ou apagado.
- **Componente removido para reparo/recondicionamento:** registra-se a condição, o destino e o movimento para reparo. Ao retornar, registra-se o resultado da restauração e a nova localização/estado; uma instalação posterior abre um novo período de uso.
- **Material, ferramenta ou informação indisponível:** o profissional marca a atividade como aguardando, registra o motivo, o item/apoio necessário e notifica o líder. Atividades independentes podem prosseguir se isso for seguro e estiver autorizado.
- **Risco, condição insegura ou divergência de identificação:** o profissional interrompe a atividade, registra o impedimento no CMMS e aciona o líder e a operação/segurança pelos procedimentos da mina, externos ao CMMS.
- **Atividade não concluída ou teste reprovado:** registra-se o resultado observado, a pendência e a próxima ação; não se altera o estado para concluído.
- **Componente rastreável sem número de série ou identificação legível:** registra-se a indisponibilidade da identificação e o líder resolve a divergência, sem inventar um identificador. Itens consumíveis sem série não geram eventos de componente.

- **Sem tablet/PC ou sem cobertura de rede na área de manutenção:** o profissional anota os dados em campo (horas, materiais, eventos de componente), e um usuário autorizado os lança depois em tela especializada de acesso restrito, identificada como lançamento a partir de anotações de campo. Erros de lançamento são corrigidos na mesma tela, com justificativa e histórico.

## Resultado esperado

Atividades executadas com segurança e com registros suficientes para rastrear mão de obra, componentes, evidências, alterações de escopo e pendências.

## Critérios de aceitação

- Estados e horários das atividades ficam registrados com o usuário que fez a alteração.
- Materiais consumidos, componentes removidos/instalados e quantidades podem ser rastreados segundo a política de estoque.
- Cada instalação e remoção tem data/hora, responsável e identificação do componente, com equipamento/posição, condição, motivo, origem/destino, OS e leitura operacional quando aplicáveis.
- O histórico de cada componente mostra, em ordem cronológica, instalações, remoções, recuperações/recondicionamentos e reinstalações, com equipamento, posição/localização, responsável e data/hora; os períodos de uso podem ser consultados, inclusive quando o período atual ainda está aberto.
- O achado de novo defeito cria ou atualiza uma pendência/plano sem apagar o histórico já executado.
- Uma atividade não pode ser concluída sem atender aos critérios definidos ou sem registrar uma exceção aprovada.
