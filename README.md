# Daemon UI - Interface gráfica

Este projeto contém a GUI do daemon.

## Primeiros passos

Se você não tiver o Go 1.12 ou posterior instalado na sua máquina, siga os passos [Aqui](https://golang.org/doc/install)

Utilizamos um binding do framework Qt para Golang. Portanto, para rodar localmente é necessário instalar as dependências dessa bilioteca seguindo os passos [Aqui](https://github.com/therecipe/qt/wiki/Installation-on-Linux)

### Configure o PATH e GOPATH localmente

Verifique qual o arquivo correto de profile do seu terminal (~/.profile ou ~/.bash_profile) e adicione ao final do arquivo:

    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=$HOME/go

### Clone o projeto no workspace do Go

Clone direto do bitbucket:

	$ mkdir -p $(go env GOPATH)/src/bitbucket.org/arquivei
	$ git clone git@bitbucket.org:arquivei/daemon-ui.git
    $ (go env GOPATH)/src/arquivei.com.br/daemon-ui

Entre no diretório do projeto:

	$ cd $(go env GOPATH)/src/arquivei.com.br/daemon-ui

Para rodar o programa localmente, instale as dependências e execute a aplicação:

	$ make vendor
    $ make run

### Gerando binários executáveis

Você pode gerar binário para as plataformas x32 ou x64, que estarão disponíveis na pasta deploy/

    $ make build-windows-32
    $ make build-windows-64
    $ make build-linux

