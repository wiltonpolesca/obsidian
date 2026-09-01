---  

applyTo: "**"  

---  

## Code Generation Guidance

When generating APIs:

- Use ASP.NET Core Minimal APIs.
- Follow the existing vertical-slice structure.
- Return Result objects from application logic.
- Convert failures to ProblemDetails responses.
- Use dependency injection through endpoint parameters.
- Include CancellationToken parameters.
- Use AsNoTracking() for read-only queries.

When generating tests:

- Prefer integration tests for endpoints.
- Place tests within the same feature slice as the endpoint.