.PHONY: build-linux build-windows-32 build-windows-64 run vendor

build-linux:
	docker run --rm -e IDUG=1000:1000 -v ${PWD}:/media/daemon-ui-poc -i therecipe/qt:linux_static qtdeploy -debug -ldflags= -tags= build linux /media/daemon-ui-poc

build-windows-32:
	docker run --rm -e IDUG=1000:1000 -v ${PWD}:/media/daemon-ui-poc -i therecipe/qt:windows_32_static qtdeploy -debug -ldflags= -tags= build windows /media/daemon-ui-poc

build-windows-64:
	docker run --rm -e IDUG=1000:1000 -v ${PWD}:/media/daemon-ui-poc -i therecipe/qt:windows_64_static qtdeploy -debug -ldflags= -tags= build windows /media/daemon-ui-poc

run:
	qtdeploy -debug test desktop .

vendor:
	go mod vendor