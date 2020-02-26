.import "addresses.js" as Address;

const ValidateFolder = {
    NO_WRITE_PERMISSION: {
        title: 'Atenção! Erro de permissão',
        description: 'Não é possível selecionar a pasta por falta de permissão. Dê permissão de escrita à pasta ou escolha uma nova pasta'
    },
    NO_READ_PERMISSION: {
        title: 'Atenção! Erro de permissão',
        description: 'Não é possível selecionar a pasta por falta de permissão. Dê permissão de leitura à pasta ou escolha uma nova pasta'
    },
    UNKNOWN_SERVER_ERROR: {
        title: 'Erro interno',
        description: `Ocorreu um erro interno e não foi possível selecionar a pasta. Tente novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`
    }
};

const SaveConfigs = {
    UNKNOWN_SERVER_ERROR: {
        title: 'Erro interno',
        description: `Ocorreu um erro interno e não foi possível salvar as configurações. Tente novamente ou fale com a gente em <strong><a href="mailto:?to=${Address.SUPPORT_EMAIL}">${Address.SUPPORT_EMAIL}</a></strong>`
    }
};
