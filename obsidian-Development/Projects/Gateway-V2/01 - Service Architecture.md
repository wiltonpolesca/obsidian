# Objective  

Create the proposal architecture to document the new version of the Gateway software.

# Context  

- Create a C# windows service responsible by store the configurations to run the migration database (from files or using FME to populate CYME)
- The project must provide an API that will be consumed by an Angular frontend project
	- i18n is mandatory
- Important: I'm opened to listening about Angular vs React, as I would like to have a strong and maintenable project, including the micro-frontend capability, I believe Angular is a better choise.
- The project must be self-hosted
- The project must host the Angular frontend by himself
- The configurations will be stored in a JSON file (no database available)
- Must use NATS to handler async messages
- Create a section to explain witch part of the current project must be preserved on its new version we will created, considering the new version will use a WEB application, all windows forms code or code related to it can be ignored.
	- Table structure (cymerr_message)
		- NETWORKID (string) 
		- ERROR_SEVERITY (enumerable)
		- NETWORKTYPE (string)
		- ERROR_CATEGORY(string)
		- ERROR_CODE (string)
		- ERROR_TEXT (string)
		- ERROR_LOCATION(string)
	- Filters
		- By network id
		- By Error severty
		- By category
		- By free text

### Initial features

To be possible to validate the proposal two simples features must be added
- Gateway configurations: CYMDist Database: A page where the user will be able to configure many databases like Networks, Equipment networks, substations, equipment substations
- Error log visualization: A simple page responsible to show data from cymdist-network table, this page must allow the user to filter the data and show a table with the content
# Requirements  

- This project must be a modern .NET 10.  
- The frontend must use Angular, latest version.
	- use Transloco as i18n library or give me a better suggestion
	- Will be good if we can use the library [Brightlayer UI | Powering Teams to Make What Matters](https://brightlayer-ui.github.io/)) it was developed by Eaton, but I didn't see a new version of it for Angular
- The frontend must be able to load micro-frontends (new pages will be added to specific clients)
- The frontend must use Angular Material + tailwind
- All code must be covered by unit tests
- As the database will be a JSON file, integration tests must be present too.
# Constraints  

- Use Mermaid to draw diagrams when it is needed

# Deliverables  

1. Proposed architecture.  
2. A plan to develop the project 
3. Result in markdown files

# Success Criteria  
