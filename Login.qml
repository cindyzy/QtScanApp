import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4 as QC14
import QtQuick.Controls.Styles 1.4
import "js/base.js" as Variables
import "controls"

Item {
  id: _userInfoPage
  property color mainGray: "#A0A0A0"
  property color mainText: "#333333"
width: _window.width
height: _window.height
  Image {
      id: image
      x: 132
      y: 32
      width: 517
      height: 353
//      source: "qrc:/images/LOGO.png"
  }
    Rectangle {
//        horizontalCenter: parent.horizontalCenter
        id: _userNameRect
        anchors {
            top: image.bottom
            topMargin: 15 * _window.dp
            horizontalCenter: parent.horizontalCenter
        }

        x: 8
        y: 544
        width: parent.width-100
        height: 30 * _window.dp
        radius: 2
        anchors.horizontalCenterOffset: 0
        border.color: "transparent"
        border.width: 1
        color: "transparent"
        Item {
            id: _userNameLeftIcon
            width: height
            anchors.bottomMargin: -4
            anchors.leftMargin: 6
            anchors.topMargin: 4
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            Image {
                anchors.centerIn: parent
                source: "qrc:/images/user.png"
                width: 16 *_window.dp
                height: 20 *_window.dp
                anchors.verticalCenterOffset: 10

                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.height: height
                sourceSize.width: width
            }
        }
        QC14.TextField {
            id: _userName
            x: 66
            textColor: _userInfoPage.mainText
            anchors {
                right: parent.right
                top: parent.top
                topMargin: 2
                bottom: parent.bottom
                bottomMargin: 2
            }

            width: parent.width - _userNameLeftIcon.width
            onTextChanged: {

            }
            placeholderText:  qsTr("请输入用户名")
text:"zc"
            anchors.rightMargin: -6

            selectByMouse: false
            font.pixelSize: 14 * _window.dp
//            font.family: Variables.font_family_base
            style: TextFieldStyle {
                textColor: _userInfoPage.mainGray
                background: Rectangle {
                    radius: 2
                    color: "transparent"
                }
            }
        }
            }
    Rectangle {

        id: _passwdRect
        x: 8
        y: 518
        width: parent.width-100
        height: 30 * _window.dp
        radius: 2
        anchors.horizontalCenterOffset: 0
        border.color: "transparent"
        border.width: 1
        color: "transparent"

anchors {
    top: _userNameRect.bottom
    topMargin: 15 * _window.dp
    horizontalCenter: parent.horizontalCenter
}
        Item {
            id: _passwdLeftIcon
            width: height
            anchors.bottomMargin: -4
            anchors.leftMargin: 6
            anchors.topMargin: 4
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            Image {
                anchors.centerIn: parent
                source: "qrc:/images/password.png"
                width: 16 * _window.dp
                height: 20 * _window.dp
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.height: height
                sourceSize.width: width

            }
        }
        QC14.TextField {
            id: _passwd
            x: 66
            textColor: _userInfoPage.mainText
            anchors {
                right: parent.right
                top: parent.top
                topMargin: 2
                bottom: parent.bottom
                bottomMargin: 2
            }

            width: parent.width - _passwdLeftIcon.width
            echoMode: TextInput.Password
            onTextChanged: {

            }
            placeholderText:  qsTr("请输入密码")
text:"zc"
            anchors.rightMargin: -6

            selectByMouse: false
            font.pixelSize: 14 * _window.dp
//            font.family: Variables.font_family_base
            style: TextFieldStyle {
                textColor: _userInfoPage.mainGray
                background: Rectangle {
                    radius: 2
                    color: "transparent"
                }
            }

//            anchors.leftMargin: 17

        }

    }
    ButtonDefault {
        id: _loginButton

        y: 720
        visible: true
        enabled: _userName.editText != "" && _passwd.text != ""
        width: 150 * _window.dp
        height: 28 * _window.dp
        class_name: "assertive"
        fontSize: 16 * _window.dp
        text: "登 录"
        anchors.horizontalCenterOffset: 0

        z: 3
        anchors {
            top: _passwdRect.bottom
            topMargin: 15 * _window.dp
            horizontalCenter: parent.horizontalCenter
        }
       onClicked: mainpage.show(1)
//       mainpage.show(1)
        style: ButtonStyle {
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                color: "white"
                border.width: control.hovered ? 2 : 1
                border.color: "#4593e1"
                radius: 4
                opacity: control.enabled || control.hovered ? 1 : 0.5
            }
            label: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#4593e1"
                text: control.text
                font.pixelSize: 12 * _window.dp
                font.family: Variables.font_family_base
                renderType: Text.NativeRendering
                opacity: control.enabled || control.hovered ? 1 : 0.5
            }
        }
        MouseArea {
            id: _loginButtonMouseArea
            anchors.rightMargin: 1
            anchors.bottomMargin: -745
            anchors.leftMargin: -1
            anchors.topMargin: 745
            anchors.fill: parent
            onPressed: mouse.accepted = false
            cursorShape: Qt.PointingHandCursor
        }
    }






}
