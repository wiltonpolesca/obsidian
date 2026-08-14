# Component DatabaseConnectionPicker

# Actors

- Developer: Qualified professional that will use the component to create user interfaces
- User: Final user, system user, people how will interact with the system, input data and have feedbacks 
# Goal

- The User Control DatabaseConnectionPicker will be responsible to allow the user input data to connect to different database (i.e. MS Sql Server, Oracle, Postgres, MSAccess, SQLite).
- The control should not have  business logic, it is an agnostic component
- The Developer must be able to define, by properties, which databases are available to User
- The control must have a list of available databases to be select by the User
- After the User select the database type, the component must show the configured properties required by that database type.

## Constraints

- The component must have the common  properties from Control, like name, enabled, visible and others
- The component must have the following own properties:
	- Group: DatabaseTypes (SupportedDatabaseType enum)
		- UseMSSqlSserver
		- UseOracle
		- UserPostgres
		- UseMSAccess
		- UseSQLite
	- Group "ConnectionConfigurations" (DBConnectionTypeConverter)
	- Group "MSSqlServer" (SqlServerTypeConverter)


