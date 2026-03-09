---

---
**Objetivo**

Implantar o sistema Extreme na mina de carajás para controle da frota auxiliar atualmente gerenciada pelo SmartMine 3.2.x e também para contabilizar as movimentações realizadas na recuperação da barragem do Geladinho

**Motivador da mudança**

- Flexibilizar a gestão de frotas da mina com a funcionalidade de múltiplos despachos.
- Atualizar o cliente para a nova versão do sistema, abrindo possibilidade de venda recorrente de outros módulos cuja demanda já existe e o SmartMine 3.2.x não oferece.
- Agilidade na customização para o atendimento ao cliente.
- Contabilizar as movimentações realizadas na recuperação da barragem do Geladinho

**Escopo do projeto a ser implantado**

- **Importação da base do 3.2.x**
EquipamentosOperadoresUsuáriosÁrvore de estados
**Integração com o Embarcado - (Tem que construir a camada de comunicação, incluindo a obtenção do dado de campo e a camada responsável por traduzir o formato do 3.2.x para o Extreme)**
Login de operadorLogout de operadorHorímetroRecebimento de statusTroca de estado operacionalCheck-list (Inclui sincronismo)Recebimento de mensagem para o operadorAlocação de equipamento de transporteAlocação de equipamento de cargaAlocação de equipamento auxiliar
**Funcionalidades disponibilizadas no Supervisório**
FuncionalidadesLogin manualLogout manualHorímetro manualTroca de estado manual Envio de mensagem~~Lançamento manual de abastecimento~~Diário de bordoVisualizar a parte diária do equipamento no turno atual e no anteriorAlocação de atividades (Transporte, carga e auxiliar)Mapa 3DMúltiplos despachosRelatóriosParte diária detalhada (implantado)Movimentação por tipoMovimentação por origem x destinoÍndices (disponibilidade, utilização e produtividade) por equipamento e por tipo de equipamento
- **Manutenção**
<u>**Funcionalidades**</u>Visualização dos equipamentos que estão em manutenção (Sem separação por gerência/Setor)Opção de se adicionar um comentário ao estadoOpção de se trocar o estado operacional do equipamento (somente manutenção)Opção de se atualizar o horímetro do equipamentoVisualização da parte diária do equipamento nos últimos 30 dias (consulta)Ajuste de apontamento de hora incorretoControle de liberação de equipamentoAssociar OS ao atendimento~~Programação de manutenção preventiva~~Local onde o equipamento se encontra na mina (depende dos polígonos)Previsão de término do atendimento<u>**Relatórios**</u>Previsão de liberaçãoOcorrências de manutençãoPerfil de perdas por número de ocorrênciasPerfil de perdas por tempo de ocorrênciasDescrição de ocorrências de manutençãoSituação dos equipamentos em manutençãoMTTR-MTBFAderência a programação de preventivaPerformance de GPSPerformance de comunicação

**Pessoas envolvidas**

- Jésus - Campo
- João Dias - Líder de implantação
- Alisson - GP
- Jerônimo - Líder técnico