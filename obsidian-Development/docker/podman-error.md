
Error: preparing container c4f8b62ff71e54958e10cf12cef9cef57d0ee8d76f0b8c4f6894d17915c26550 for attach: crun: controller `pids` is not available under /sys/fs/cgroup/non-systemd/machine.slice/libpod-c4f8b62ff71e54958e10cf12cef9cef57d0ee8d76f0b8c4f6894d17915c26550.scope/container/cgroup.controllers: OCI runtime error


## Runbook: `crun: controller 'pids' is not available`

**1. Check that it's this error**
```powershell
podman run --rm hello-world
```
If the error mentions `controller 'pids' is not available ... non-systemd/machine.slice`, continue below.

**2. Confirm the cause with a one-off test**
```powershell
podman run --rm --pids-limit=0 hello-world
```
- If you see "Hello Podman World", it's this issue. Go to step 3.
- If it still fails, it's a different problem. Stop here.

**3. Open a shell inside the Podman machine**
```powershell
podman machine ssh
```
Using an interactive shell avoids the quoting problems with PowerShell and Git Bash.

**4. Create the config file (inside the machine shell)**
```bash
sudo mkdir -p /etc/containers/containers.conf.d
printf '[containers]\npids_limit = 0\n' | sudo tee /etc/containers/containers.conf.d/50-wsl-pids.conf
cat /etc/containers/containers.conf.d/50-wsl-pids.conf
```
The output should be exactly two lines:
```
[containers]
pids_limit = 0
```
Then type `exit`.

**5. Restart the machine**
```powershell
podman machine stop
podman machine start
```

**6. Check that it works**
```powershell
podman run --rm hello-world
```

## Things to avoid
- **Windows config:** Don't put this setting in `%APPDATA%\containers\containers.conf.d\`. Podman reads it from there but it has no effect, and if the file is malformed, every podman command breaks.
- **Recreating the machine:** Don't expect `podman machine rm` / `init` to fix it. It also deletes the fix, so after recreating, repeat steps 3–6.
- **Resource limits:** Don't use `--memory`, `--cpus`, `--pids-limit=<n>` or compose `deploy.resources` limits until this is properly fixed. They'll probably fail the same way.

## Checking whether it's been properly fixed
1. Run `wsl --update` and `podman machine stop` / `podman machine start`.
2. Inside `podman machine ssh`, temporarily rename the file:
   ```bash
   sudo mv /etc/containers/containers.conf.d/50-wsl-pids.conf /tmp/
   ```
3. Restart the machine and run `podman run --rm hello-world`.
   - If it works, the fix is no longer needed. Leave the file deleted.
   - If it fails, move the file back to `/etc/containers/containers.conf.d/`.

**Task completed:** Gave a step-by-step checklist for fixing the Podman `pids` cgroup error if it happens again, plus things to avoid and how to check whether the fix is still needed.