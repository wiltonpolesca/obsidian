# Project Context  

This project uses:  

  - .NET 10  
- ASP.NET Core Minimal APIs  
- EF Core 9 with PostgreSQL  
- Vertical Slice Architecture  
## Architecture  

- No MediatR.  
- No MVC controllers.  
- Features are organized by slice under `src/Features`.  
- EF Core migrations are located in `src/Infrastructure/Migrations`.  

## Coding Conventions  

- Use the Result pattern for expected failures.  
- Use exceptions only for unexpected bugs.  
- API endpoints must return ProblemDetails for errors.  
- Never expose stack traces or internal implementation details.  
- All read-only EF Core queries must use `.AsNoTracking()`.  
- Pass `CancellationToken` through every async endpoint, handler, and database call.  

## Testing Requirements  

- When adding a new endpoint, create the integration test in the same feature slice.  
- Ensure new functionality includes appropriate test coverage.  

## EF Core Rules  

- Never manually edit files under `src/Infrastructure/Migrations`.  
- Generate migrations using EF Core tooling only.  

## Commands  

Build:  

```bash  

dotnet build