const PRESENTER_URL = '../screens/%{screen}/%{screen}Presenter.qml';
const SHARED_COMPONENT_URL = '../components/%{sharedComponent}.qml';
const SHARED_COMPONENT_FRAGMENT_URL = '../components/fragments/%{fragment}.qml';
const PARTIAL_FRAGMENT_URL = '../screens/%{screen}/partials/%{partial}.qml';

function parseUrl(templateUrl, placeholder, value) {
  return templateUrl.split(`%{${placeholder}}`).join(value);
}

function createObject(url, parent, props = {}) {
    const component = Qt.createComponent(url);
    const object = component.createObject(parent || null, props);
    if (object === null)
        console.log( "Could not create object");
    return object;
}

function createPresenter(screenName) {
    const url = parseUrl(PRESENTER_URL, 'screen', screenName);
    return createObject(url);
}

function createSharedComponent(componentName, parent, props) {
    const url = parseUrl(SHARED_COMPONENT_URL, 'sharedComponent', componentName);
    return createObject(url, parent, props);
}

function createComponentFragment(fragmentName, props) {
    const url = parseUrl(SHARED_COMPONENT_FRAGMENT_URL, 'fragment', fragmentName);
    return Qt.createComponent(url);
}

function createEmptyFragment() {
    const url = parseUrl(SHARED_COMPONENT_FRAGMENT_URL, 'fragment', 'Empty');
    return Qt.createComponent(url);
}

function createPartialFragment(screenName, partialName, props) {
    let url = parseUrl(PARTIAL_FRAGMENT_URL, 'screen', screenName);
    url = parseUrl(url, 'partial', partialName);
    return Qt.createComponent(url);
}
