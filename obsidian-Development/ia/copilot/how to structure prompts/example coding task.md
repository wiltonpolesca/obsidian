---
Goal: Create a knowledge base about the best way to use Copilot Prompts
This file: It is an example about a prompt to start to modernize a legacy c# project
---
# Objective  

Modernize the authentication layer.  

# Context  

> It is the biggest improvement to Copilot, not the goal or the objective.

This project is .NET Framework 4.7.2.  
The solution contains legacy repositories and service classes.  
The goal is to move toward .NET 8 while minimizing risk.  
# Requirements  

- Keep business logic unchanged.  
- Use dependency injection.  
- Remove static dependencies.  
- Improve testability.  
# Constraints  

- No breaking API changes.  
- Keep compatibility with existing database schema.  
- Do not introduce third-party libraries.
- Use Mermaid a diagram is needed

# Deliverables  

1. Analysis of current design.  
2. Proposed architecture.  
3. Refactoring plan.  
4. Sample code.  
5. Result in markdown files

# Success Criteria  

- Compiles successfully.  
- Unit-testable.  
- Compatible with migration to .NET 8.