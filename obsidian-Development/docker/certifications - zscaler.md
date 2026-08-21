# Adding certifications to Podman

## Extracting the certification (Eaton as example)

- Go to a web page that uses the certification such as github
![[getting-certificate-1.png]]

- Click on Certificate is valid
![[getting-certificate-2.png]]

- Click on the details tab and select the Root certificate, then click to export.
![[Pasted image 20260811084929.png]]

- Save your certificate [certificate].crt wherever you want.

## Updating Podman

- Copy the certificate into podman machine: `podman machine scp YOUR-CERTIFICATE.crt podman-machine-default:/tmp/`
- Connects into the machine:  `podman machine ssh`
- Install the CA (certificate):
	- `sudo cp/temp/YOUR-CERTIFICATE.crt /etc/pki/ca-trust/source/anchors/`
	- `sudo update-ca-trust`
- Restart the machine
	- `podman machine stop`
	- `podman machine start`
- Test: `podman pull postgres:18.3-alpine3.23`