---

---
## Aplicações necessárias

| App | Comments |
| --- | --- |
| para vídeo conferência | [Jitsi Meet](https://meet.jit.si/)não precisa de instalação, muito bom. |
| WSL | Wsl —install |
| Configurar git ssh salvando senha | https://nazmul-ahsan.medium.com/how-to-prevent-ssh-key-passphrase-prompt-every-time-you-launch-wsl-6856eae31add |
| Node js (windows) | Instalar o NVM para gerenciar as versões do Node.js<br>• [https://github.com/coreybutler/nvm-windows#node-version-manager-nvm-for-windows](https://github.com/coreybutler/nvm-windows#node-version-manager-nvm-for-windows) |
| VSCode | **Extensões<br>Extensão REST client interessante que funciona com um arquivo no código, o vídeo está no ponto onde tem um exemplo de como usar**[humao.rest-client](http://humao.rest-client/)[https://youtu.be/y4CayhdrSOY?t=2626](https://youtu.be/y4CayhdrSOY?t=2626)<br>exemplo: <br>api.http<br>GET <<rota get>> |
| Visual Studio | Última versão<br>Para o Entity Framework funcionar<br>dotnet tool install --global dotnet-ef |
| Git (windows) | [https://git-scm.com/book/en/v2/Getting-Started-Installing-Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)<br>git config --global core.editor "code --wait"<br>git config user.name "Wilton Leandro Polesca De Souza"<br>git config user.email "<<EMAIL>>" |
| Ferramenta de design (WEB) | [https://www.figma.com/](https://www.figma.com/) |
| ResponsivelyApp | [A Web Developer's Browser | Responsively App](https://responsively.app/)Permite testar se a página web está responsível |
| WinSCP ou Fillezila | Ferramenta para transferir arquivos via ftp |
| Windows Terminal | Microsoft store |
| Gravação da tela em GIF | [ScreenToGif - Record your screen, edit and save as a gif, video or other formats](https://www.screentogif.com/) <br><br>https://gifcap.dev/ |
| Flutter | 1 - Fazer download do arquivo zip e colocar no path do windows (ou outro sistema operacional)  [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install) (essa instalação disponibiliza o flutter e o dart)<br>2 - Instalar o android studio (necessário para poder compilar e emular o projeto para android) [https://developer.android.com/studio](https://developer.android.com/studio)<br>3 - executar o comando "flutter doctor" para ver se o ambient está correto |
| Variável de ambiente | para desenvolver para Android é necessário colocar o ADB nas variáveis de ambiente.Diretório: C:\Users\[user]\AppData\Local\Android\sdk\platform-tools |
| Criar configuração para rodar o sistema com docker | dotnet dev-certs https -ep %USERPROFILE%\.aspnet\https\aspnetapp.pfx -p password |
| ~~phyton pip~~ | ~~sudo apt-get update~~~~sudo apt install python3-pip~~ |
| mkdocs | sudo apt install python3-pip libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0<br>sudo apt install mkdocs <br>pip install mkdocs-material <br>pip install mkdocs-with-pdf |
| .net wsl | https://nishanc.medium.com/configuring-wsl2-for-net-development-515e8160bae6 |

## Configurações WSL 2

Instalar docker (Seguir a página oficial)

Instalar nvm (para permitir mais de uma versão do node)

-  https://github.com/nvm-sh/nvm 
- [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)

arquivo .bashrc

```javascript
# Wilton aliases 
alias home="cd /home/wilton" 
alias repos="cd /home/wilton/repos" 
alias windows="cd /mnt/c"

# Wilton docker aliases 
alias sd='sudo service docker start'     
alias dcu='docker compose up' 
alias dcud='docker compose up -d' 
alias dck='docker compose kill' 
alias dcd='docker compose down'

alias k='kubectl'

alias startInfra='docker compose -f /mnt/w/gallery/deployments/docker-compose/docker-compose-infra.yml up -d'
alias startDev='docker compose -f /mnt/w/gallery/deployments/docker-compose/docker-compose-dev.yml up -d --build'
alias startProd='docker compose -f /mnt/w/gallery/deployments/docker-compose/docker-compose-prod.yml up -d'
alias stopImages='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias deleteImages='docker image rm $(docker image ls -a -q)'

# Path where mkdocs add files 
export PATH="/home/wilton/.local/bin:$PATH"

```

## Configurações em aplicações específicas

### Docker (máquina Newtrax)

Após instalar o Docker, adicionar configuracão "mirror" para as imagens

[Docker Registry Mirror - Newtrax IoT Hub - Confluence](https://mtloffice.newtrax.com:9000/display/SP/Docker+Registry+Mirror)

```javascript
Docker Engine, key "registry-mirrors"
{
   "builder": {
			"gc": {
				"defaultKeepStorage": "20GB",
				"enabled": true
			}
		},
		"debug": false,
		"experimental": false,
		"features": {
			"buildkit": true
		},
		"insecure-registries": [
			"registry-gitlab.newtrax.com"
		],
		"log-driver": "json-file",
		"log-opts": {
			"max-file": "3",
			"max-size": "10m"
		},
		"registry-mirrors": [
			"https://registry-mirror.newtrax.com"
		]
	}
}
```

### Git

Criar arquivo gitignore global (.global_gitignore por exemplo)

- */*Development*.json
- */.vscode/*

Alterar configuração do arquivo .gitconfig na pasta User

```javascript
[http]
sslVerify = true
sslBackend = schannel

[core]
excludesfile = ~/.global_gitignore

[user]
name = Wilton Leandro Polesca de Souza
email = wpolesca@newtrax.com
```
