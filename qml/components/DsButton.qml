import QtQuick 2.12
import QtQuick.Controls 2.12
import '../constants/colors.js' as Colors
import '../constants/fonts.js' as Fonts

Item {
    property int type: DsButton.Types.Default
    property bool isHovered: false
    property bool isLoading: false
    property string loadingText

    property alias fontSize: buttonText.font.pixelSize
    property alias text: button.text
    property alias enabled: button.enabled

    enum Types {
        Default,
        Special,
        Inline
    }

    signal clicked()

    property Component spinnerComponent: Component {
        Image {
            id: spinner
            source: "qrc:/images/loader.svg"
            fillMode: Image.PreserveAspectFit

            RotationAnimation on rotation {
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        }
    }

    property Component emptyComponent: Component {
        Item {}
    }

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
            return 'transparent';
        }

        if (type === DsButton.Types.Special) {
            return !isLoading && isHovered ? Colors.FEEDBACK_SUCCESS_DARK : Colors.FEEDBACK_SUCCESS_DEFAULT
        }

        return !isLoading && isHovered ? Colors.BRAND_PRIMARY_DARK : Colors.BRAND_PRIMARY_DEFAULT;
    }

    id: root
    width: button.width
    height: button.height

    LoadingOverlay {
        id: overlay
        visible: isLoading
    }

    Button {
        id: button
        leftPadding: isLoading ? 13 : 16
        rightPadding: 16
        verticalPadding: 5
        z: isLoading ? overlay.z + 1 : 0

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
                hoverEnabled: !isLoading

                onClicked: {
                    if (!isLoading) {
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
                sourceComponent: isLoading ? spinnerComponent: emptyComponent

                anchors {
                    verticalCenter: buttonText.verticalCenter
                }
            }

            Text {
                id: buttonText
                color: getTextColor()
                text: isLoading ? loadingText : button.text
                font.pixelSize: 14
                font.family: Fonts.PROXIMA_NOVA_SOFT
                font.weight: "Bold"
                lineHeightMode: Text.FixedHeight
                lineHeight: 22
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                anchors {
                    left: spinnerLoader.right
                    leftMargin: isLoading ? 8 : 0
                }
            }
        }
    }
}
