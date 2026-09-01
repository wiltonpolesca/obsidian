# Skills

## What exact it is?

A Skill is essentially a reusable playbook that Copilot can automatically load when a request matches the situation described in the skill. A skill lives in its own folder and contains a `SKILL.md` file with metadata and instructions. GitHub supports both repository-level and personal skills. [add-skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills), [about-agent-skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills)

Think about the difference:

Without Skill:

```
?
```

You write this every time.

With skill:

```
Analyze this legacy service.
```

Copilot automatically loads the skill instructions and uses it.

## Step 1: Creating the first skill

GitHub officially recognizes skills stored under `.github/skills/<skill-name>/SKILL.md`.

```
.your-repo  

│  
├── .github  
│ ├── skills  
│ │ └── dotnet-modernization  
│ │ └── SKILL.md
```

## Step 2: Creating a simple SKILL.md

1. Create the file: `.github/skills/dotnet-modernization/SKILL.md`
2. Add the following content:
3. ```
---  
name: dotnet-modernization  
description: Analyze legacy C# and .NET Framework code and propose modernization recommendations.  
---  

# Purpose  

Use this skill when reviewing legacy C# code.  

# Responsibilities  

When analyzing code:  

1. Identify code smells. 
2. Identify SOLID violations.  
3. Detect excessive coupling.  
4. Detect static dependencies.  
5. Suggest dependency injection opportunities.  
6. Suggest migration strategy to .NET 8.  
7. Preserve existing business behaviour.  

# Output Format  

## Findings  

- Finding 1  
- Finding 2  

## Risks  

- Risk 1  

## Recommendations  

- Recommendation 1  
- Recommendation 2  

## Modernization Roadmap  

### Quick Wins  

### Medium-Term Changes  

### Long-Term Migration
	```

## Step 3: Use the skill

```
Review this class
```

Because the request is related to legacy analysis and the description matches, Copilot can discover and use the skill automatically. Skills are designed to be automatically activated when relevant.

## Step 4: Make it smarter

After a few uses you'll realize:

> "I always want the same type of analysis."

Then improve the skill (increment the current skill). 

Example:

```
# Severity Levels  

Classify findings as:  

- Critical  
- Major  
- Minor  

# Architecture Checks  

Verify:  

- SOLID  
- Layer separation  
- Repository pattern usage  
- Dependency inversion  

# Modernization Checks  

Evaluate:  

- Upgrade difficulty  
- Framework dependencies  
- Legacy APIs  
- Testability
```

Now you have a mini consultant embedded in Copilot.

### A real example

Suppose you have:

```c#
public static class CustomerManager  
{  
    public static Customer GetCustomer(int id)  
    {  
        var db = new SqlConnection(...);  
        ...  
    }  
}
```

Without a skill:

Copilot may tell you:

```
Consider dependency injection.
```

Very generic.

With the skill

.....

## Step 5: Add examples

This is where skills become powerful.

Inside the skill folder:

```
.github  
    └── skills  
        └── dotnet-modernization  
            ├── SKILL.md  
            └── examples.md
```

examples.md

```
Good Recommendation  

Problem:  
Static dependency.  

Recommendation:  
Extract interface.  
Inject through constructor.  
Register in container.  

Bad Recommendation  

Rewrite the entire module.
```

GitHub allows skills to include additional resources and files referenced by the skill. [docs.github.com](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills), [learn.microsoft.com](https://learn.microsoft.com/en-us/visualstudio/ide/copilot-agent-skills?view=visualstudio)

Examples often improve results more than adding more instructions.