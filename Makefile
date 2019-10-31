.PHONY: build-linux build-windows-32 build-windows-64 run

build-linux:
	qtdeploy -docker -debug build linux_static .

build-windows-32:
	qtdeploy -docker -debug build windows_32_static .

build-windows-64:
	qtdeploy -docker -debug build windows_64_static .

run:
	qtdeploy -debug test desktop .