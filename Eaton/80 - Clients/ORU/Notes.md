# ORU notes

Tickets:
[[CYMDI-5751] Create ADMS Export Python script - Jira](https://eaton-corp.atlassian.net/browse/CYMDI-5751)
- [[CYMDI-5767|Result]]
[[CYMDI-5767] Modify Substation Import script to support ADMS export requirements - Jira](https://eaton-corp.atlassian.net/browse/CYMDI-5767)

---

#### Context

Bonjout Wilton,
Voici un résumé des informations concernant les tâches pour le projet **ORU Phase 1 - Export ADMS**  qui t'es assigné.

La VM à utiliser sera vm-oru.cyme.local ou alors vm-oru2.cyme.local. Tu regarderas avec @Brice afin de savoir laquelle il préfère que tu utilises pour ton développement.

Tu peux récupérer le repo : **cyme-di-cust-oru**
Les fichiers mentionnés par Philippe se trouve sous Doc\ 

Il est question des documents :

_CYME Gateway for ORU - Substation Data Mapping 1.8.docx_

_CYME Substation Export to ADMS for ORU - Data Mapping 1.0.docx_

Et sous  Export_ADMS il y a le scripte :

_ADMS_Export.py_

Je t'invite à en prendre connaissance.

===

Salut,

Cette option est designed mais pas encore approuvé par le client. Par contre, ça ne risque pas tant de changer. Si tu as encore des gens qui cherche qqc à faire… C’est un script Python qu’il faut écrire.

Il faut :

- Modifier le script FME d’import des substations et rouler ce script

Ce script n’a pas d’interface. On le roule directement dans le workbench de FME. 

**Attention**, il y a quelques étapes manuelles à faire à la fin. 
- **Il y a un fichier texte dans le répertoire qui explique ça**. 
- On va fournir une BD CYME au client au final. 
- Il y a un nouveau data mapping 1.8 pour les substations. 

Les différences à apporter au script sont en turquoise.
- Développer un script Python
- Il y a un data mapping ADMS 1.0 spécifiquement sur cet export.
- Comme paramètre, demander le répertoire d’output.
- Créer tous les fichiers mentionnés dans le data mapping

J’ai commencé un script Python pour tester mon design. Il est sous Git sous la branche \ git-etn-utilities\cyme-di-cust-oru\Export_ADMS

Philippe

---

## VM

`vm-oru.cyme.local` ou `alors vm-oru2.cyme.local` à confirmé avec Brice

### Documents

- CYME Gateway for ORU - Substation Data Mapping 1.8.docx
- CYME Substation Export to ADMS for ORU - Data Mapping 1.0.docx

##### Excel files

- `Substation ID Mapping.csv`
	-  the flag `DEW source to import` defines if the substation need to be created or not (true/false)
- `ORU 2024 source impedance.xlsx`
	- FID, get connecting to `Substation XFRM Equipment Data_REV3.xlsx` where source matchs between sheets?
	- 
- `C:\dev\git\clients\cyme-di-cust-oru\Doc\Customer Data\Files Required for 1x Equipment Import\Substation XFRM Equipment Data_REV3.xlsx` contains the substation information
		- **fid**: Primary key: *dew_sources. dew_switches, dew_regulator, dew_trans, dew_capacitor
		- SOURCE
		- **CmpName**: *dew_primary, dew_busbar*
		- **CmpType**: *dew_primary, dew_busbar, dew_switches, dew_trans
		- **PartName**: *dew_primary, dew_busbar, dew_switches, dew_trans
		- New CYME Equipment ID 
		- ratingfromPartName
		- **OperatingKV**: *dew_primary, dew_busbar*
		- PriVolt
		- SecVolt
		- priconnection
		- secconnection
		- terconnection
		- desiredVoltage (in Volts)
		- bandwidth
		- Phasing
		- Nameplate MVA
		- NominalRating
		- Summer LTE
		- Summer STE
		- Size Base MVA
		- Z1
		- X/R_1
		- Z0
		- X/R_0
		- Buck
		- Boost

###### Missing columns
dew_primary, dew_busbar:
- Primary_Construction -> Dew_primary only: Construction
- Primary_PhaseSize -> Dew_primary only: PhaseSize
- Primary_PhaseMaterial -> Dew_primary only: PhaseMaterial
- Primary_ PhaseCond -> Dew_primary only: PhaseCond
- OriginalLength -> Length (do not apply length conversion to meter here – keep in feet)

dew_capacitor:
- CooldownPeriod
- maxOperations
- 
---

