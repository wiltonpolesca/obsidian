---

---
| Comando | Descrição |
| --- | --- |
| firebase login | Logar com conta válida |
| firebase logout |   |
| firebase init | Permite configurar o projeto |
| firebase deploy | atualiza os aquivos de deploy no firebase hosting |
| firebase emultors:start | Inicia o emulador do firebase |
| firebase emulators:export ./emulators/emulators.backup | Exporta os dados do emulador para um backup |
| firebase emulators:start --import=./emulators/emulators.backup | Inicia o emulador com os dados de backup |

Emulators (as configurações ficam no arquivo firebase.json do projeto)

| Nome | Porta |
| --- | --- |
| auth | 6030 |
| firestore | 6010 |
| hosting | 6040 |
| storage | 6020 |
| UI | 6001 |