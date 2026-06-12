# **Best Practices: Copilot Prompts for C# Development**
 
This guide provides a curated set of effective prompt examples you can use with Microsoft Copilot when working in C#. Each section focuses on a key area of software quality: code quality, security, performance, best practices, and additional helpful development tasks.

Use these prompts to guide Copilot toward clear, consistent, and high‑quality assistance in your development workflow.
  
---
## **Code Review**

### Code review + Summary (v2)

Compare my current branch versus main branch and prepare a document with a short summary with the changes, improvements, key changes, behavior impact and suggestions if any.

Always add sequence diagrams or workflows when it is possible.

Instructions:
- Use mermaid to write diagrams.
- Use markdown format output.

### Code review + Summary + Documentation
Compare my current branch versus main branch and prepare two documents
First document: Short summary with the changes, improvements, key changes, behavior impact and suggestions if any.

Second document: A technical document describing the new architecture if any, what was done in a user language to be used to send to team. 

Always add sequence diagrams or workflows when it is possible.

Instructions:
- Use mermaid to write diagrams.
- Use markdown format output.
## Code review + summary
Compare my current branch with main and write a short documentation summary.
Include: (1) purpose of the change, (2) key files/modules changed, (3) behavior impact, (4) tests/CI updates, (5) risks or follow-ups.

Format as: Title + 5–8 bullet points + ‘How to validate’ section.”

***
## 🔍 **Code Quality Prompts**

*   “Check the code quality of the project and provide suggestions for improvement.”
*   “Analyze the codebase for potential bugs and vulnerabilities.”
*   “Review the code for best practices and adherence to .NET coding standards.”
*   “Analyze the code and check for possible memory leaks, excessive CPU usage, and code smells.”
*   “Identify maintainability issues and recommend improvements.”
*   “Review async/await usage and suggest more efficient patterns if applicable.”

***

## 🔐 **Security Prompts**


*  “Scan the code for security vulnerabilities and provide recommendations for remediation.”
*  “Identify potential security risks in the codebase and suggest improvements.”
*  “Review the code for common security issues such as SQL injection, XSS, and CSRF.”
*  “Check whether sensitive data handling follows secure coding practices.”
*  “Review authentication and authorization logic for potential weaknesses.”

***

  

## ⚡ **Performance Prompts**

  
*   “Analyze the code for performance bottlenecks and suggest optimizations.”
*   “Review the code for inefficient algorithms and data structures.”
*   “Check the code for excessive memory usage and suggest improvements.”
*   “Identify areas in the code that can be optimized for better performance.”
*   “Review database or Entity Framework queries for potential performance issues.”
*   “Identify unnecessary allocations or inefficient LINQ usage.”

***

  

## 🧩 **4. Best Practices & Architecture Prompts**

*   “Review the code for adherence to best practices and coding standards.”
*   “Check the code for proper error handling and logging.”
*   “Ensure the code is modular and follows the Single Responsibility Principle.”
*   “Evaluate dependency injection usage and suggest improvements.”
*   “Check the project architecture for alignment with clean architecture or layered architecture principles.”
*   “Identify areas where SOLID principles are not being followed.”

***

## ➕ **Additional Prompts You Might Want to Add**

### 🧪 Unit Testing

*   “Generate unit tests for this C# class using MSTest/XUnit/NUnit.”
*   “Analyze existing unit tests and suggest improvements or identify missing coverage.”
*   “Review the test suite for maintainability and alignment with testing best practices.”

### 🔧 Refactoring

*   “Refactor this code to improve readability, maintainability, and reduce duplication.”
*   “Suggest a cleaner design using dependency injection and proper separation of concerns.”
*   “Improve this class by applying SOLID principles.”

### 📝 Documentation

*   “Generate XML documentation comments for all public methods and classes.”
*   “Document this API or service in a clear, concise way for new developers.”
*   “Provide a technical explanation of this C# class in plain language.”

### 🚀 Migration / Modernization

*   “Identify outdated .NET Framework APIs and suggest modern .NET 10 replacements.”
*   “Recommend improvements to modernize this code for .NET Core / .NET 10.”
*   “Check whether the project structure follows modern .NET patterns (DI, hosting model, configuration, logging).”