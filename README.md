# System Shock shockolate based port for portmaster enabled arm64 devices

Original System Shock port for arm64 devices based on [shockolate](https://github.com/Interrupt/systemshock).

## Compilation

### Automatic
There is a `build.sh` script in this directory that you can use to automate
the process below:

```
. build.sh
```

### Interactive
If you wish to do it manually:
Build and run the docker image:

```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx build . --platform linux/arm64 -t systemshock
docker run --rm --platform=linux/arm64 -v ./build:/root/systemshock --name systemshock systemshock
```

If all went well we should have the systemshock binary inside a newly
created "build" directory.

```
ls -l build/outputs/
```
