---

---
VM SSH password: newtraxiothub

SU: Newtrax00bb

- docker pull <your image>
- docker save -o spt-fix2.tar <your image>
- Linux: gzip < file-name-origin > file-name-destination.gz
- Copy the image to cluster
    - scp <<image.tar>> [newtrax@](mailto:newtrax@10.0.18.54)<<ip>>:/home/newtrax
    - gunzip <file.gz>
    - ssh into OptiMine VM: ssh [newtrax@](mailto:newtrax@10.0.18.54)<<ip>>
    - become root (su)
    - ctr -n=k8s.io image import <<image.tar>>
- go into k9s
- edit your deployment to use the new image
