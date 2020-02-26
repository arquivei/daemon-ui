import QtQuick 2.12
import QtQuick.Controls 2.12
import '../helpers/factory.js' as Factory
import '../constants/colors.js' as Colors
import '../constants/z-axis.js' as Z

Item {
    property int type: DsButton.Types.Default
    property int size: DsButton.Sizes.Default
    property bool isHovered: false
    property bool isLoading: false
    property bool isBlocked: false
    property string loadingText

    property var fontSizes: {
        "0": 14,
        "1": 12,
    }

    property var verticalPaddings: {
        "0": 5,
        "1": 2,
    }

    property var horizontalPaddings: {
        "0": 16,
        "1": 8
    }

    property alias fontSize: buttonText.font.pixelSize
    property alias text: button.text
    property alias enabled: button.enabled

    enum Types {
        Default,
        Special,
        Inline
    }

    enum Sizes {
        Default,
        Small
    }

    signal clicked()

    function getTextColor() {
        if (type === DsButton.Types.Inline && enabled) {
            return isHovered ? Colors.GRAYSCALE_500 : Colors.GRAYSCALE_400;
        }

        return Colors.PURE_WHITE;
    }

    function getButtonColor() {
        if (!button.enabled) {
            return Colors.GRAYSCALE_300;
        }

        if (type === DsButton.Types.Inline) {
            return Colors.PURE_WHITE;
        }

        if (type === DsButton.Types.Special) {
            return !isLoading && isHovered ? Colors.FEEDBACK_SUCCESS_DARK : Colors.FEEDBACK_SUCCESS_DEFAULT
        }

        return !isLoading && isHovered ? Colors.BRAND_PRIMARY_DARK : Colors.BRAND_PRIMARY_DEFAULT;
    }

    id: root
    width: button.width
    height: button.height

    DsOverlay {
        id: overlay
        visible: isLoading
        z: Z.OVERLAY
    }

    Button {
        id: button
        leftPadding: isLoading ? 13 : horizontalPaddings[size]
        rightPadding: horizontalPaddings[size]
        verticalPadding: verticalPaddings[size]
        z: isLoading ? Z.ABOVE_OVERLAY : Z.DEFAULT

        background: Rectangle {
            id: buttonBackground
            radius: 4
            color: getButtonColor()

            border {
                width: type === DsButton.Types.Inline ? 1 : 0
                color: isHovered ? Colors.GRAYSCALE_500 : Colors.GRAYSCALE_400
            }

            MouseArea {
                cursorShape: button.enabled && !isLoading ? Qt.PointingHandCursor : Qt.ArrowCursor
                width: parent.width
                height: parent.height
                enabled: button.enabled
                hoverEnabled: !isLoading && !isBlocked

                onClicked: {
                    if (!isLoading && !isBlocked) {
                        root.clicked()
                    }
                }

                onHoveredChanged: {
                    isHovered = !isHovered;
                }
            }
        }

        contentItem: Item {
            id: buttonContent
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height

            Loader {
                id: spinnerLoader
                sourceComponent: isLoading ? Factory.createComponentFragment('DsButtonSpinner') : null

                anchors {
                    verticalCenter: buttonText.verticalCenter
                }
            }

            DsText {
                id: buttonText
                color: getTextColor()
                text: isLoading ? loadingText : button.text
                fontSize: fontSizes[size]
                font.weight: "Bold"
                lineHeight: 22

                anchors {
                    left: isLoading ? spinnerLoader.right : parent.left
                    leftMargin: isLoading ? 8 : 0
                }
            }
        }
    }
}
