You're actually touching on an important detail.

For VS Code, Copilot does not currently let you arbitrarily choose a folder such as:

C:\Copilot\skills


as a built-in skill discovery location.

By default, Copilot searches specific locations such as:

User-level skills

%USERPROFILE%\.copilot\skills


or

%USERPROFILE%\.agents\skills


Repository-level skills

<repo>\.github\skills
<repo>\.agents\skills
<repo>\.claude\skills


depending on the Copilot surface and tool being used.

Option 1: Use .copilot\skills (Recommended)

Personally, I'd do this:

C:\Users\<you>\.copilot\
│
├── skills\
│   ├── cyme-expert\
│   ├── fme-expert\
│   ├── jira-writer\
│   └── code-reviewer\


This is the officially recognized personal skills location and will work across projects.

Option 2: Keep C:\Copilot\ and Create a Junction

If you really want your assets under:

C:\Copilot\


you can make Windows expose them as .copilot\skills.

Example:

mklink /J "%USERPROFILE%\.copilot\skills" "C:\Copilot\skills"


Result:

C:\Copilot\skills


becomes the real storage location while Copilot still sees:

%USERPROFILE%\.copilot\skills


This is the approach I would use.

Benefits:

One central repository
Easy backup
Easy Git versioning
No duplication
Option 3: Configure skill_directories

The Copilot runtime supports explicitly configured skill directories through its configuration mechanism. The documentation and GitHub discussions reference adding custom paths through skill_directories.

Conceptually:

{
  "skill_directories": [
    "C:\\Copilot\\skills"
  ]
}


However, support depends on the Copilot surface being used (CLI, App, VS Code integration). Today I'd consider this secondary to the junction approach because it is more universally reliable.

What I would do in your case

With 80+ repositories:

C:\Copilot
│
├── skills
│   ├── cyme-expert
│   ├── fme-expert
│   ├── jira-writer
│   └── code-reviewer
│
├── agents
│
├── prompts
│
└── mcp


Version everything in Git:

git@github.com:<company>/copilot-enterprise-standards.git


Then create:

mklink /J "%USERPROFILE%\.copilot\skills" "C:\Copilot\skills"


and let both VS Code and the GitHub Copilot App discover them automatically. Skills configured for Copilot CLI or repositories are also surfaced in the GitHub Copilot App.

One thing I'd verify early: are you using the new GitHub Copilot App / Agent Mode features, or only the traditional chat inside VS Code and Visual Studio? The answer changes how much value you'll get from Skills versus Instructions and Agents. Right now, many developers get more immediate benefit from a strong global instruction set plus a few specialized skills than from a large agent catalog.

English correction

Your sentence:

"How should I configure Github copilot to recognize the content into..."

More natural:

"How should I configure GitHub Copilot to recognize content stored in C:\Copilot?"

Also, GitHub and Copilot should be capitalized.