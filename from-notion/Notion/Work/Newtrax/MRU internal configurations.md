---

---
### Ativar modo Debug

- ssh into the MRU
- user: root
- pass: iMf|Lh#CIS%F\U-P_OMrv)|zi
- edit the file /etc/boxcom/boxcom.cfg
- change LEVEL = 20 to LEVEL = 10
- save the file
- restart bblink1 (systemctl restart bblink)
- - Olivier disse que o problema de `data cut` pode ser visualizado fazendo download da pasta archive analisando os arquivos obtidos (acho que são os últimos 12 dias) .

// pasta **archive** tem o que aconteceu

data/log/

Os logs estarão disponíveis em:

/data/log

file: bblink.log (ou bblink[numero].log

# Serviços do MET antigo

| ID | Name | Notes | Linked to |
| --- | --- | --- | --- |
| 1 | Newtrax MET Communication Service | Permite a comunicação, obtem os dados de boxinfo mas não pegou a configuração | 2 |
| 2 | Newtrax MET Realtime Service | Utilizado pelo `Newtrax MET Communication Service` os dois iniciam sempre juntos | 1 |