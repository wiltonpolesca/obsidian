---

---
**Embarcado (Tracker 360)**

- **Protocolo de comunicação (Enviar um pacote maior do que ele fragmentado)(2, 20)**
- Persistência e gerência do buffer de comunicação
- Sincronismo de dados (implementar o novo formato)
- Problemas internos relacionados ao uso do banco de dados (com problemas, porém funciona)
- Forma de trabalho adotado para a construção de aplicação (utilização de imagens no lugar de utilizar a IDE do QT)
- **[Omissão] Problemas, a princípio relacionado ao sincronismo, necessário mais validações. Cliente relata que nunca funcionou. (20, 22)**
- **[Alarme de emergência] De acordo com o cliente, está sendo gerado sem que o operador acione o comando no embarcado (1).**
- **[Opções] Retornar os botões de áudio e brilho para o botão Opções, não há problema em tê-los na configuração também. (26)**
- [Trackerbus] Sincronismo de variáveis e cálculo de exceção/compressão
- Device drivers hardcode
- Dados de configuração que não são alterados via interface gráfica, apenas por ssh ou porta debug
- Unificar plugins que tem a mesma funcionalidade, ex LoginExtreme e LoginUnderground
- Logout - Requisitar um estado que realiza logoff no tracker
- [Segurança] - A navegação na árvore de falhas passa o sentimento de travamento no tracker devido a grande demora para descer ou subir um nível nos itens.

---

**Servidor**

- [SDK] Modificar o processo de segurança para que a conexão seja realizada através de um GUID e a função "Login/Logout" seja realizado separadamente, na conexão ativa.
- [DDP] Separar em dois projetos, um serviço de comunicação e um de processamento
- [DDP] Criar ferramentas de diagnóstico de comunicação
- [DDP] Sistema travou quando 2 trackers enviaram uma quantidade alta de dados de telemetria
- [DDP] Problema na liberação de recursos (porta de comunicação)
- **[Mensagem] Envio para grupo de equipamentos não está funcionando (21)**
- [Operadores] Desvincular do cadastro de usuários
- [Tarefas] Erro ao ativar novo plano, o plano antigo não está sendo desativado e a aplicação entende que não existe plano ativo, necessário intervenção manual
- [Tarefas - Melhoria] Disponibilizar mecanismo que permita o envio da tarefa nas seguintes opções: enviar agora; agendar para; ou ao "na ordem da fila" com opção de + x minutos.
- [Tarefas - Melhoria] Mapear e documentar todo o fluxo da tarefa e seu entrelaçamento com a produção, hoje essa informação está falha e na cabeça de poucos
- [Snapshot] Apresenta problemas de performance e não tem informações importantes para análise (data e origem do registro) - Existe um estudo de reestruturação que não foi iniciado.
- [Melhoria] Rever os Gerenciadores para fornecer aos clientes (aplicação, rest ou outros) informações já processadas, evitando excesso de chamadas no servidor para montar objeto.
- [Melhoria] Device - Incluir IP do rádio
- [Histórico] Permitir a troca de tipo de um equipamento sem que o histórico se perca
- **[Bloquear turno] Verificar se está ok**

---

**Aplicação**

- [Estrutura/Design]
**Travamentos frequentes quando a mina tem um número maior que 50 equipamentos online (30)**Baixa performance Nenhuma escalabilidadeFalta feedback de processo em execução, a impressão é que a aplicação não está fazendo nada!Moroso para desenvolvimento de novas interfaces Péssimo controle de exceções Logs ininteligíveis Estupidamente lento para iniciar (a ponto de gerar desconforto no cliente)Internacionalização redundante entre as aplicações e de difícil manutençãoExige treinamento especializado em cada tela (não tem padrão entre uma tela e outra, exceto no Settings)Os menus estão estourando e as aplicações ficam inacessíveis (o ícone para acesso não fica visível para ser acionado)Supervisório em full screen gera desconforto para todos os usuários, sugestão dessa opção ser opcional, o usuário informa quando desejar usar assim.
- [Design]
Incluir nome do usuário logado (e foto) na tela principalIncluir cabeçalho na aplicação com o nome da tela aberta, exceto o Settings, o usuário não "sabe" qual tela está abertaAplicações sem íconesModificar o cursor do mouse quando algum processamento estiver em execução.
- [Segurança] Necessário rever o desenho da tela de permissão, está muito ruim.
- [Segurança] Mapear e documentar e validar toda funcionalidade, não existe documentação que explica o que já temos
- [Segurança] Quando um novo plugin é adicionado ao sistema somente o usuário root é capaz de liberar permissão a ele, sendo assim, o usuário precisaria desse usuário para trabalhar.
- [Tarefas] Rever usabilidade, quando a mina tem muitos equipamentos o uso é comprometido pelo layout (ver a nova interface criada pelo Wallace)
- [Contingência] Rever usabilidade, em algumas situações o usuário deseja apenas atualizar um dado do registro e, atualmente, ele tem que lançar tudo novamente.
- [Contingência]Unificar a contingência de estado com a TVP, definir o filtro sempre como sendo por turno, o usuário seleciona a data e informa qual o turno que estão os dados.
- **[Contingência] De acordo com o cliente, ao se atualizar uma informação de produção genérica de quantidade a mesma está sendo gravada com erro.(12, 19)**
[Settings - Melhoria/Sugestão] Rever o layout padrão, requisitar filtro nas telas no lugar de exbir todo o conteúdo das tabelas
- [Alarme] Rever a central de alarmes, está lenta e, aparentemente, está com erro no código.
- [Troca de estado] Para clientes configurados para utilizar a liberação de equipamento na manutenção não permitir que o controlador do supervisório realize troca de estado manual, a tela deve ser travada.
- **[Equipamento] Incluir flag que indica que equipamento está embarcado para que o sistema associe automaticamente o NetID (29)**

---

**Relatórios**

- Definir claramente quais são os relatórios padrões de cada produto
- Treinamento de construção de relatórios para a equipe de desenvolvimento
- Rever o "Modelo" usado para a construção de relatórios, e, se ele for usado, disponibilizar em Inglês, Português e Espanhol
- [Indices] Relatório com alteração de DF após fechamento do mês (avaliar utilizar fechamento de turno)
- **[Produção] Exibição de furo duplicado**