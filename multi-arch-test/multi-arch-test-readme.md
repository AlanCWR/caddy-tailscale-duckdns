#  Test build for multiple architectures

Here is a series of commands that should work to build a multi-platform image
 and push it to docker hub:

```shell
podman manifest create docker.io/alancwr/multi-arch-test
docker build --platform linux/amd64,linux/arm64 -f multi-arch-test.Dockerfile --manifest docker.io/alancwr/multi-arch-test .
docker manifest push docker.io/alancwr/multi-arch-test
```

If this is successful, it should be possible to run
```shell
docker run alancwr/multi-arch-test
```
and get a different response depending on platform.
For example, 'Hello from x86_64!' or 'Hello from aarch64!'

## Getting to this point

The last piece that was necessary for be to start seeing a successful build instead of
"exec container process `/bin/sh`: Exec format error"
was installing `qemu-user-static`.

Prior to this, I had also set up a podman machine, which required:
N. installing `virtiofsd`
N-1. symlinking `gvproxy`: `ln -s /usr/bin/gvproxy /usr/local/libexec/podman/`
N-2. installing `gvproxy`
...
These might have helped?
N-3. installing podman desktop
N-4. installing `qemu-system`, `qemu-utils`, `podman-docker`, `podman-compose`
N-5. installing `podman-toolbox`
...
This was certainly necessary, though:
1. installing `podman`
