## TO-DO list
[v] 1. Lack of header in the results file
[v] 2. Change the log to add if the DGST simulation was:
- "Using complete Power Clerk files (Default for Scheduled Simulations)" **or** 
- "Only run DER present in Adhoc Power Clerk Files (Manual trigger only)"
[v] 3. Change the Analysis Type to **XFOCHECK** 
- Documentation not found, instructions from Tanyon by chat group
	- PHASE 1: Analysis type should be **XFOCHECK** 
	- PHASE 2: Analysis type will be **PRELIMINARY**
	- PHASE 3: Analysis type could be **SUPPLEMENTAL** or **CESIR**
[ ] 4. Some error messages are missing
- Result files missing information
	- CYME Transformer Capacity Study Results
	- CYME Model Error Message
	- CYME Results Last Update
- Example to test (from Carl) - ORU3 or ORU4 can be used, project name `ORU`:
	- ```
		ANALYSIS_TYPE=XFOCHECK  
		PROGRAM_TYPE=DGINT  
		NETWORK_ID=63-2-13  
		DEVICE_NUMBER=DGINT-08467  
		DEVICE_TYPE=74  
		QUEUED_DATE=2026-12-07 23:26:41.000Z  
		PROJECT_ID=2b1bdce8-c350-4055-840c-fc6b98640f79
	  ```
[ ] 5. Modify the list of "networks" when initiating a session with the "CYME Server" so that it uses the feeders from the list of records to be submitted for analysis ("/transformer-check/run").
[ ] 6. Update DI-Gateway DDS document.