import QtQuick 2.12
import QtQuick.Controls 2.12
import '../constants/colors.js' as Colors
import '../constants/z-axis.js' as Z

Item {
    id: root

    property int type: DsButton.Types.Default
    property int size: DsButton.Sizes.Default
    property bool isHovered: false
    property bool isLoading: false
    property bool isBlocked: false
    property string loadingText

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

    QtObject {
        id: priv
        property var spinnerSrcs: ({
            [DsButton.Types.Default]: 'qrc:/images/spinner.svg',
            [DsButton.Types.Special]: 'qrc:/images/spinner.svg',
            [DsButton.Types.Inline]: 'qrc:/images/spinner-inline.svg',
        })
        property var spinnerSizes: ({
            [DsButton.Sizes.Default]: Spinner.Sizes.Default,
            [DsButton.Sizes.Small]: Spinner.Sizes.Small,
        })
        property var fontSizes: ({
            [DsButton.Sizes.Default]: 14,
            [DsButton.Sizes.Small]: 12,
        })
        property var lineHeights: ({
            [DsButton.Sizes.Default]: 22,
            [DsButton.Sizes.Small]: 18,
        })
        property var verticalPaddings: ({
            [DsButton.Sizes.Default]: 5,
            [DsButton.Sizes.Small]: 2,
        })
        property var horizontalPaddings: ({
            [DsButton.Sizes.Default]: 16,
            [DsButton.Sizes.Small]: 8
        })
        property var loadingLeftPadding: ({
            [DsButton.Sizes.Default]: 14,
            [DsButton.Sizes.Small]: 8
        })
        property var loadingTextLeftMargin: ({
            [DsButton.Sizes.Default]: 8,
            [DsButton.Sizes.Small]: 4
        })
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

    function handleSpinnerDisplay() {
        if (isLoading) {
            spinnerLoader.setSource('Spinner.qml', { source: priv.spinnerSrcs[type], size: priv.spinnerSizes[size] })
        } else {
            spinnerLoader.source = ''
        }
    }

    width: button.width
    height: button.height

    Component.onCompleted: {
        handleSpinnerDisplay();
    }

    onIsLoadingChanged: {
        handleSpinnerDisplay();
    }

    DsOverlay {
        id: overlay
        visible: isLoading
        z: Z.OVERLAY
    }

    Button {
        id: button
        leftPadding: isLoading ? priv.loadingLeftPadding[size] : priv.horizontalPaddings[size]
        rightPadding: priv.horizontalPaddings[size]
        verticalPadding: priv.verticalPaddings[size]
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
                anchors {
                    verticalCenter: buttonText.verticalCenter
                }
            }

            DsText {
                id: buttonText
                color: getTextColor()
                text: isLoading ? loadingText : button.text
                fontSize: priv.fontSizes[size]
                font.weight: "Bold"
                lineHeight: priv.lineHeights[size]

                anchors {
                    left: isLoading ? spinnerLoader.right : parent.left
                    leftMargin: isLoading ? priv.loadingTextLeftMargin[size] : 0
                }
            }
        }
    }
}
