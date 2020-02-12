const PRESENTER_URL = '../screens/%{screen}/%{screen}Presenter.qml';

function parseUrl(templateUrl, placeholder, value) {
  return templateUrl.split(`%{${placeholder}}`).join(value);
}

function createObject(url) {
    const component = Qt.createComponent(url);
    const object = component.createObject();
    if (object === null)
        console.log( "Could not create object");
    return object;
}

function createPresenter(screenName) {
    const url = parseUrl(PRESENTER_URL, 'screen', screenName);
    return createObject(url);
}
