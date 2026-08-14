---
User skills: C:\Users\<<user>>\.agents
---

# GitHub copilot skills

## What is a skill
A reusable workflow that Copilot automatically loads when it detects a matching problem. Skills are folders containing instructions and supporting resources, typically centered around a `SKILL.md` definition

Think of it as:

```
Prompt + Knowledge + Process
```

Instead of 

```
Prompt only
```

## Should you create different skills?

Absolutely.

In fact, that's the recommended approach.

Instead of one giant skill:

```
legacy-dotnet
```

Create several focused skills.

Example:

```
skills/  
│  
├── dotnet-framework-analysis  
├── dotnet-modernization  
├── dependency-injection  
├── unit-test-generation  
├── performance-review  
├── code-review  
├── architecture-review
```

Each skill should solve a specific problem.

[GitHub's documentation](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills) explicitly describes skills as specialized task guidance that the agent can discover and apply when relevant.

## Example: Legacy C# modernization

```
skill: dotnet-modernization
```

Responsabilities:

```
When analyzing legacy .NET code:  

1. Detect outdated patterns.  
2. Identify static dependencies.  
3. Recommend DI.  
4. Suggest migration path:  
   Framework -> .NET 6 -> .NET 8.  
5. Preserve business behaviour.  
6. Estimate migration complexity.
```

Then every time you ask:

```
PROMPT: Analyze this service.
```

Copilot automatically has your modernization strategy loaded.

## When to use Agent or Skill?

My rule:
### Use an Agent when:

You need a role.

Examples:

- Architect
- Reviewer
- Security Expert

---

### Use a Skill when:

You need a repeatable process.

Examples:

- .NET modernization
- Unit-test generation
- API documentation generation
- Performance analysis

---

For the example situation:

✅ Agent: "Legacy Modernization Architect"

PLUS

✅ Skill: "dotnet-modernization"

This combination is much stronger than either one alone.
