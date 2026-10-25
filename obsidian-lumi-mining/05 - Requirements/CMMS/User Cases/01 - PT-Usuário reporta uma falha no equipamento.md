# UC-01 — Operador reporta uma falha no equipamento ao CCO

## Objetivo

Registrar uma falha com informações suficientes para que o CCO tome as primeiras medidas de segurança e encaminhe a solicitação à manutenção.

## Atores

- **Principal:** operador do equipamento.
- **Apoio:** Centro de Controle Operacional (CCO), sala operacional com visão sistêmica da operação, atendida por diversos operadores e ponto de contato dos operadores em campo.
- **Destinatário:** equipe de manutenção.

## Gatilho e pré-condições

- O operador identifica uma falha, anomalia ou condição insegura durante a operação.
- O operador consegue contatar o CCO por rádio ou, quando disponível, pelo sistema de mensagem embarcado.

## Fluxo principal

1. O operador aciona o CCO por rádio ou pelo sistema de mensagem embarcado e informa sua identificação, o equipamento e que há uma falha ou condição anormal.
2. O CCO confirma os dados do equipamento e coleta, quando possível:
   - localização atual e referência de acesso;
   - sintomas observados, quando começaram e se são intermitentes;
   - condição operacional do equipamento e se ele pode se deslocar com segurança;
   - horímetro/odômetro e evidências disponíveis (por exemplo, foto ou código de alarme);
   - riscos imediatos, pessoas expostas e medidas já tomadas.
3. O CCO orienta o operador a interromper ou manter a operação e a movimentar o equipamento somente conforme os procedimentos operacionais e de segurança aplicáveis. A possibilidade de deslocamento, por si só, não significa que o equipamento esteja seguro para operar.
4. Se for necessário retirar o operador ou transportar o equipamento, o CCO aciona os recursos apropriados e informa as instruções para manter a área segura. O operador não deve abandonar o equipamento em condição insegura.
5. O operador e o CCO mantêm a comunicação operacional pelo canal disponível. O profissional do CCO que assumir o registro transcreve para o CMMS o relato recebido, preservando o conteúdo original da mensagem quando possível, os dados coletados, as orientações dadas, o canal utilizado e os horários relevantes. O contato por rádio ou sistema embarcado não implica integração automática com o CMMS.
6. O CMMS gera um identificador único, registra quem abriu a solicitação e a encaminha para triagem da manutenção.
7. O CCO informa ao operador o identificador da solicitação e como receber atualizações.

## Fluxos alternativos e exceções

- **Risco iminente ou emergência:** o CCO segue primeiro o procedimento de emergência e registra a solicitação assim que for seguro fazê-lo. O registro no CMMS não substitui a comunicação de emergência.
- **Equipamento não pode se deslocar com segurança:** o CCO mantém o equipamento no local, aciona o apoio necessário e registra a necessidade de atendimento no local ou de transporte especializado.
- **Informações incompletas ou comunicação interrompida:** o CCO registra o que foi confirmado, identifica os campos pendentes e tenta contato novamente. Não deve preencher dados desconhecidos como se fossem confirmados.
- **Relato recebido por rádio:** o operador do CCO registra manualmente a informação no CMMS, identificando o canal e os horários do contato e do registro.
- **Relato offline ou com anexos:** documentos podem ser anexados à OS. Gravações (de rádio, por exemplo) são transcritas, e a transcrição é registrada no relato.
- **Relato registrado offline:** o registro feito sem conectividade é enviado e reconhecido automaticamente quando o dispositivo voltar a ficar online, desde que o intervalo entre a geração e o reconhecimento seja de até 24 horas. Acima disso, o CMMS retém o registro e exige intervenção manual para aceitá-lo, verificando duplicidade com solicitações já abertas.
- **Relato recebido por mensagem embarcada:** o operador do CCO transcreve ou anexa a mensagem conforme os recursos e procedimentos disponíveis; se não houver integração, o registro é manual.
- **Equipamento ou solicitação já cadastrados:** o CCO verifica se existe uma solicitação aberta para a mesma falha. Se houver, relaciona o novo relato ao registro existente em vez de perder a informação ou criar duplicidade sem justificativa.

## Resultado esperado

Uma solicitação identificável e rastreável, encaminhada à manutenção com informações suficientes para a triagem; qualquer risco imediato permanece sob o fluxo operacional/de emergência apropriado.

## Critérios de aceitação

- Não é possível enviar uma solicitação sem identificar o equipamento e descrever o problema; informações indisponíveis podem ser marcadas como pendentes.
- A solicitação registra o operador que relatou, o canal de entrada, o horário do relato, o horário do registro e o profissional do CCO responsável pelo registro.
- O relato e as orientações de segurança ficam preservados no histórico.
- O CCO consegue consultar o identificador e o estado atual da solicitação.
