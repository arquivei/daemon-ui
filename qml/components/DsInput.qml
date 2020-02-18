import QtQuick 2.12
import QtQuick.Controls 2.12
import '../helpers/factory.js' as Factory
import '../constants/colors.js' as Colors
import '../constants/fonts.js' as Fonts

Item {
    property string placeholder
    property string label
    property string errorMsg
    property bool isPassword

    property alias text: input.text

    signal blur(string value)

    function getInputBorderColor() {
        if (errorMsg) {
            return Colors.FEEDBACK_ERROR_DEFAULT;
        }

        if (input.activeFocus) {
            return Colors.BRAND_SECONDARY_DEFAULT;
        }

        return Colors.GRAYSCALE_300;
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
        placeholderTextColor: Colors.GRAYSCALE_400
        selectByMouse: true
        selectionColor: Colors.BRAND_SECONDARY_DEFAULT
        color: Colors.GRAYSCALE_500
        font.pixelSize: 14
        font.family: Fonts.PROXIMA_NOVA_SOFT
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
        sourceComponent: errorMsg ? Factory.createComponentFragment('DsInputErrorText') : Factory.createEmptyFragment()
        anchors.top: input.bottom
        anchors.topMargin: errorMsg ? 4 : 0
    }
}
