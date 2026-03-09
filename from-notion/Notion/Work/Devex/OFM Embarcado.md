---

---
Novo tracker

- Fase 1 - Definição do meio pelo qual a aplicação embarcada será atualizada remotamente - 5 a 10 dias
- Fase 2 - Definição do tipo de comunicação que será usada (UDP ou TCP) e documentar os motivos da escolha - 2 dias
- Fase 3 - Definição da interface do protocolo de comunicação - 5 a 10 dias
- Fase 4 - Definição da interface básica do aplicativo embarcado (guideline do Android?) - 5 a 10 dias
- Fase 5.a - Construção do protocolo no embarcado, adaptação, se necessário, no DDP e construção de teste - 90 a 120 dias
- Fase 5.b - Portar e documentar os drivers TrackerBus - 60 dias (Gustavo)
- Fase 5.c - Construção da máquina de regras - 30 dias (Gustavo)
- Fase 5.d - Necessário mais 2 recursos para desenvolvimento Android, depende do término da Fase 3, construção das aplicações. - ?? Dias
    - Plataforma
Interface entre a aplicação e o protocolo de comunicação (local por onde e aplicação irá receber ou enviar dados para o servidor extreme)Sincronismo de dados (estados operacionais, operadores, tarefas, produção, polígonos e outros)Sincronismo de configuração de interfaces de telemetriaTratamento de dados de telemetriaMonitor do status do sistema embarcado (situação dos dispositivos (gps, bullet e outros)) e envio dessa informação para o servidor extremeRecebimento, tratamento e exibição de alarmes gerados pela máquina de regraIdentificação do polígono no qual o equipamento se encontraPortar o loquendo (ver questões de licença)
Obtenção e envio para o servidor Extreme:
Posição GPSVelocidade do equipamentoNível de sinal de comunicaçãoKeep alive
    - Interfaces de acesso ao tracker
LoginHorímetroLogoutAlarme de emergência
    - Interfaces de configuração
IP - embarcado e bullet (usado para obter o nível de sinal)NetIDVolume, brilho e tema (diurno, noturno)Telas de diagnóstico (informações sobre os dispositivos (gps, bullet), ssh, buffers e outros)
    - Interfaces responsáveis pela troca de estado operacional (navegação entre os estados, visualização do estado atual, visualização dos próximos estados possíveis)
Controle de estados que exigem autorizaçãoControle de omissão do operadorControle da regra da mina se permite o buffer de troca de estado ou se é necessário contactar o CCO.
    - Interface para exibição de variáveis de telemetria, por interface
    - Interfaces responsáveis por alocação de tarefa
Recebimento da tarefaControle da execução da tarefaFinalização da tarefa
    - Interface para tratamento de gestão de combustível (comboio)
    - Interface para gestão de check list
    - Interface para tratamento de mensagem
Recebimento de mensagem de voz??? Envio de mensagem pré-estabelecida para o CCO??? Envio de mensagem digitada no embarcado para o CCO