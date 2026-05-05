# Softwares to install

  

| app                       | Comments                                                                                                                                                   |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Jitsi: Online meet        | https://meet.jit.si/                                                                                                                                       |
| vscode                    |                                                                                                                                                            |
| visual studio             |                                                                                                                                                            |
| Respoinsively app         | https://responsively.app/                                                                                                                                  |
| Windows terminal          | windows store                                                                                                                                              |
| WinSCP or Filezila        | FTP tools                                                                                                                                                  |
| ScreenToGif: GIF recorder | https://www.screentogif.com/                                                                                                                               |
| OBS Studio: movie maker   |                                                                                                                                                            |
| wsl                       | wsl --install                                                                                                                                              |
| Install linux dist.       | windows store                                                                                                                                              |
| Screen maker              | https://www.screen-marker-recorder.com/                                                                                                                    |
| Podman                    |                                                                                                                                                            |
| nvm                       | https://github.com/coreybutler/nvm-windows                                                                                                                 |
| lcov-report               | npm install -g lcov-report                                                                                                                                 |
| Git                       |                                                                                                                                                            |
| Remote Desktop manager    | [Devolutions Remote Desktop Manager - Download and install on Windows \| Microsoft Store](https://apps.microsoft.com/detail/xpfcxhf337w98s?hl=en-US&gl=CA) |
| Obsidian                  |                                                                                                                                                            |
| Figma                     | Interface design tool                                                                                                                                      |
  
## Linux (wsl) configurations

Defining wsl default version: `wsl --set-default-version 2`

## Mkdocs configurations

> It requires python, the instructions are to configure it on wsl

```bash
  sudo apt install python3-pip libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0
  sudo apt install mkdocs
  pip install mkdocs-material
  pip install mkdocs-with-pdf
```
  
## bash aliases suggestions
 
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
