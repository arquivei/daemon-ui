.import "http-request.js" as Req

const GA_COLLECT_URL = 'https://www.google-analytics.com/collect';
const VERSION = 1;
const TRACKING_ID = 'UA-54265512-10';

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


