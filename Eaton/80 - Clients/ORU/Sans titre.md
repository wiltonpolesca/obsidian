CreateBESSDevice
CreateECGDevice



1) Obtenir la liste DJINT (session 6.3.1)
2) Crée une session CYME
	- /api/cyme-server/modules/cyme/sessions
	- Payload (avec les valeur default):
```json
{
  "name": "string",
  "networkIds": [
    "string"
  ],
  "loadModelId": 0,
  "parentProjectId": "string",
  "loadNetworkOption": "AllDependencies",
  "connectionSetIds": [
    "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  ],
  "projectId": "string",
  "studyFile": "string",
  "options": {
    "saveCompleteTransactionContext": true,
    "skipValidateIDWithDatabase": true,
    "studyEquipmentMode": true,
    "excludeStudyDetails": true,
    "reportLoadNetworkMessages": true
  },
  "meta": {
    "status": "string",
    "description": "string"
  },
  "extra": {
    "additionalProp1": "string",
    "additionalProp2": "string",
    "additionalProp3": "string"
  },
  "locked": true,
  "unitSystem": "Metric"
}
```
3) Appeler le CYME Server pour l'analyse
	- /api/cyme-server/plugins/or/dgst/sessions/{sessionId}/transformer-check/run
	- Payload

| Variable         | Type        | Possible Values                               | Comments                                                                                                                                                     |
| ---------------- | ----------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **analysisType** | string      | ????                                          |                                                                                                                                                              |
| **programType**  | string      | DJINT ???                                     |                                                                                                                                                              |
| networkId        | string      |                                               | Identifier of the network model that needs to be loaded (passed through from Model Initialization).                                                          |
| projectID        | string      |                                               | The Name of the project created from the DER-Q import process                                                                                                |
| **deviceNumber** | string      | CYME Device Number                            | Identifier of the triggered interconnection DER under study (passed through from Model Initialization).                                                      |
| **deviceType**   | string ???? | CYME DeviceType enum<br>ECG = 34<br>BESS = 74 | The number associated to the DeviceType in CYME                                                                                                              |
| isbmFlag         | string      | UDD “ISBMEnrolled”                            | Matches the Power Clerk “Are you applying under the OR ISBM Demonstration program” column.                                                                   |
| systemCoupling   | string      | UDD “SystemCoupling”                          | Matches the Power Clerk “d. Indicate whether the ESS and DG system inverter(s)/converter(s) are DC-coupled or AC-coupled and provide the following:” column. |
| queuedDate       | string      | UDD “QueuedDate”                              | The date of the APM modification                                                                                                                             |
	|--|-









'76-3-13' -> Delta-Neutral



2023.2.4 -> conferir a versão do FME antes de começar

BEEES => Baterie

`Byme Gateway for ORU - Data Mapping 2.0`

cicuit-id to be extracted -> pode ser alterado para fazer os testes

Gateway10R1_beta10 -> FME -> extract.fmw
Gateway10R1_beta10 -> Temp 

DER -> Distributed Energy Resource
Additional DERs Data são importantes (para fotovoltagem e bateria)
	DGINT
	LDG
	CDC
	NJINT]
estão dentro de customer data - files used for ngr ....

Database:
  - ORU_MAIN_SQL_V95


Repertoire vs Dossie