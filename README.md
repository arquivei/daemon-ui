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

	$ mkdir -p $(go env GOPATH)/src/arquivei.com.br
	$ git clone git@bitbucket.org:arquivei/daemon-ui.git
    $ (go env GOPATH)/src/arquivei.com.br/daemon-ui

Entre no diretório do projeto:

	$ cd $(go env GOPATH)/src/arquivei.com.br/daemon-ui

Para rodar o programa localmente, instale as dependências e execute a aplicação:

	$ make vendor
    $ make run

### Limitações

Para o correto funcionamento da interface gráfica, é necessário ter instalado a versão do OpenGL(ES) 2.0 ou superior na máquina cliente. [Link](https://www.qt.io/blog/2016/08/15/the-qt-quick-graphics-stack-in-qt-5-8)

Caso o OpenGL não exista, podemos setar manualmente os drivers gráficos disponiveis abaixo:

Default     - Request with the "" string
Software    - Request with the "software"
Direct3D 12 - Request with the "d3d12"
OpenVG      - Request with the "openvg"

Para correto funcionamento do software em máquinas virtuais (VMs) é necessário utilizar o modo de renderização via `Software`

A alteração será feita adicionando uma nova variável de ambiente de sistema chamada `QT_QUICK_BACKEND`. [Link](https://docs.oracle.com/en/database/oracle/r-enterprise/1.5.1/oread/creating-and-modifying-environment-variables-on-windows.html#GUID-DD6F9982-60D5-48F6-8270-A27EC53807D0)

Exemplo:
    $ QT_QUICK_BACKEND=software

### Gerando binários executáveis

Você pode gerar binário para as plataformas x32 ou x64, que estarão disponíveis na pasta deploy/

    $ make build-windows-32
    $ make build-windows-64
    $ make build-linux

