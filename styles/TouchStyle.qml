import QtQuick 2.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import "../js/buttons.js" as StyleHelper
import "../js/base.js" as Variables

ButtonStyle {
    id: root
    property variant style
    property variant size
    background: Item {
        clip: true
        Rectangle{
            width: StyleHelper.hasClass('full', control.class_name) ? parent.width + 2 *StyleHelper.button_border_width : parent.width
            height: parent.height
            anchors.centerIn: parent
            opacity: control.enabled?1:0.6
            color: {
                if(control.pressed || control.selected)
                    return style.active_border
                else if(control.hovered)
                    return Qt.lighter(style.active_border,1.1)
                else
                    return style.bg
            }

            //border.color: (control.pressed || control.selected) ?  "transparent": style.border
            border.color: style.border
            border.width: StyleHelper.button_border_width
            radius: StyleHelper.hasClass('full', control.class_name) ? 0 : StyleHelper.button_border_radius
            antialiasing: true

            Rectangle {
                visible: (control.pressed || control.selected)
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#26000000" }
                    GradientStop { position: 0.1; color: "transparent" }
                }
            }
        }
    }
    label: RowLayout{
        spacing: 10
        anchors.fill: parent
        anchors.leftMargin: root.size.padding
        anchors.rightMargin: root.size.padding

        layoutDirection: control.iconRight ? Qt.RightToLeft : Qt.LeftToRight

        Text {
            visible: control.icon !== ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: control.icon
            font.family: "FontAwesome"
            font.pixelSize: control.iconSize
            renderType: Text.NativeRendering
            color: root.style.text
            Layout.alignment: Qt.AlignVCenter
        }
        Text {
            visible: control.text !== ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: control.text
            font.pixelSize: control.fontSize
            font.family: Variables.font_family_base
            renderType: Text.NativeRendering
            color: root.style.text
            Layout.alignment: Qt.AlignCenter
        }
    }
}
