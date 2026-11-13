# How to prepare a delivery package

## 1. Files

1. Update all word documents
	1. Data Mapping
	2. DDS
	3. User manual
2. Update `GatewayAssembyInfo.cs` with new version/reviewer number.
3. Update releasenotes.txt
	1. Check for issues in the Sharepoint portal that should be reported in the document
4. Copy all word documents to server: `\\vm-cymbuilder.cyme.local\Project_PrePackages\[CLIENT-FOLDER]`
5. Create (if it doesn't exist) a version folder
6. Copy all files into this folder

# 2. To generate the package

1. Send a message into `Team channels -> Data Integration -> Release Request Pipeline` asking to have the package generated
	1. In case there are new documents to be included (Data mapping, user manual or others), it must be informed into the message

## 3. Test

1. Install and test the version on client VM
## 4. Sharepoint portal

1. Deliverables -> Update the status of the current release and create the new one with status "Not Started" (always keep the current and next version created)
2. Shared files -> Upload the new package, with the correct name, to this folder.
3. Software Downloads -> Copy the link of `shared files` and add it into this section, with the correct name.
4. Issue Tracker -> All issues, after FAT, must be registre here and, after solved, added into `releasenotes.txt`.

## Notes

### ORU

- The document  `User Data Extensions - Gateway 2.0R1 - With ADMS Export.cymcfg` is part of the release but it is not into the package, must be informed by email to client.
