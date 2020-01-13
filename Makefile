.PHONY: build-linux build-windows-32 build-windows-64 run

build-linux:
	docker run --rm -e IDUG=1000:1000 -v ${GOPATH}:/media/sf_GOPATH0 -e GOPATH=/home/user/work:/media/sf_GOPATH0 -i therecipe/qt:linux_static qtdeploy -debug -ldflags= -tags= build linux /media/sf_GOPATH0/src/bitbucket.org/arquivei/daemon-ui-poc

build-windows-32:
	docker run --rm -e IDUG=1000:1000 -v ${GOPATH}:/media/sf_GOPATH0 -e GOPATH=/home/user/work:/media/sf_GOPATH0 -i therecipe/qt:windows_32_static qtdeploy -debug -ldflags= -tags= build windows /media/sf_GOPATH0/src/bitbucket.org/arquivei/daemon-ui-poc

build-windows-64:
	docker run --rm -e IDUG=1000:1000 -v ${GOPATH}:/media/sf_GOPATH0 -e GOPATH=/home/user/work:/media/sf_GOPATH0 -i therecipe/qt:windows_64_static qtdeploy -debug -ldflags= -tags= build windows /media/sf_GOPATH0/src/bitbucket.org/arquivei/daemon-ui-poc

run:
	qtdeploy -debug test desktop .

vendor:
	go get -v gopkg.in/natefinch/lumberjack.v2
	go get -v github.com/sirupsen/logrus