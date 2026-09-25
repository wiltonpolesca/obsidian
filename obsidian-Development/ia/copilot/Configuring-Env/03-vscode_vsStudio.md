Good news: today, VS Code and Visual Studio should already be able to share the same personal skills folders.

Both products officially recognize:

%USERPROFILE%\.copilot\skills
%USERPROFILE%\.agents\skills
%USERPROFILE%\.claude\skills


for personal skills, and:

<repo>\.github\skills
<repo>\.agents\skills
<repo>\.claude\skills


for repository skills.

If you're seeing different locations

There are a few possibilities:

One tool is configured to use .agents\skills
The other is using .copilot\skills
You are looking at built-in Microsoft skills versus your personal skills
One installation is older and predates the latest Agent Skills standard
My recommendation

Pick one canonical location:

C:\Users\<you>\.copilot\skills


and put all your skills there.

For example:

%USERPROFILE%\.copilot\skills
│
├── cyme-expert
├── fme-expert
├── jira-writer
└── code-reviewer


This is the location most commonly referenced by both GitHub Copilot and Visual Studio documentation.

If you want to keep C:\Copilot

I would create a junction:

mklink /J "%USERPROFILE%\.copilot\skills" "C:\Copilot\skills"


Then:

C:\Copilot\skills


becomes the real storage location, while both VS Code and Visual Studio see:

%USERPROFILE%\.copilot\skills

What I would do for an enterprise setup

For your 80+ repositories, I would create:

C:\Copilot
│
├── skills
├── agents
├── prompts
├── instructions
└── mcp


versioned in Git:

copilot-enterprise-standards


and expose the skills through:

%USERPROFILE%\.copilot\skills


using a junction.

This gives you:

One repository to maintain
One source of truth
Shared behavior in VS Code
Shared behavior in Visual Studio
Easy onboarding for other developers
Quick verification

Open Copilot Chat and ask:

Which skills are currently available?

or

Do you have a skill named cyme-expert?

If the skill appears in both VS Code and Visual Studio, your shared configuration is working correctly.

English correction

Your sentence:

I have notice VSCode and Visual Studio 2026 are using different shared folders

More natural:

I've noticed that VS Code and Visual Studio 2026 use different shared folders. Is it possible to unify them? ✅