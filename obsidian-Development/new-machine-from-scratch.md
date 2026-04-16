# Softwares to install

  

| app                                | Comments                                                                                                                                                   |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Jitsi: Online meet                 | https://meet.jit.si/                                                                                                                                       |
| vscode                             |                                                                                                                                                            |
| visual studio                      |                                                                                                                                                            |
| Respoinsively app                  | https://responsively.app/                                                                                                                                  |
| Windows terminal                   | windows store                                                                                                                                              |
| WinSCP or Filezila                 |                                                                                                                                                            |
| ScreenToGif: GIF recorder          | https://www.screentogif.com/                                                                                                                               |
| OBS Studio: movie maker            |                                                                                                                                                            |
| wsl                                | wsl --install                                                                                                                                              |
| Install linux dist.                | windows store                                                                                                                                              |
| Screen maker                       | https://www.screen-marker-recorder.com/                                                                                                                    |
| Podman or docker                   |                                                                                                                                                            |
| nvm                                | https://github.com/coreybutler/nvm-windows                                                                                                                 |
| lcov-report                        | npm install -g lcov-report                                                                                                                                 |
| Git                                |                                                                                                                                                            |
| Remote Desktop manager             | [Devolutions Remote Desktop Manager - Download and install on Windows \| Microsoft Store](https://apps.microsoft.com/detail/xpfcxhf337w98s?hl=en-US&gl=CA) |


  
## VSCode extensions

### Defining a file config hosted at .vscode/extensions.json
  

```json

{

    "recommendations": [
        "msjsdiag.debugger-for-chrome",
        ... list of the extensions
    ]
}

```

### Diagrams

- excalidraw - "pomdtr.excalidraw-editor"
- Drawio -
- Mermaid -

### Markedown

- markdownlint - davidanson.vscode-markdownlint

  ### Frontend general development

"formulahendry.auto-close-tag"
"formulahendry.auto-rename-tag"
"editorconfig.editorconfig"
"nickdemayo.vscode-json-editor"
"pkief.material-icon-theme"
"christian-kohler.path-intellisense"
"esbenp.prettier-vscode"
"wayou.vscode-todo-highlight"
"thibault-vanderseypen.i18n-json-editor"
"firefox-devtools.vscode-firefox-debug"

### Angular

### React

- "planbcoding.vscode-react-refactor"

### Docker/yaml/json...

## Windows git bash config

- To add alias
  - file path: `/etc/bash.bashrc`

## Linux (wsl) configurations

- Define wsl default version
`wsl --set-default-version 2`

  ## Mkdocs configurations

> It requires python, the instructions are to configure it on wsl

```bash
  sudo apt install python3-pip libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0
  sudo apt install mkdocs
  pip install mkdocs-material
  pip install mkdocs-with-pdf
```
  
## bash suggested aliases

- 
```bash

# aliases
alias dcu='podman compose up'
alias dcd='podman compose down'
alias startInfra='podman compose -f /C/dev/wilton/repos/dev-notes/docker/dockercompose.yml up -d'
alias stopImages='podman stop $(podman ps -a -q) && podman rm --force $(podman ps -a -q)'
alias deleteImages='podman image rm $(podman image ls -a -q)'

# Path where mkdocs add files
export PATH="/home/wilton/.local/bin:$PATH"
```
