# UC-06 — Manutenção registra o ciclo de vida dos componentes

## Objetivo

Manter a identidade, a localização, a condição e o histórico de uso dos componentes ao longo de instalações, remoções, transferências, reparos/recondicionamentos e reinstalações, para que a equipe de manutenção possa consultar onde cada componente foi usado e por quanto tempo.

## Atores

- **Principal:** profissional de manutenção que registra uma instalação, remoção ou movimentação.
- **Apoio:** líder/planejador da manutenção e responsável por estoque, almoxarifado ou reparo/recondicionamento, conforme o processo definido pela mina.

## Gatilho e pré-condições

- Um componente é cadastrado ou identificado para uso.
- Ocorre instalação, remoção, transferência, envio para reparo/recondicionamento, retorno de reparo ou descarte.
- Para mudanças realizadas durante uma intervenção, existe uma solicitação/OS relacionada, conforme as regras de manutenção.

## Fluxo principal

1. O profissional localiza ou cadastra o componente:
   - componentes serializados são identificados individualmente por identificador único e número de série;
   - itens sem série (consumíveis como óleo e filtros) não são componentes rastreáveis: têm apenas registro de uso e custo na tarefa (UC-04), sem histórico individual.
2. Antes de registrar um movimento, o profissional confere a identidade, o estado e a localização/posição atual do componente. Divergências são registradas e encaminhadas ao líder para resolução, sem substituir silenciosamente o histórico.
3. Para instalar o componente, verifica se ele já consta instalado em outro ativo e se corresponde ao equipamento, posição e tarefa, conforme as regras de compatibilidade aprovadas. Registra um evento de instalação com identificador do componente, equipamento e posição, data/hora efetiva, profissional responsável e solicitação/OS relacionada. Registra também a leitura do horímetro/odômetro do equipamento validada no início dos trabalhos (análise preliminar da falha, UC-03); essa é a leitura real usada no cálculo do período de uso, e a informada pelo operador no relato é apenas previsão. Exceções a incompatibilidade ou instalação simultânea exigem justificativa e aprovação conforme política da mina.
4. Para remover o componente, registra um evento de remoção com data/hora, responsável, equipamento/posição de origem, condição encontrada, motivo, destino e leitura do equipamento quando aplicável. A remoção encerra o período de uso daquela instalação.
5. Se o componente for transferido, enviado para inspeção ou devolvido ao estoque, registra cada mudança como evento próprio, com origem, destino, data/hora, responsável e estado/condição resultante. Se precisar de correção (reparo/recondicionamento), o componente é marcado como tal, e um terceiro ou equipe especializada assume o serviço **fora do controle do CMMS**; o CMMS registra apenas o envio e o retorno, com resultado e referência ao serviço informada. A compatibilidade é a relação entre componente e modelo de máquina, mantida no cadastro do componente (exemplo: componente A compatível com os modelos md-1, md-2 e md-3). A hierarquia de locais de trabalho é cadastrada pela mina (geralmente Mina → Unidade Operacional → Level → Local).
6. Se for usada uma unidade temporária enquanto o componente removido é reparado, registra os movimentos dos dois componentes separadamente e relaciona a troca. Registra a previsão para reinstalação do componente reparado por data ou leitura de uso quando definida no planejamento.
7. Ao reinstalar um componente recuperado, registra um novo evento de instalação relacionado ao histórico anterior. O período de uso anterior permanece encerrado; a reinstalação inicia outro período.
8. O CMMS mantém uma visão atual de localização/estado derivada dos eventos e permite consultar a linha do tempo do componente por número de série/identificador, equipamento, posição, datas e referência da solicitação/OS.
9. O CMMS calcula o tempo em cada período de uso entre a instalação e a remoção e permite consultar a duração acumulada dos períodos anteriores. Para componentes com leitura operacional registrada, disponibiliza também a variação entre as leituras de instalação e remoção, sujeita à unidade e às regras de validação definidas para o equipamento.

Os valores definitivos de estado (por exemplo, instalado, em reparo, disponível, em inspeção ou descartado) e os tipos de movimento devem ser validados com a mina antes de configurar o sistema. As regras de compatibilidade e localização vêm dos cadastros.

## Fluxos alternativos e exceções

