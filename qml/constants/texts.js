.import "addresses.js" as Address;

const General = {
    Modals: {
        FolderPermissionAlert: {
            TITLE: 'Atenção! Erro de permissão',
            DESCRIPTION: 'Não é possível fazer o upload dos arquivos a partir da pasta selecionada por falta de permissão. Dê permissão de leitura e/ou escrita à pasta ou escolha uma nova pasta.'
        },
        LogoutAlert: {
            TITLE: 'Você deseja sair?',
            DESCRIPTION: 'Ao sair da aplicativo o envio e/ou download de documentos será interrrompido. Deseja sair mesmo assim?',
            PRIMARY: 'Não',
            SECONDARY: 'Sim, desejo'
        },
        ValidateFolderInternalError: {
            TITLE: 'Erro interno',
            DESCRIPTION: `Ocorreu um erro interno e não foi possível utilizar a pasta selecionada. Tente novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`
        },
    },
    Menu: {
        CONFIG: 'Configurações',
        ACCESS_PLATFORM: 'Acessar a Plataforma',
        TOUR: 'Tour',
        ABOUT: 'Sobre o DocBox',
        LOGS: 'Ver Logs',
        LOGOUT: 'Sair'
    }
}

const Auth = {
    USER_INPUT_PLACEHOLDER: 'Insira seu e-mail aqui',
    PASSWORD_INPUT_PLACEHOLDER: 'Insira sua senha aqui',
    INVALID_EMAIL_FORMAT: 'O formato do e-mail é inválido.'
};

const Config = {
    TITLE: 'Configurar Integração',
    UPLOAD_SECTION_TITLE: 'Upload de Documentos',
    UPLOAD_SECTION_DESCRIPTION: 'Selecione a pasta onde estão os arquivos que deseja enviar para a Arquivei.',
    Modals: {
        BeginTour: {
            TITLE: 'Configurando o DocBox',
            DESCRIPTION: 'Seja  bem-vindo ao DocBox! Para começar, mostraremos à você nossas funcionalidades e como melhor usá-las para configurar e acompanhar o funcionamento do aplicativo.',
            PRIMARY: 'Começar o Tour',
            SECONDARY: 'Sair'
        },
        FinishTour: {
            TITLE: 'Tour finalizado',
            DESCRIPTION: 'Agora você já sabe como configurar a sua integração, selecionando as pastas de Upload e Download (se disponível). Parabéns!',
            PRIMARY: 'Sair do Tour'
        },
        NotSavedModifications: {
            TITLE: 'Alteração não salva',
            DESCRIPTION: 'Você realizou a alteração da pasta de upload mas não salvou a alteração. Deseja voltar sem salvar?',
            PRIMARY: 'Sim',
            SECONDARY: 'Fechar'
        },
        SaveConfigsInternalError: {
            TITLE: 'Erro interno',
            DESCRIPTION: `Ocorreu um erro interno e não foi possível salvar as configurações. Tente novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`
        }
    }
}

const Main = {
    UPLOAD_SECTION_TITLE: 'Upload de Documentos',
    UPLOAD_SECTION_DESCRIPTION: 'Status de envio de seus documentos para a Arquivei.',
    DOWNLOAD_SECTION_TITLE: 'Download de documentos: em breve!',
    DOWNLOAD_SECTION_DESCRIPTION: 'Baixe automaticamente seus XMLs direto da Arquivei. Seja um dos primeiros a testar!',
    SUCCESS_SENDING_WARNING_TITLE: 'Um ou mais arquivos não foram enviados.',
    SUCCESS_SENDING_WARNING_DESCRIPTION: 'Clique em <strong>Ver Detalhes</strong> para visualizar as falhas ocorridas.',
    Modals: {
        ConnectionError: {
            TITLE: 'Offline - Erro de conexão!',
            DESCRIPTION: '<strong>Falha ao tentar conectar aos nossos servidores.</strong><br>Verifique sua conexão com a internet, firewall, configuração de proxy ou antivírus.<br><br>Tentaremos reconectar automaticamente a cada 60s...'
        },
        AuthenticationLost: {
            TITLE: 'Atenção! Erro de autenticação',
            DESCRIPTION: `Sua sessão expirou ou o usuário logado não possui mais permissão no aplicativo. Entre novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`,
            PRIMARY: 'Ir para Login'
        }
    }
}


