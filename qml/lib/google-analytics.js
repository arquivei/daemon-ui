.import "http-request.js" as Req

// Event Constants
const EventCategories = {
    ACTIVITY: 'Atividade',
    AUTHENTICATION: 'Autenticação',
    NAVIGATION: 'Navegação',
    UPLOAD: 'Upload',
    DOWNLOAD: 'Download',
    CONFIG: 'Configuração'
};

const EventActions = {
    // Activity
    APP_RUNNING: 'App em atividade',

    // Authentication
    SUCCESS_LOGIN: 'Login com sucesso',
    SUCCESS_LOGOUT: 'Logout com sucesso',
    ERROR_LOGIN: 'Login com erro',
    ERROR_AUTHENTICATION_SYNC: 'Ocorreu problema de autenticação durante sincronização',

    // Upload
    SUCCESS_UPLOAD_FOLDER_CHOICE: 'Pasta de upload selecionada com sucesso',
    ERROR_UPLOAD_FOLDER_CHOICE: 'Pasta de upload selecionada com erro',
    UPLOAD_FOLDERS_SELECTION_CONFIRM: 'Confirmou seleção de pastas de upload',

    // Download
    SUCCESS_DOWNLOAD_FOLDER_CHOICE: 'Pasta de download selecionada com sucesso',
    ERROR_DOWNLOAD_FOLDER_CHOICE: 'Pasta de download selecionada com erro',
    ERROR_DOWNLOAD_FOLDER_SYNC: 'Ocorreu problema de pasta de download durante sincronização',
    CLICKED_ON_CHANGE_DOWNLOAD_CONFIG_WEB: 'Clicou em Alterar Configurações de Download na Plataforma',
    CLICKED_ON_PURCHASE_DOWNLOAD: 'Clicou em Contratar Download',
    CLICKED_ON_DOWNLOAD_ALREADY_PURCHASED: 'Clicou em Já contratei (Download)',
    DOWNLOAD_NOT_ALLOWED: 'Download ainda não contratado',
    DOWNLOAD_UNPURSHASED: 'Download foi descontratado/desabilitado',

    // Configuração
    SUCCESS_SAVE_CONFIG: 'Configurações salvas com sucesso',
    ERROR_SAVE_CONFIG: 'Configurações com erro',

    // Navigation
    BACK_TO_MAIN: 'Voltou para tela principal',
    CLICKED_ON_ACCESS_PLATFORM: 'Clicou para acessar plataforma',
    CLICKED_ON_TOUR_MAIN: 'Clicou para iniciar Tour Principal',
    CLICKED_ON_TOUR_CONFIG: 'Clicou para iniciar Tour de Config',
    CLICKED_ON_ABOUT: 'Clicou para ler informações do App',
    CLICKED_ON_LOGS: 'Clicou para ver Logs',
    CLICKED_ON_DETAILS_BUTTON: 'Clicou para acessar a plataforma por meio do botão de Detalhes',
    GO_TO_MANAGE_UPLOAD: 'Clicou em Gerenciar pastas de Upload (multipastas)',
    CLOSED_UPLOAD_CONFIG: 'Fechou Configuração de pastas de Upload (Sem salvar)'
};

const ScreenNames = {
    AUTH: 'Tela de Login',
    CONFIG: 'Tela de Configuração',
    MAIN: 'Tela Principal',
    MANAGE_UPLOAD: 'Tela de Gerenciamento de Upload'
};

// Lib Constants
const GA_COLLECT_URL = 'https://www.google-analytics.com/collect';
const VERSION = 1;
const TRACKING_ID = 'UA-54265512-11';
const _required = {
    v: VERSION,
    tid: TRACKING_ID
};
const _params = {
    an: 'Arquivei Daemon'
}

// SET CLIENT_ID ON GLOBAL OBJECT
function setClientId(value) {
    _required['cid'] = value;
}

// SET CURRENT PAGE ON GLOBAL OBJECT
function setScreenName(name) {
    _params['dp'] = name;
}

// SESSION FUNCTIONS
function startSession() {
    const data = {
        query: Object.assign({}, _required, { sc: 'start' })
    };
    Req.post(GA_COLLECT_URL, data);
}

function endSession() {
    const data = {
        query: Object.assign({}, _required, { sc: 'end' })
    };
    Req.post(GA_COLLECT_URL, data);
}

// TRACKING FUNCTIONS
function trackScreen(value) {
    setScreenName(value);

    const data =  {
        query: Object.assign({}, _required, _params, { t: 'pageview', dp: value })
    }
    Req.post(GA_COLLECT_URL, data);
}

function trackException(description, isFatal) {
    const data = {
        query: Object.assign({}, _required, _params, { t: 'exception', exd: description, exf: isFatal ? 1 : 0 })
    }
    Req.post(GA_COLLECT_URL, data);
}

function trackEvent(category, action, label, value, callback) {
    const trackEventObject = {
        t: 'event',
        ec: category,
        ea: action
    }

    if (label) {
        trackEventObject.el = label;
    }

    if (value) {
        trackEventObject.ev = value;
    }

    const data =  {
        query: Object.assign({}, _required, _params, trackEventObject)
    }

    Req.post(GA_COLLECT_URL, data);
}
