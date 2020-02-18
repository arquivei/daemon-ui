import QtQuick 2.12
import '..'
import '../../constants/colors.js' as Colors

DsText {
    id: textError
    text: errorMsg
    color: Colors.FEEDBACK_ERROR_DEFAULT
    fontSize: 12
    lineHeight: 20
}
