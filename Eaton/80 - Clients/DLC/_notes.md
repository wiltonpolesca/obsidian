# Notes

## Databases

- CYME 95
	- VM-DBSQL2022.CYME.LOCAL\SQLSERVER2022
	- DLC_95
- CYME 96
	- VM-DBSQL2019.cyme.local\SQLServer2019
	- DLC_96

CYME_95: C:\CYME\c95.3-64bit
CYME_96: C:\CYME\CYME_96.01\CYME

## To test:

Bonjour Wilton,

Je ne sais pas si Stéphane t'as répondu. Pour ma part j'aurais tendance à dire que 'Oui'.

Ce qui fait qu'un transformer est un _substation transformer_ dans le cadre actuel est ceci :

 `GIS feature: ElectricDistributionDevice where ASSETGROUP = 420/SubstationTransformer and high_side_voltage not in (138 kV, 345 kV)`

Si cette condition est respectée alors je crois qu'il faut appliquer la 'Note B'.

Et par la suite, de ce que je vois, le Transformer doit être 'Customer Owned' pour avoir un EquipmentID qui contient les KVA. 

Autrement les KVA ne figure pas dans l'EquipmentID :

```
If in a substation boundary with StructureOwner = CUSTOMER/Customer Owned:

‘CUST_SUB_’ + High_side_voltage + ‘KV/’ + Low_side_voltage + ‘KV_’ KVAValue + ‘KVA’
KVAValue: Based on TransformerKVA field.

In cases where multiple units are assembled (see Note B), sum up their TransformerKVA.
Else:
‘STATION_’ + High_side_voltage + ‘KV/’ + Low_side_voltage + ‘KV_’ + substation name
```


---

1. OK - Est-ce possible d'enlever _BUS_STATION_ des sections
2. Revoir l'ÉquipmentID des substation_busbar. Mettre SUBSTATION_BUS --> TO USE THE DOCUMENT INSTRUCTIONS
3. CYME_Source -> NOT WORKING
    1. OK - Revoir l'equipmentID (SourceID)
    2. OK - Revoir DeviceNumber 
4. Revoir le NodeID des HeadNode (CYME_NODE qui sont de type HeadNode) -> I DIDN'T UNDERSTAND
5. OK - Revoir les protective device d'interconnexion et s'assurer qu'ils sont à l'intérieur 
6. OK - EquipmentID des transformer (voir ajout en vert) - NOTEB KVAValue ADDED
7. OK -> Revoir ensemble BeaverFalls et ses connexions à 4829 lorsque les modifications aux TieNode et aux breaker seront effectués. (Breaker inside plutôt que Outside) (point 5)
```
CUST_SUB_’ + High_side_voltage + ‘KV/’ + Low_side_voltage + ‘KV_’ KVAValue + ‘KVA’

KVAValue: Based on TransformerKVA field.

In cases where multiple units are assembled (see Note B), sum up their TransformerKVA.

Else:

‘STATION_’ + High_side_voltage + ‘KV/’ + Low_side_voltage + ‘KV_’ KVAValue+'KVA_' + substation name
```



Bonjour,

J’ai de la difficulté à importer les transformateurs haute tension comme sources.

La sous-station **« WoodvilleSS »** contient trois transformateurs dans cette situation. Après l’application de la règle de nommage pour les sources, j’obtiens trois lignes exactement identiques. En raison de cette duplication, **CYME** ne reconnaît qu’un seul enregistrement afin d’éviter les doublons.

**Données du client :**

| subnetworkName | substation_name | properties.SUBNETWORKCONTROLLERNAME | EquipmentID | DeviceNumber | properties.label_text
|--|--|--|--|--|---|
|WoodvilleSS | WOODVILLE |Unknown | WoodvilleSS_WOODVILLE_75KV | Unknown_SOURCE | WOODVILLE #3 23KV TFMR
|WoodvilleSS | WOODVILLE |Unknown | WoodvilleSS_WOODVILLE_75KV | Unknown_SOURCE | WOODVILLE #1 23KV TFMR
|WoodvilleSS | WOODVILLE |Unknown | WoodvilleSS_WOODVILLE_75KV | Unknown_SOURCE | WOODVILLE #2 23KV TFMR

**Logs:


J’ai effectueˊ un test en modifiant le ∗∗«DeviceNumber»∗∗ afin de distinguer les trois enregistrements (∗∗\[ID]_SOURCE∗∗), et les trois sources ont alors eˊteˊ importeˊs correctement.

Quelle est la bonne approche dans ce cas?


Dois−jediffeˊrencierlesenregistrementsaˋl’aidedu∗∗DeviceNumber∗∗,ouexiste−t−iluneautremeˊthoderecommandeˊe?...] **Journal d’extraction :** \[...] J’ai effectué un test en modifiant le **« DeviceNumber »** afin de distinguer les trois enregistrements (**\[ID]\_SOURCE**), et les trois sources ont alors été importées correctement. Quelle est la bonne approche dans ce cas? Dois-je différencier les enregistrements à l’aide du **DeviceNumber**, ou existe-t-il une autre méthode recommandée?




Bom dia!

Pessoal, estou com uma dificuldade para importar os transformers high voltage como source.

A substation "WoodvilleSS" tem 3 transformers nessa situação, após aplicar a regra de nome para sources, eu passo a ter 3 linhas exatamente iguais e, devido a isso, o CYME somente reconhece um registro (evitando duplicidade)

Dados do cliente:


Log da extração:

Eu fiz um teste modificando o "DeviceNumber" para diferenciar os 3 registros (\[ID]_SOURCE) e os 3 sources foram importados.

O que devo fazer nesse caso? 