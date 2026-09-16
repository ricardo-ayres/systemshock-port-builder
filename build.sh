# Disable ASLR to work around issue with qemu+linux6.8+
if [ $(sysctl -n kernel.randomize_va_space) -ne 0 ]; then
	echo "Disabling KASLR to work around qemu+linux6.8+ issue"
	echo "Remember to re-enable ASLR with: sudo sysctl kernel.randomize_va_space=1 when you're done with the builds."
	sudo sysctl kernel.randomize_va_space=0
fi

# Spin up qemu for cross compilation
if [ -z "$(docker buildx inspect | grep arm64)" ]; then
	docker run --rm --privileged \
		docker.io/multiarch/qemu-user-static --reset -p yes
fi

# build the image
docker buildx build . --platform linux/arm64 -t systemshock &&

# configure and build the binary
docker run --rm --platform=linux/arm64 \
	-v ./build:/root/systemshock \
	--name systemshock \
	systemshock

if [ $? != 0 ]; then
	echo "Error!"
	return
fi

ls -l build/outputs/
