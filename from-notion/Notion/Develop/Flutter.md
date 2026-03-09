---

---
Para utilizar um device

1 - no wsl2, instalar a imagem do android que está no dispositivo

exemplo: sdkmanager --install "system-images;android-33;google_apis;x86_64" "platforms;android-33" "build-tools;33.0.1"

para obter a lista de imagens: sdkmanager --list

2 - No windows, executar

```javascript
adb devices 
adb tcpip 5555 
# you may need to run adb-kill server and the two commands again 
List of devices attached 
 1234567       device
```

3 - No Wsl2

```javascript
adb connect <IP-of-your-phone> 
connected to <IP-of-your-phone>:5555
adb devices 
List of devices attached 
<IP-of-your-phone>:5555       device 
# you may need to run adb-kill server and the two commands again


flutter devices 
1 connected device: 
 ONEPLUS A6013 (mobile) • <IP-of-your-phone>:5555 • android-arm64 • Android 10 (API 29)
```

HOT RELOAD NÃO FUNCIONOU

Para executar utilizando o emulador no Windows :

1. Inicie o emulador
2. No Power Shell do Windows
    1. adb kill-server
    2. adb -a server nodaemon

O emulador estará disponível.

Comentário: utilizando o "start" do visual studio code a aplicação não funcionou no emulador, utilizando o comando "fluter run" tudo funcionou ....

[https://joshkautz.medium.com/developing-with-flutter-2-0-on-wsl2-a00bd064cf2c](https://joshkautz.medium.com/developing-with-flutter-2-0-on-wsl2-a00bd064cf2c)

