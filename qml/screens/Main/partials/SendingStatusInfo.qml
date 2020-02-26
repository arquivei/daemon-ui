import '../../../components'
import '../../../constants/colors.js' as Colors

DsText {
    property bool show
    property int totalFiles
    property int sentFiles

    text: `Arquivos XML / ZIP enviados hoje: <strong>${sentFiles}</strong> de <strong>${totalFiles}</strong>`
    fontSize: 14
    lineHeight: 22
    color: Colors.BRAND_PRIMARY_DEFAULT
    visible: show
}
