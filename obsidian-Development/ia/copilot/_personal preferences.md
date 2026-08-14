---
Folder: C:\Users\E0862524\AppData\Roaming\Code\User\globalStorage\github.copilot-chat\memory-tool\memories\preferences.md
---


```
# User Preferences

## Code Style

- Always use curly braces `{}` for single-line conditions and loops — no braceless `if`/`foreach`/`for`/`while` bodies.

## Architecture & Design

- Always respect **SOLID principles** regardless of programming language:
  - **S**ingle Responsibility Principle: Each class/function should have one reason to change
  - **O**pen/Closed Principle: Open for extension, closed for modification
  - **L**iskov Substitution Principle: Subtypes must be substitutable for their base types
  - **I**nterface Segregation Principle: Clients should depend on specific interfaces, not general ones
  - **D**ependency Inversion Principle: Depend on abstractions, not concrete implementations

## Reporting

- When a report (code review, analysis, audit, etc.) is requested, always generate a `.md` file with the full report content in addition to showing it in chat.
- The file can be created into ./github/.report-resut folder (create it if don't exist).

## Framework-Specific

- **Avalonia UI**: Does NOT have a native `PasswordBox` control like WPF. Use `TextBox` with `PasswordChar="•"` instead and bind to `Text="{Binding Password}"` property.

```