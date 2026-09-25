If I were in your situation (80+ repositories, mixed VSCode + Visual Studio, same company standards everywhere), I would not put skills, instructions, and agents inside each repository.

Instead, I would use a 3-layer approach.

1. Global Copilot Instructions (company-wide)

Put the rules that should apply to all repositories in your global Copilot configuration.

Examples:

.NET Framework 4.8 preferred
C# coding conventions
Jira formatting
CYME naming conventions
Eaton development practices
PR guidelines
unit test expectations
code review checklist

GitHub Copilot supports global instructions in the Copilot App, which are applied across projects.

Example:

# Global Development Standards

- Prefer C# and .NET Framework 4.8 unless specified otherwise.
- Follow company's naming conventions.
- Use xUnit for tests where possible.
- Generated code must include XML documentation.
- Avoid introducing new NuGet packages without justification.


This becomes your "always-on" context.

2. Shared Skill Repository

Create a dedicated repository:

copilot-enterprise-skills/
│
├── skills/
│   ├── fme-expert/
│   │   └── SKILL.md
│   │
│   ├── cyme-expert/
│   │   └── SKILL.md
│   │
│   ├── jira-writer/
│   │   └── SKILL.md
│   │
│   └── sql-reviewer/
│       └── SKILL.md


Example:

---
name: cyme-expert
description: Knowledge about CYME, DER workflow and utility models
---

When working with CYME:

- Use .NET Framework 4.8
- Prefer existing architecture
- Follow DGST conventions
- Avoid changing XML formats unless required


Skills are intended to be reusable modules that Copilot loads when relevant.

3. MCP Servers for Enterprise Knowledge

This is where things become really powerful.

Your skills can tell Copilot how to work.

An MCP server can give Copilot access to:

Confluence
Jira
Azure DevOps
SharePoint
Internal documentation
SQL metadata
Network repositories

GitHub Copilot now supports MCP integrations and exposes them across its customization model.

For a team your size, I would invest much more in MCP than in prompt engineering.

For example:

User:
Create a Jira task for the XML migration.

Copilot:
- Reads company Jira template
- Looks up architecture standards
- Generates accepted format


without you needing to explain everything repeatedly.

Practical Setup for VSCode

In VSCode I would maintain:

C:\Copilot\
│
├── skills\
│   ├── fme-expert
│   ├── cyme-expert
│   └── jira-writer
│
├── agents\
│   ├── architect.agent.md
│   ├── reviewer.agent.md
│   └── business-analyst.agent.md
│
└── mcp\
    ├── jira.json
    ├── confluence.json
    └── sharepoint.json


Then every repository benefits from the same setup.

Practical Setup for Visual Studio

For Visual Studio (C#), I would avoid repository-local customization whenever possible.

Use:

same GitHub account
same Copilot subscription
same MCP servers
same shared skill library

That way:

VSCode
   ┐
   ├── Shared Skills
   ├── Shared Agents
   └── Shared MCP Servers

Visual Studio
   ┘


Both environments behave similarly.

What I would do if I were starting today

For your particular environment (CYME, FME, .NET Framework 4.8, Jira, many repositories):

Priority 1

Create:

cyme-expert
fme-expert
jira-writer
code-reviewer


skills.

Priority 2

Create MCP connections to:

Jira
Confluence
SharePoint
Azure DevOps

Priority 3

Create reusable agents:

Architect
Developer
Reviewer
Business Analyst

Priority 4

Keep repository-specific instructions only for things that are truly unique to a project.

My recommendation: treat Copilot customizations as their own product. Create one repository such as copilot-enterprise-skills maintained by your team, version it like software, and have every developer consume the same skills, agents, and MCP configuration. That's the closest equivalent to the "build once, use everywhere" workflow that Anthropic is promoting, while remaining aligned with the direction GitHub Copilot is taking with Skills, Agents, and MCP.

English tip: instead of*"my real work environment have many different repositories"* say:

"My work environment has more than 80 repositories."

The subject environment is singular, so use has, not have.