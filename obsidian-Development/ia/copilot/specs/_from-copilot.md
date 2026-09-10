Yes. In fact, if you want GitHub Copilot to generate code consistently and follow architectural rules, **a specification file is one of the best approaches**.

There are several levels of effectiveness:

## 1. Use a `copilot-instructions.md` file (Recommended)

GitHub Copilot supports repository-level custom instructions.

Create:

.github/copilot-instructions.md

Example:

# Project Architecture  

  

This project follows Clean Architecture.  

  

Rules:  

- Controllers must not use repositories directly.  

- All business logic goes through Application Services.  

- Dependency Injection is mandatory.  

- Use async/await everywhere.  

- Do not use static classes except for constants.  

- Logging must use ILogger<T>.  

- Use Result<T> instead of throwing exceptions for business validations.  

  

Database:  

- PostgreSQL  

- Entity Framework Core  

  

Testing:  

- xUnit  

- FluentAssertions  

  

Code Style:  

- File-scoped namespaces  

- Primary constructors when possible  

- Use var only when type is obvious


Write:

Scenario: Successful reservation  

  

Given stock = 10  

When reserve 5  

Then remaining stock = 5  

  

Scenario: Insufficient inventory  

  

Given stock = 3  

When reserve 5  

Then operation fails  

``

Then implement those examples as tests.

This is very close to BDD and greatly reduces ambiguity.

---

## 7. Add Examples Copilot Can Reuse

This is extremely important.

If you have:

Sales/  

CreateOrderHandler.cs  

CreateOrderTests.cs  

CreateOrderSpec.md

then when creating:

Billing/  

CreateInvoiceHandler.cs

Copilot will often replicate the same structure.

AI follows patterns better than rules.

---

## 8. My Preferred Setup

For a modular monolith with Wolverine/NATS:

/specs  

ORD-001-create-order.md  

  

/src  

Sales  

CreateOrderHandler.cs  

CreateOrderTests.cs  

  

/tests  

ArchitectureTests.cs  

  

/.github  

copilot-instructions.md

Where:

- **Specs** define requirements.
- **Unit tests** enforce behavior.
- **Architecture tests** enforce design.
- **Copilot instructions** guide generation.
- **CI pipeline** blocks violations.

In practice, **tests are the strongest link between spec and code**. Documentation can be ignored, but a failing test forces the specification to be respected.