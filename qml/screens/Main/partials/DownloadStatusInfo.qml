import '../../../components'
import '../../../constants/colors.js' as Colors
import '../../../constants/texts.js' as Texts
import '../../../helpers/text-helper.js' as TextHelper

DsText {
    property bool show
    property int totalDownloaded

    text: TextHelper.fillStr(Texts.Main.Download.STATUS_INFO, totalDownloaded)
    fontSize: 14
    lineHeight: 22
    color: Colors.BRAND_PRIMARY_DEFAULT
    visible: show
}
