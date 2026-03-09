---

---
### Referência para ajuda

[https://youtu.be/a49gYcBwITc](https://youtu.be/a49gYcBwITc)

[https://github.com/codeedu/wsl2-docker-quickstart](https://github.com/codeedu/wsl2-docker-quickstart)

[Install Docker on Windows (WSL) without Docker Desktop - DEV Community 👩‍💻👨‍💻](https://dev.to/bowmanjd/install-docker-on-windows-wsl-without-docker-desktop-34m9)

# Links para verificar se é útil

[ruby on rails - Connecting to WSL2 server via local network - Stack Overflow](https://stackoverflow.com/questions/61002681/connecting-to-wsl2-server-via-local-network)

### Configuração de recursos

Arquivo de configuração: <u>%UserProfile%/.wslconfig</u>

Configuração utilizada atualmente

[wsl2]

options=metadata,umask=22,fmask=11

memory=10GB

swap=3GB

processors=4

# Disable page reporting so WSL retains all allocated memory claimed from Windows and releases none back when free

pageReporting=false

# Turn off default connection to bind WSL 2 localhost to Windows localhost

localhostForwarding=true

# Disables nested virtualization

nestedVirtualization=false

# Turns on output console showing contents of dmesg when opening a WSL 2 distro for debugging

debugConsole=true

## Instalação e configuração

Ativar o WLS e instalar uma distribuição linux

([The Ultimate Guide to Windows Subsystem for Linux (Windows WSL) (adamtheautomator.com)](https://adamtheautomator.com/windows-subsystem-for-linux/))

[WSL Command Line Reference | Microsoft Docs](https://docs.microsoft.com/en-us/windows/wsl/reference)

[WSL.pt-BR/wsl-config.md at live · MicrosoftDocs/WSL.pt-BR · GitHub](https://github.com/MicrosoftDocs/WSL.pt-BR/blob/live/WSL/wsl-config.md#:~:text=wslconfig,-Dispon%C3%ADvel%20no%20Windows&text=Voc%C3%AA%20pode%20configurar%20op%C3%A7%C3%B5es%20de,wslconfig%20.)

---

sudo apt-get install \

apt-transport-https \

ca-certificates \

curl \

wget \

gnupg \

lsb-release \

gnupg-agent \

software-properties-common \

net-tools

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \

"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \

$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt update && sudo apt upgrade

### 

### Instalação NodeJS

[https://github.com/nvm-sh/nvm#installing-and-updating](https://github.com/nvm-sh/nvm#installing-and-updating)

- nvm ls-remote (para exibir as versões disponíveis para instalação)

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

| nvm ls-remote | grep -i 'latest' | Lista as últimas versões disponíveis |
| --- | --- |
| nvm ls-remote | Lista todas as versões disponíveis |

### MKDocs

apt install python3-pip libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0

sudo apt install mkdocs

pip install mkdocs-material

pip install mkdocs-with-pdf

### Instalação Flutter

[https://joshkautz.medium.com/installing-flutter-2-0-on-wsl2-2fbf0a354c78#:~:text=Install%20Flutter,exist%2C%20and%20navigate%20to%20it.&text=Download%20the%20latest%20Flutter%20SDK,for%20different%20platforms%20and%20channels](https://joshkautz.medium.com/installing-flutter-2-0-on-wsl2-2fbf0a354c78#:~:text=Install%20Flutter,exist%2C%20and%20navigate%20to%20it.&text=Download%20the%20latest%20Flutter%20SDK,for%20different%20platforms%20and%20channels).

[https://gist.github.com/jjvillavicencio/18feb09f0e93e017a861678bc638dcb0](https://gist.github.com/jjvillavicencio/18feb09f0e93e017a861678bc638dcb0)

https://joshkautz.medium.com/installing-flutter-2-0-on-wsl2-2fbf0a354c78

https://joshkautz.medium.com/developing-with-flutter-2-0-on-wsl2-a00bd064cf2c  (emulator no windows)

https://joshkautz.medium.com/developing-flutter-with-physical-devices-on-wsl2-windows-10-20c1bff2344b

### Instalação do Docker

Olhar esse link

2023-01-08 -> [https://docs.docker.com/engine/install/u    buntu/](https://docs.docker.com/engine/install/ubuntu/)

curl -fsSL https://get.docker.com | bash

sudo usermod -aG docker $USER

sudo service docker start

- -----------------------------------------------------------------------------------

sudo apt-get update

sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |

sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER

sudo service docker start

Test:

sudo docker run hello-world

References: Linux 22.04

https://docs.docker.com/engine/install/ubuntu/

https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

### Instalação Java

Maven:

sudo apt install openjdk-11-jdk

java --version

sudo apt install maven

Escolher a versão do java

sudo update-alternatives --config java

### 

### Kubernetes

### Minikube

sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube version

### kubectl

sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl

sudo chmod +x /usr/local/bin/kubectl

kubectl version --short --client

### kind

sudo curl -L https://kind.sigs.k8s.io/dl/v0.18.0/kind-linux-amd64 -o /usr/local/bin/kind

sudo chmod +x /usr/local/bin/kind

kind get clusters

### Kustomize

sudo curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

sudo mv kustomize /usr/local/bin/kustomize

sudo chmod +x /usr/local/bin/kustomize

### Protoc

PROTOC_ZIP=protoc-23.4-linux-x86_64.zip

curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v23.4/$PROTOC_ZIP

sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc

sudo unzip -o $PROTOC_ZIP -d /usr/local 'include/*'

rm -f $PROTOC_ZIP

sudo chmod +x /usr/local/bin/protoc

IMPORTANTE: A pasta `include` tem que estar no diretório /usr/local/bin, caso contrário os tipos do google não são reconhecidos

### 

### Windows 11 - Ativar docker ao iniciar

sudo vim /etc/wsl.conf

Addicionar

[boot]

command="service docker start"

### 

### Ativar systemd

[Systemd support is now available in WSL! - Windows Command Line (microsoft.com)](https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/)

Add these lines to the `/etc/wsl.conf` (note you will need to run your editor with sudo privileges, e.g: `sudo nano /etc/wsl.conf`):

[boot]

systemd=true

Final steps

With the above steps done, close your WSL distro Windows and run `wsl.exe --shutdown` from PowerShell to restart your WSL instances. Upon launch you should have systemd running. You can check this with the command `systemctl list-unit-files --type=service` which should show your services’ status.

## Dicas

Aliases (.bashrc)

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

# Path where mkdocs add files

export PATH="/home/wilton/.local/bin:$PATH"

. ~/.bashrc # to reload the configs

após instalar o Ubuntu, adicionar esse linha no arquivo

~/.profile

export NO_PROXY=roslynomnisharp.blob.core.windows.net,vsdebugger.blob.core.windows.net,razorvscodetest.blob.core.windows.net

Isso resolve o problema em abrir a aplicação sendo construída dentro do Ubuntu com o windows.

https://stackoverflow.com/questions/64182612/econnrefused-127-0-0-19000-on-omnisharp-install-in-visual-studio-code-on-wsl2-b

Instalar o chromium (para usar na execução dos testes)

(https://discourse.ubuntu.com/t/using-snapd-in-wsl2/12113)

sudo apt update

sudo apt install snapd

sudo snap install chromium

Adicionar ao .bashrc (sudo code ~/.bashrc)

export CHROME_BIN=/usr/bin/chromium-browser

No Windows, criar pasta: c:/tmp

Salvar e reiniciar o terminal ou rode **source ~/.bashrc**

## WSL hacks

[https://github.com/shayne/wsl2-hacks](https://github.com/shayne/wsl2-hacks)

# Firulas

Modifica o console

[https://dev.to/erickrock80/pt-br-instalando-oh-my-zsh-no-windows-terminal-3a8l](https://dev.to/erickrock80/pt-br-instalando-oh-my-zsh-no-windows-terminal-3a8l)