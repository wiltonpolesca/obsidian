## Project

- .NET 10, ASP.NET Core Minimal APIs. No MediatR, no controllers. 
- Persistence: EF Core 9 + PostgreSQL. Migrations in `src/Infrastructure/Migrations`. 
- Vertical slice layout: one folder per feature under `src/Features`. 

## Conventions I care about 

- Use the Result pattern for expected failures. Exceptions are for bugs only. 
- Public API returns ProblemDetails on errors. Never leak stack traces. 
- All EF queries that only read data use `.AsNoTracking()`. 
- Thread `CancellationToken` through every async endpoint and handler. 

## Commands 

- Build: `dotnet build` 
- Test: `dotnet test` 
- Run: `dotnet run --project src/Api` 

## Rules 
  
  - Never edit files under `Migrations/` by hand. 
  - When you add an endpoint, add its integration test in the same slice.