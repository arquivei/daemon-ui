import QtQuick 2.12
import '..'

DsButton {
    id: prevActionBtn
    text: prevLabel
    size: DsButton.Sizes.Small
    type: DsButton.Types.Inline

    onClicked: {
        prev();
    }
}
