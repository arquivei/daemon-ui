.import "addresses.js" as Address;

const General = {
    HIRE_DOWNLOAD_LABEL: 'Contratar agora',
    CONFIG_LABEL: 'Configurar agora',
    Modals: {
        LogoutAlert: {
            TITLE: 'Você deseja sair?',
            DESCRIPTION: 'Ao sair da aplicativo o envio e/ou download de documentos será interrrompido. Deseja sair mesmo assim?',
            PRIMARY: 'Não',
            SECONDARY: 'Sim, desejo'
        }
    },
    Menu: {
        CONFIG: 'Configurações',
        ACCESS_PLATFORM: 'Ver detalhes no Arquivei',
        TOUR: 'Tour',
        ABOUT: 'Sobre o Software',
        LOGS: 'Ver Logs',
        LOGOUT: 'Sair'
    }
}

const Auth = {
    USER_INPUT_PLACEHOLDER: 'Insira seu e-mail aqui',
    PASSWORD_INPUT_PLACEHOLDER: 'Insira sua senha aqui',
    INVALID_EMAIL_FORMAT: 'O formato do e-mail é inválido'
};

const Config = {
    TITLE: 'Configurar Integração',
    UPLOAD_SECTION_TITLE: 'Upload de Arquivos',
    UPLOAD_SECTION_DESCRIPTION: 'Selecione a pasta onde estão os arquivos XML ou ZIP que deseja enviar para o Arquivei.',
    DOWNLOAD_SECTION_TITLE: 'Download de Documentos',
    DOWNLOAD_SECTION_DESCRIPTION: 'Selecione a pasta onde deseja armazenar os documentos baixados do Arquivei.',
    DOWNLOAD_SECTION_TITLE_SOON: 'Download de documentos',
    DOWNLOAD_SECTION_DESCRIPTION_SOON: 'Baixe automaticamente seus XMLs direto do Arquivei',
    DOWNLOAD_SECTION_HIRE_DESCRIPTION: 'Você ainda não possui o módulo de download de documentos.',
    SELECT_FOLDER_BUTTON_LABEL: 'Selecionar pasta',
    CHANGE_FOLDER_BUTTON_LABEL: 'Alterar pasta',
    FileDialogs: {
        UploadFolder: {
            TITLE: 'Escolha o diretório de upload'
        },
        DownloadFolder: {
            TITLE: 'Escolha o diretório de download'
        }
    },
    Modals: {
        BeginTour: {
            TITLE: 'Tour de Configuração',
            DESCRIPTION: 'Seja bem-vindo! Para começar, veja como configurar o upload ou o download automático de XMLs para o Arquivei.',
            PRIMARY: 'Começar o Tour',
            SECONDARY: 'Sair'
        },
        ChangeDownloadConfig: {
            TITLE: 'Configurar opções de Download',
            DESCRIPTION: 'Serão baixados documentos que chegarem ao Arquivei a partir da contratação do aplicativo. Deseja alterar essa e outras configurações de Download?<br/><br/>Obs: Você será encaminhado para a web onde poderá realizar as alterações desejadas.',
            PRIMARY: 'Continuar assim',
            SECONDARY: 'Alterar Configurações'
        },
        SameAsUploadFolderError: {
            TITLE: 'Atenção! Pasta já selecionada para Upload',
            DESCRIPTION: 'A pasta selecionada para Download de documentos não pode ser a mesma escolhida para Upload. Por favor, selecione outra pasta.',
        },
        SameAsDownloadFolderError: {
            TITLE: 'Atenção! Pasta já selecionada para Download',
            DESCRIPTION: 'A pasta selecionada para Upload de documentos não pode ser a mesma escolhida para Download. Por favor, selecione outra pasta.',
        },
        ReadingPermissionError: {
            TITLE: 'Atenção! Erro de permissão',
            DESCRIPTION: `Não é possível selecionar a pasta por falta de permissão. Dê permissão de leitura à pasta ou escolha uma nova pasta. <strong><a href="${Address.ABOUT_NO_READING_PERMISSION_ERROR_URL}">Saiba Mais</a></strong>`,
            PRIMARY: 'Entendi'
        },
        WritingPermissionError: {
            TITLE: 'Atenção! Erro de permissão',
            DESCRIPTION: `Não é possível selecionar a pasta por falta de permissão. Dê permissão de escrita à pasta ou escolha uma nova pasta. <strong><a href="${Address.ABOUT_NO_WRITING_PERMISSION_ERROR_URL}">Saiba Mais</a></strong>`,
            PRIMARY: 'Entendi'
        },
        SelectFolderUnknownError: {
            TITLE: 'Atenção! Erro interno',
            DESCRIPTION: `Ocorreu um erro interno e não foi possível selecionar a pasta. Tente novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`,
            PRIMARY: 'Entendi'
        },
        NotSavedModifications: {
            TITLE: 'Alteração não salva',
            DESCRIPTION: 'Você alterou suas configurações, mas não salvou a alteração. Deseja voltar mesmo assim?',
            PRIMARY: 'Sim',
            SECONDARY: 'Fechar'
        },
        SaveConfigsInternalError: {
            TITLE: 'Atenção! Erro interno',
            DESCRIPTION: `Ocorreu um erro interno e não foi possível salvar as configurações. Tente novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`
        }
    }
}

