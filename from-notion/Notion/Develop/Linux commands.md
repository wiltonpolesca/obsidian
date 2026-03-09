---

---
| Localizar a pasta de um comando | which <<comando>>exemplo<br>• which docker |
| --- | --- |
| Verificar uso de memória | free -mh |
| Trocar senha (ubuntu) | sudo passwd root |
| print memory usage statistics | vmstat -s |
| print top processes with memory information | top |
| fancy top | htop |
| verificar se wsl está em execução | wsl --list --verbose |
| Shrink wsl images | [How to Shrink a WSL2 Virtual Disk – Stephen's Thoughts (stephenreescarter.net)](https://stephenreescarter.net/how-to-shrink-a-wsl2-virtual-disk/)<br>• Stops WSLwsl.exe –-shutdown<br>• open dikpartdiskpart<br>• Localize the image(NEWTRAX LAPTOP = C:\Users\wpolesca\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04LTS_79rhkp1fndgsc\LocalState\ext4.vhdx)select vdisk file=C:\Users\wpolesca\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04LTS_79rhkp1fndgsc\LocalState\ext4.vhdxcompact vdiskexit |