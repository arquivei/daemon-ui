import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts
import '../../../helpers/text-helper.js' as TextHelper

DsText {
    property bool show
    property int totalFiles
    property int sentFiles

    text: TextHelper.fillStr(Texts.Main.Upload.STATUS_INFO, sentFiles, totalFiles)
    fontSize: 14
    lineHeight: 22
    color: Colors.BRAND_PRIMARY_DEFAULT
    visible: show
}