const Main = {
    UPLOAD_SECTION_TITLE: 'Upload de Arquivos',
    UPLOAD_SECTION_DESCRIPTION: 'Status de envio de seus arquivos para o Arquivei.',
    UPLOAD_SECTION_NOT_CONFIGURED_DESCRIPTION: 'Você ainda não configurou o módulo de upload de documentos.',
    DOWNLOAD_SECTION_TITLE: 'Download de Documentos',
    DOWNLOAD_SECTION_DESCRIPTION: 'Status dos documentos baixados do Arquivei para seu computador.',
    DOWNLOAD_SECTION_TITLE_SOON: 'Download de documentos',
    DOWNLOAD_SECTION_DESCRIPTION_SOON: 'Baixe automaticamente seus XMLs direto do Arquivei',
    DOWNLOAD_SECTION_HIRE_DESCRIPTION: 'Você ainda não possui o módulo de download de documentos.',
    DOWNLOAD_SECTION_NOT_CONFIGURED_DESCRIPTION: 'Você ainda não configurou o módulo de download de documentos.',
    SUCCESS_SENDING_WARNING_TITLE: 'Um ou mais arquivos não foram enviados.',
    SUCCESS_SENDING_WARNING_DESCRIPTION: 'Clique em <strong>Ver Detalhes</strong> para visualizar as falhas ocorridas.',
    WEB_DETAILS_BUTTON_LABEL: 'Ver detalhes no Arquivei',
    Modals: {
        BeginTour: {
            TITLE: 'Tela Principal',
            DESCRIPTION: 'Agora que você configurou a aplicação, iremos mostrar como o software funciona e quais informações você poderá acompanhar enquanto a integração com o Arquivei é feita.',
            PRIMARY: 'Começar o Tour',
            SECONDARY: 'Sair'
        },
        ConnectionError: {
            TITLE: 'Offline - Erro de conexão!',
            DESCRIPTION: `<strong>Falha ao tentar conectar aos nossos servidores.</strong><br>Verifique sua conexão com a internet, firewall, configuração de proxy ou antivírus. <strong><a href="${Address.ABOUT_CONNECTION_ERROR_URL}">Saiba Mais</a></strong><br><br>Tentaremos reconectar automaticamente a cada 60s...`
        },
        UploadReadingPermissionError: {
            TITLE: 'Atenção! Erro de permissão na pasta de Upload',
            DESCRIPTION: 'Não é possível fazer o upload dos arquivos a partir da pasta selecionada por falta de permissão. Dê permissão de leitura à pasta ou escolha uma nova pasta.',
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        UploadWritingPermissionError: {
            TITLE: 'Atenção! Erro de permissão na pasta de Upload',
            DESCRIPTION: 'Não é possível fazer o upload dos arquivos a partir da pasta selecionada por falta de permissão. Dê permissão de escrita à pasta ou escolha uma nova pasta.',
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        UploadUseFolderUnknownError: {
            TITLE: 'Atenção! Erro interno na pasta de Upload',
            DESCRIPTION: `Não é possível fazer o upload dos arquivos a partir da pasta selecionada por um erro interno. Tente configurar novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`,
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        UploadUnexistentFolderError: {
            TITLE: 'Atenção! Erro ao acessar a pasta',
            DESCRIPTION: 'Não foi possível acessar a pasta selecionada para o upload dos documentos pois ela está inacessível ou não existe mais. Verifique se as permissões foram alteradas ou escolha uma nova pasta.',
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        DownloadReadingPermissionError: {
            TITLE: 'Atenção! Erro de permissão na pasta de Download',
            DESCRIPTION: 'Não é possível baixar os arquivos para a pasta selecionada por falta de permissão. Dê permissão de leitura à pasta ou escolha uma nova pasta.',
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        DownloadWritingPermissionError: {
            TITLE: 'Atenção! Erro de permissão na pasta de Download',
            DESCRIPTION: 'Não é possível baixar os arquivos para a pasta selecionada por falta de permissão. Dê permissão de escrita à pasta ou escolha uma nova pasta.',
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        DownloadUseFolderUnknownError: {
            TITLE: 'Atenção! Erro interno na pasta de Download',
            DESCRIPTION: `Não é possível baixar os arquivos para a pasta selecionada por um erro interno. Tente configurar novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`,
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        DownloadUnexistentFolderError: {
            TITLE: 'Atenção! Erro ao acessar a pasta',
            DESCRIPTION: 'Não foi possível acessar a pasta selecionada para o download dos documentos pois ela está inacessível ou não existe mais. Verifique se as permissões foram alteradas ou escolha uma nova pasta.',
            PRIMARY: 'Ir para Configurações',
            SECONDARY: 'Fechar'
        },
        AuthenticationLost: {
            TITLE: 'Atenção! Erro de permissão',
            DESCRIPTION: `Sua sessão expirou ou o usuário logado não possui mais permissão no aplicativo. Entre novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`,
            PRIMARY: 'Ir para Login'
        }
    },
    Download: {
        STATUS_INFO: 'Baixando <strong>%{0}</strong> documentos',
        SyncStatus: {
            DEFAULT: 'Buscando documentos',
            LOADING: 'Baixando arquivos',
            SUCCESS: 'Download finalizado',
            ERROR: 'Download interrompido'
        }
    },
    Upload: {
        STATUS_INFO: 'Arquivos XML / ZIP enviados hoje: <strong>%{0}</strong> de <strong>%{1}</strong>',
        SyncStatus: {
            DEFAULT: 'Buscando arquivos',
            LOADING: 'Enviando arquivos',
            SUCCESS: 'Envio finalizado',
            ERROR: 'Envio interrompido'
        }
    }
}


