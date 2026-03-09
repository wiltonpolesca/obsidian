---

---
1 - Get the image (the `dev` image, cannot have the prefix `build-` )

- docker pull your-image
    - Example: docker pull [registry.gitlab.com/newtrax/iot-hub/core/iot-hub/npd-distribution-kiosk-server:hotfix-ser-7218-kiosk-assoc-error](http://registry.gitlab.com/newtrax/iot-hub/core/iot-hub/npd-distribution-kiosk-server:build-hotfix-ser-7218-kiosk-assoc-error)

2 - Tag the image

- docker tag [registry.gitlab.com/newtrax/iot-hub/XXX:YYY](http://registry.gitlab.com/newtrax/iot-hub/XXX:YYY) [newtrax.azurecr.io/server-platform/XXX:YYY](http://newtrax.azurecr.io/server-platform/XXX:YYY)
- Example:
    - docker tag [registry.gitlab.com/newtrax/iot-hub/core/iot-hub/npd-distribution-kiosk-server:hotfix-ser-7218-kiosk-assoc-error](http://registry.gitlab.com/newtrax/iot-hub/core/iot-hub/npd-distribution-kiosk-server:build-hotfix-ser-7218-kiosk-assoc-error) [newtrax.azurecr.io/server-platform](http://newtrax.azurecr.io/server-platform)/[npd-distribution-kiosk-server:build-hotfix-ser-7218-kiosk-assoc-error](http://registry.gitlab.com/newtrax/iot-hub/core/iot-hub/npd-distribution-kiosk-server:build-hotfix-ser-7218-kiosk-assoc-error)

3 - Export the image to `.tart.gz` file.

- docker save your-image | gzip > your-image.tar.gz

4 - Copy the image to IoT server

- scp your-image.tar.gz [newtrax@](mailto:newtrax@10.0.14.191)<<SERVER IP>>:/tmp

5 - Import the new image into Kubernetes (must use ROOT (su) user)

- `pigz -d -c <filename.tar.gz> | ctr -n=`[k8s.io](http://k8s.io/)` image import -`

6 - Patch the deployment

- kubectl patch kustomizations/<<SERVICE NAME>> -n flux-system --field-manager=flux-client-side-apply --type=merge -p "{\"spec\":{\"images\":[{\"name\":\"<<PREFIX TAG OF THE SERVICE: (EXAMPLE: [newtrax.azurecr.io/server-platform/core/iot-hub/npd-distribution-kiosk-server](http://newtrax.azurecr.io/server-platform/core/iot-hub/npd-distribution-kiosk-server))>>\",\"newTag\":\"<<IMAGE NAME>>\"}]}}"
- Example:
    - kubectl patch kustomizations/npd-distribution-kiosk-server -n flux-system --field-manager=flux-client-side-apply --type=merge -p "{\"spec\":{\"images\":[{\"name\":\"[newtrax.azurecr.io/server-platform/core/iot-hub/npd-distribution-kiosk-server](http://newtrax.azurecr.io/server-platform/core/iot-hub/npd-distribution-kiosk-server)\",\"newTag\":\"hotfix-ser-7218-kiosk-assoc-error\"}]}}"

7 - Ensure that the service `kustomize-controller` is running, it is responsible to apply the changes