# The recommended maturity model

## Level 1

```
Prompts
```

---

## Level 2

```
Prompts
+
Repository instructions
```

Examples:

```
.github/copilot-instructions.md
```

Project standards, naming conventions, architecture rules.

---

## Level 3

```
Instructions
+
Skills
```

Create:
- modernization skill
- review skill
- test-generation skill

---

## Level 4

```
Instructions
+
Skills
+
Custom agents
```

Architect Agent, Reviewer Agent, Modernization Agent.

---

## Level 5 (Advanced)

```
Instructions
+
Skills
+
Agents
_
MCP servers
```

MCP lets Copilot access external systems and data sources when needed. [More information]([GitHub Copilot Instructions vs Prompts vs Custom Agents vs Skills vs X vs WHY? - DEV Community](https://dev.to/pwd9000/github-copilot-instructions-vs-prompts-vs-custom-agents-vs-skills-vs-x-vs-why-339l))

---

If I were mentoring a senior engineer modernizing a large C#/.NET Framework codebase, my first three investments would be:

1. A strong `.github/copilot-instructions.md`
2. A `dotnet-modernization` Skill
3. An `Architect` Agent dedicated to migration and technical debt reduction

Those three typically provide the highest return on effort.