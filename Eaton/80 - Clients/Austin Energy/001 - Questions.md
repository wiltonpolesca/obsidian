**1. Will Eaton be granted access to Smallworld (EO) and any other required systems as part of the feasibility assessment and/or development activities?**

**Current answer:**

- AE is working on providing access to Smallworld (Kenny).
- Electric Office Desktop installation is required (Musa).

---

**2. Are we permitted to install software in the development environment (e.g., FME), or must software installations be performed by the Austin Energy team?**

**Answer:**

- Yes. Eaton may install software in the POC environment, provided that the installation is documented.

---

**3. What is the approved process for transferring Eaton project files, considering that the VM does not have internet access (source code, scripts, configuration files, documentation, etc.), from Eaton systems (SharePoint, repositories, laptops) to the Austin Energy environment?**

**a. Confirm that the Austin Energy laptop is intended to serve as the bridge between the Eaton environment and the development VM. If so, what is the approved method for transferring files from the laptop to the VM?**

**i. If yes, can the Austin Energy laptop be connected to Eaton SharePoint?**

**Answer: File transfer process between the Eaton environment and the AE POC environment:**

1. Connect from the Eaton environment to the designated SFTP location and upload the required files.
2. Connect from the Austin Energy laptop to the SFTP location and download the files.
3. Upload the files to the designated folder within the POC environment.

**Note:** Connecting an Austin Energy laptop to Eaton SharePoint requires Austin Energy approval.

---

**4. Are we permitted to temporarily store Eaton project artifacts (source code, scripts, configuration files, project documentation, etc.) on Austin Energy laptops?**

**Answer:**

- Yes.

---

**5. We noticed that MultiSpeak files are available in multiple directories. For the feasibility assessment, could you confirm which MultiSpeak dataset should be used as the reference sample for the analysis?**

**Answer:**

- Use the ADMS dataset, organized by feeder.