- **Componente sem série ou etiqueta legível:** se for um componente rastreável, o profissional registra a limitação e a divergência é resolvida pelo líder; itens consumíveis sem série não entram neste fluxo. O CMMS não funde registros distintos automaticamente por semelhança de descrição.
- **Localização ou estado atual divergente:** o profissional registra a divergência e solicita reconciliação ao responsável designado. A correção é feita na tela especializada de acesso restrito, preserva o valor anterior, o autor, a data/hora e a justificativa.
- **Componente removido e não enviado para reparo:** registra o destino real (por exemplo, estoque, quarentena ou descarte) e a condição. Não é marcado como restaurado sem resultado de reparo/recondicionamento.
- **Reparo/recondicionamento reprovado:** registra o resultado e a nova condição/localização; não disponibiliza o componente para instalação enquanto houver impedimento.
- **Reinstalação em equipamento diferente:** registra a remoção/transferência e a nova instalação no equipamento/posição de destino, preservando a sequência entre equipamentos.
- **Lançamento contingencial ou a partir de anotações de campo:** quando a mina não usa tablets/PCs na área de manutenção ou não há cobertura de rede, os eventos de componente são anotados em campo e lançados depois em tela especializada de acesso restrito. O lançamento fica identificado como contingencial/anotação de campo, com a data/hora efetiva do evento, o autor do lançamento e o responsável original.
- **Data de evento retroativa:** a leitura de uso real é a validada na análise preliminar, mas ela é datada; mudar a data de uma instalação ou remoção altera o período de uso. Datas retroativas só entram pelas telas restritas de correção, com justificativa e valor anterior preservado, e os períodos afetados são recalculados. **Leitura inválida:** leitura menor que a anterior, acima da tolerância de crescimento ou duplicada é rejeitada; a correção exige justificativa, sem alterar silenciosamente períodos ou métricas já consultados. **Medidor trocado ou zerado:** registra-se um offset igual à última leitura anterior à troca, para manter o uso acumulado contínuo.
- **Movimento não relacionado a uma OS:** registra o tipo de evento e a referência operacional permitida, sem criar uma solicitação fictícia.

## Resultado esperado

Histórico cronológico e consultável que mostra a identificação do componente, seus locais e estados ao longo do tempo, os períodos em cada equipamento/posição, os reparos/restaurações realizados e a situação atual, sem apagar eventos anteriores.

## Critérios de aceitação

- Cada instalação e remoção registra componente, equipamento, posição/localização, data/hora e responsável; condição, motivo, origem/destino, OS e leitura operacional são registrados quando aplicáveis.
- A remoção fecha o período de uso correspondente; uma instalação ou reinstalação abre um novo período. Um período ainda aberto é indicado como tal.
- O histórico por componente permite identificar uso em mais de um equipamento/posição e consultar a duração de cada período e a duração acumulada; quando disponíveis, as leituras operacionais permitem consultar a utilização entre eventos.
- O sistema identifica uma tentativa de instalação de componente já instalado em outro ativo ou incompatível com o modelo da máquina (conforme o cadastro do componente) e aplica o bloqueio/alerta e o processo de exceção definidos pela mina.
- O acesso às telas de correção e lançamento contingencial é controlado por grupos de usuários e permissões configurados pelo cliente.
- Restauração/recondicionamento é um evento explícito com resultado e localização/estado após o serviço, distinto da reinstalação.
- Mudanças de estado/localização não apagam nem sobrescrevem eventos anteriores. Correções e lançamentos contingenciais só são feitos em telas especializadas de acesso restrito e preservam autor, data/hora, justificativa e valor anterior.
- A unidade temporária e o componente removido para reparo podem ser consultados como movimentos relacionados, sem confundir as identidades nem os respectivos períodos de uso.
- Os estados e tipos de evento configurados correspondem à política aprovada pela mina; a lista deste caso é proposta funcional, não enumeração fechada.
- O uso acumulado e a vida útil esperada de cada componente ficam disponíveis para a previsão de trocas em [[07 - PT-Previsão de troca de componentes e custo futuro]].

## Referências

- [[07 - PT-Previsão de troca de componentes e custo futuro]] — usa o uso acumulado do componente para prever trocas e custos.
- [[03 - PT-Tratamento inicial da demanda solicitada]] — identificação e planejamento de componente temporário ou encaminhado para reparo.
- [[04 - PT-Atendimento da demanda de manutenção]] — registro dos eventos durante a execução.
- [AMT 8.26 — Work Execution and Finalisation, pp. 43 e 45–47](<../Maintenance Asset Management/AMT_Reference/AMT_Training Manual/AMT 8.26 - Work Execution and Finalisation - RPM Training.cleaned.pdf>) — exemplos de componente temporário (Swing In/Out), reinstalação planejada por data ou uso, números de série de entrada/saída e histórico em diferentes equipamentos.
- [AMT Release Notes 8.16–8.27, pp. 4–5](<../Maintenance Asset Management/AMT_Reference/AMT_Release Notes/AMT Release Notes 8.16_8.27.pdf>) — referência para vida acumulada de instalações anteriores e controles configuráveis de compatibilidade e instalação simultânea.
- [AMT Handbook, parágrafos 288–299](<../Maintenance Asset Management/AMT_Reference/AMT_Handbook/AMT_Handbook_iSolutions.docx>) — referência de produto para acompanhamento de rotables por estado/localização, componentes serializados e histórico.
