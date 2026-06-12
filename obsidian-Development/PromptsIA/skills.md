![[skills.png]]

Skills permite definir como a LLM irá executar uma determinada tarefa, evitando "desvios" e mantendo o padrão do desenvolvimento.

example:
create-rest-endpoint-skill.md
```md
name: create-rest-endpoint
description: Generate a REST endpoint following our Express.js pattern

steps:
  - Create route file in /routes
  - Add controller in /controllers
  - Validate input with Joi
  - Handle errors using middleware
```

---
---

Great choice—this is exactly where **Copilot Skills really shine**. Below is a **ready-to-use set of practical skills** for both **.NET (C# / ASP.NET Core)** and **Angular 21+**, designed for real-world projects (clean architecture, maintainability, and consistency).

---

# 🧠 Copilot Skills for **C# (.NET Core / ASP.NET Core)**

## 1. ✅ `create-api-endpoint`

```
name: create-api-endpoint
description: Create a REST API endpoint following ASP.NET Core best practices
steps:
  - Create controller method with proper HTTP attribute (GET, POST, etc.)
  - Use async/await and Task<ActionResult<T>>
  - Inject service via constructor
  - Validate input using ModelState or FluentValidation
  - Return appropriate status codes (200, 201, 400, 404)
  - Add logging with ILogger
```
---

## 2. ✅ `create-service-layer`


```
name: create-service-layer
description: Generate a service class with business logic abstraction
steps:
  - Define interface in /Interfaces
  - Implement class in /Services
  - Keep business logic separate from controllers
  - Use dependency injection
  - Handle exceptions and map domain errors
``` 

---

## 3. ✅ `create-repository-pattern`

```
name: create-repository-pattern
description: Generate repository pattern using Entity Framework Core
steps:
  - Define repository interface
  - Implement repository usingDbContext
  - Use async EF methods (ToListAsync, FirstOrDefaultAsync)
  - Avoid exposing IQueryable outside repository
  - Add filtering and pagination where needed
```

---

## 4. ✅ `add-logging-and-error-handling`

```
name: add-logging-error-handling
description: Add structured logging and error handling in ASP.NET Core
steps:
  - Use ILogger<T> for logging
  - Log key actions (start, success, error)
  - Add global exception middleware
  - Return ProblemDetails for errors
  - Avoid exposing internal stack traces
```

---

## 5. ✅ `write-unit-test-xunit`


```
name: write-unit-test-xunit
description: Generate unit tests using xUnit and Moq
steps:
  - Use Arrange-Act-Assert pattern
  - Mock dependencies using Moq
  - Cover success and failure cases
  - Verify method calls on mocks
  - Use descriptive test names
```

---

## 6. ✅ `dto-mapping`


```
name: dto-mapping
description: Create DTOs and mapping logic
steps:
  - Define DTO classes separate from entities
  - Use AutoMapper or manual mapping
  - Avoid exposing domain entities in API
  - Validate incoming DTOs
```
---

# ⚡ Copilot Skills for **Angular 21+**

## 1. ✅ `create-feature-component`

```
name: create-feature-component
description: Generate Angular standalone feature component
steps:
  - Create standalone component (standalone: true)
  - Use OnPush change detection
  - Organize HTML, SCSS, TS cleanly
  - Import only required Angular modules
  - Use signals or RxJS for state
```
---

## 2. ✅ `create-angular-service`

```
name: create-angular-service
description: Generate Angular service for API communication
steps:
  - Use HttpClient
  - Define typed interfaces/models
  - Return Observables
  - Handle errors with catchError
  - Keep logic reusable and stateless
```

---

## 3. ✅ `state-management-signal`

```
name: state-management-signal
description: Manage component state using Angular signals
steps:
  - Define signals for state
  - Use computed values where needed
  - Use effect() for side effects
  - Avoid unnecessary subscriptions
```

---

## 4. ✅ `reactive-form`

```
name: reactive-form
description: Create reactive form with validation
steps:
  - Use FormBuilder
  - Define form controls with validators
  - Show validation errors in template
  - Disable submit when invalid
  - Extract validation messages
```
---

## 5. ✅ `http-error-handling`

```
name: http-error-handling
description: Add HTTP error handling in Angular
steps:
  - Use HttpInterceptor
  - Handle common errors (401, 403, 500)
  - Show user-friendly messages
  - Log errors optionally
```
---

## 6. ✅ `lazy-loaded-route`

```
name: lazy-loaded-route
description: Setup lazy-loaded route with Angular router
steps:
  - Use standalone route configuration
  - Lazy load component/module
  - Protect route with guard if needed
  - Optimize bundle size
```
---

# 🚀 Pro Tips (Important)

✅ Keep skills:

- **Small and focused**
- **Action-oriented (steps, not theory)**
- **Aligned with your architecture**

✅ Combine them:

- `create-api-endpoint` + `dto-mapping` + `service-layer`
- `component` + `service` + `state`

---

# 💡 Suggested Folder Structure for Skills

```
.copilot/
  skills/
    dotnet/
      api-endpoint.yaml
      repository.yaml
    angular/
      component.yaml
      service.yaml
```

---

# ✅ Final Advice

- Start with **5–6 key skills per stack** (like above)
- Refine them as your project evolves
- Treat them as your **team’s coding standards baked into AI**

---

If you want, I can next: ✅ Turn this into a **ready-to-paste GitHub Copilot Skills JSON/YAML pack**  
✅ Or tailor it to your **exact architecture (Clean Architecture, DDD, Nx monorepo, etc.)**