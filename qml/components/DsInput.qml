import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    readonly property string errorColor: '#E84545'
    readonly property string focusColor: '#3CA9E1'
    readonly property string defaultColor: '#D0D0D0'
    readonly property string placeholderColor: '#B3B3B3'
    readonly property string textColor: '#737373'

    property string placeholder
    property string label
    property string errorMsg
    property bool isPassword

    property alias text: input.text

    property Component errorTextComponent: Component {
        DsText {
            id: textError
            text: errorMsg
            color: errorColor
            fontSize: 12
            lineHeight: 20
        }
    }

    property Component emptyComponent: Component {
        Item {}
    }

    signal blur(string value)

    function getInputBorderColor() {
        if (errorMsg) {
            return errorColor;
        }

        if (input.activeFocus) {
            return focusColor;
        }

        return defaultColor;
    }

    id: root
    height: childrenRect.height

    DsText {
        id: textLabel
        text: label
        fontSize: 14
        font.weight: 'Bold'
        lineHeight: 22
    }

    TextField {
        id: input
        placeholderText: placeholder
        placeholderTextColor: placeholderColor
        selectByMouse: true
        selectionColor: focusColor
        color: textColor
        font.pixelSize: 14
        font.family: 'Proxima Nova Soft'
        echoMode: isPassword ? TextInput.Password : TextInput.Normal
        background: Rectangle {
            implicitHeight: 32
            radius: 4
            border.color: getInputBorderColor()
        }

        leftPadding: 16
        rightPadding: 16
        width: parent.width
        anchors.topMargin: 4
        anchors.top: textLabel.bottom

        onFocusChanged: {
            if (!focus) {
                blur(input.text);
            }
        }
    }

    Loader {
        id: loader
        sourceComponent: errorMsg ? errorTextComponent : emptyComponent

        anchors.top: input.bottom
        anchors.topMargin: errorMsg ? 4 : 0
    }
}
