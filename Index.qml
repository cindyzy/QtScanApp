import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4 as QC14
import QtQuick.Controls.Styles 1.4

import "js/base.js" as Variables
import "controls" as Control
import JQQRCodeReader 1.0

import CalculatorStateMachine 1.0

import QtScxml 5.8
//import "js/jquery.qrcode.min.js" as Code
Item {
    id: _editInfoPage
    width: _window.width
    height: _window.height
    property color mainGray: "#A0A0A0"
    property color mainText: "#333333"

    CalculatorStateMachine {
        property string selectText: "radius"
        id: statemachine
        running: true

        EventConnection {
            events: ["updateDisplay"]
            onOccurred: {
                if(statemachine.selectText=="radius")
                {
                    _radius.text = event.data.display
                }else
                {
                    _barcode.text = event.data.display
                }
            }

        }
    }


    Rectangle {

        id: _scanRect

        width: parent.width
        height: 500
        radius: 2
        anchors.horizontalCenterOffset: 0
        border.color: "transparent"
        border.width: 1
        color: "transparent"

        anchors {
            top: parent.top

            horizontalCenter: parent.horizontalCenter
        }

        JQQRCodeReader {
            id: qrCodeReader
            width: parent.width
            height: parent.height-30
            anchors {
                top: parent.top

                horizontalCenter: parent.horizontalCenter

            }
            onTagFound: {
                _barcode.text = tag
                _radius.forceActiveFocus()

            }
            Item {
                id: _keyboard
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                visible:  !qrCodeReader.active
                property real implicitMargin: {
                    var ret = 0;
                    for (var i = 0; i < visibleChildren.length; ++i) {
                        var child = visibleChildren[i];
                        ret += (child.implicitMargin || 0);
                    }
                    return ret / visibleChildren.length;
                }

                Repeater {
                    id: operations
                    model: ["÷", "×", "+", "-"]
                    Control.Button {
                        y: 0
                        x: index * width
                        width: parent.width / 4
                        height: parent.height / 5
                        color: pressed ? "#5caa15" : "#80c342"
                        text: modelData
                        fontHeight: 0.4
                        onClicked: statemachine.submitEvent(eventName)
                        property string eventName: {
                            switch (text) {
                            case "÷": return "OPER.DIV"
                            case "×": return "OPER.STAR"
                            case "+": return "OPER.PLUS"
                            case "-": return "OPER.MINUS"
                            }
                        }
                    }
                }

                Repeater {
                    id: digits
                    model: ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "C"]
                    Control.Button {
                        x: (index % 3) * width
                        y: Math.floor(index / 3 + 1) * height
                        width: parent.width / 4
                        height: parent.height / 5
                        color: pressed ? "#d6d6d6" : "#eeeeee"
                        text: modelData
                        onClicked: statemachine.submitEvent(eventName)
                        property string eventName: {
                            switch (text) {
                            case ".": return "POINT"
                            case "C": return "C"
                            default: return "DIGIT." + text
                            }
                        }
                    }
                }

                Control.Button {
                    id: resultButton
                    x: 3 * width
                    y: parent.height / 5
                    textHeight: y - 2
                    fontHeight: 0.4
                    width: parent.width / 4
                    height: y
                    color: pressed ? "#e0b91c" : "#face20"
                    text: "="
                    onClicked: statemachine.submitEvent("EQUALS")
                }
                Control.Button {
                    id: backspaceButton
                    x: 3 * width
                    y: parent.height / 5*2
                    textHeight: resultButton.textHeight
                    fontHeight: 0.4
                    width: parent.width / 4
                    height: resultButton.y
                    color: pressed ? "#e0b91c" : "#face20"
                    text: "<="
                    onClicked:{

                        statemachine.submitEvent("BACK")
                        //                    statemachine.submitEvent("DIGIT.10")
                        //                    statemachine.submitEvent("EQUALS")
                    }
                }
                Control.Button {
                    id: rescanButton
                    x: 3 * width
                    y: parent.height / 5*3
                    textHeight: resultButton.textHeight*2
                    fontHeight: 0.4
                    width: parent.width / 4

                    height: resultButton.y *2
                    color: pressed ? "#e0b91c" : "#face20"

                    text: "扫 码"
                    onClicked: qrCodeReader.active=true
                }
            }

            //        TextArea{
            //            visible: !qrCodeReader.active
            ////            width: parent.width
            ////            height: parent.height
            //                anchors.fill: parent

            //                anchors{
            //                    horizontalCenter: parent.horizontalCenter
            //                    verticalCenter: parent.verticalCenter

            //                }
            //font.pixelSize: 12 * _window.dp
            //verticalAlignment: "AlignVCenter"
            //horizontalAlignment: "AlignHCenter"
            //            text:"点击重新扫码"
            //        }

            //        MouseArea {
            //            anchors.fill: parent
            //onClicked:
            //{
            //    if(!qrCodeReader.active)
            //    {
            //            qrCodeReader.active=true
            //    }


            //}

            //        }

        }
        //    ButtonDefault {
        //        id: _scanButton

        //        visible: true

        //        width: 50 * _window.dp
        //        height: 20 * _window.dp
        //        class_name: "assertive"
        //        fontSize: 13 * _window.dp
        //        text: "扫 码"
        //        anchors.horizontalCenterOffset: 0

        //        z: 3
        //        anchors {
        //            top:qrCodeReader.bottom
        //            topMargin: 10
        //           right: parent.right
        //           rightMargin: 10
        ////            horizontalCenter: parent.horizontalCenter
        //        }
        //       onClicked:qrCodeReader.active = true;
        //        style: ButtonStyle {
        //            background: Rectangle {
        //                implicitWidth: 100
        //                implicitHeight: 25
        //                color: "white"
        //                border.width: control.hovered ? 2 : 1
        //                border.color: "#4593e1"
        //                radius: 4
        //                opacity: control.enabled || control.hovered ? 1 : 0.5
        //            }
        //            label: Text {
        //                horizontalAlignment: Text.AlignHCenter
        //                verticalAlignment: Text.AlignVCenter
        //                color: "#4593e1"
        //                text: control.text
        //                font.pixelSize: 12 * _window.dp
        //                font.family: Variables.font_family_base
        //                renderType: Text.NativeRendering
        //                opacity: control.enabled || control.hovered ? 1 : 0.5
        //            }
        //        }
        //        MouseArea {
        //            id: _scanButtonMouseArea
        //            anchors.rightMargin: 1
        //            anchors.bottomMargin: -745
        //            anchors.leftMargin: -1
        //            anchors.topMargin: 745
        //            anchors.fill: parent
        //            onPressed: mouse.accepted = false
        //            cursorShape: Qt.PointingHandCursor
        //        }
        //    }




    }
    Rectangle {

        id: _barcodeRect
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
            top: _scanRect.bottom
            topMargin: 15 * _window.dp
            horizontalCenter: parent.horizontalCenter
        }
        Item {
            id: _barcodeLeftIcon
            width: height
            anchors.bottomMargin: 1
            anchors.leftMargin: 27
            anchors.topMargin: 1
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            Image {
                anchors.centerIn: parent
                source: "qrc:/images/edit.png"
                width: 16 * _window.dp
                height: 20 * _window.dp
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.height: height
                sourceSize.width: width
            }
        }
        //        QC14.Label{
        //            id: _barcode
        //            anchors {
        //                left: _barcodeLeftIcon.right
        //                top: parent.top
        //                topMargin: 8
        //                bottom: parent.bottom
        //                bottomMargin: -4
        //            }
        //            anchors.leftMargin: 17
        //            width: parent.width - _barcodeLeftIcon.width
        //            focus: true
        //        }

        Control.Button {
            id: _barcode
            //            textColor: _editInfoPage.mainText
            anchors {
                left: _barcodeLeftIcon.right
                top: parent.top
                topMargin: 8
                bottom: parent.bottom
                bottomMargin: -4
                leftMargin: 17
            }

            //             placeholderText:  qsTr("请输入条码")


            width: parent.width - _barcodeLeftIcon.width
            //    inputMethodHints: Qt.ImhDigitsOnly

            //    onActiveFocusChanged: Qt.inputMethod.hide()



            //                    onSelectionEndChanged: Qt.inputMethod.hide()
            //                    onSelectionStartChanged: Qt.inputMethod.hide()

            //onCursorPositionChanged: Qt.inputMethod.hide()
            //            selectByMouse: false

            text: "0"
            color: pressed ? "#d6d6d6" : "white"


            fontHeight: 0.4

            onClicked:

            {
 statemachine.selectText="barcode"

                    statemachine.submitEvent("THISVALUE."+text)


                }



        }

    }
    Rectangle {

        id: _radiusRect
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
            top: _barcodeRect.bottom
            topMargin: 15 * _window.dp
            horizontalCenter: parent.horizontalCenter
        }
        Item {
            id: _radiusLeftIcon
            width: height
            anchors.bottomMargin: 1
            anchors.leftMargin: 27
            anchors.topMargin: 1
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            Image {
                anchors.centerIn: parent
                source: "qrc:/images/edit.png"
                width: 16 * _window.dp
                height: 20 * _window.dp
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.height: height
                sourceSize.width: width
            }
        }
        Control.Button {
            id: _radius
            anchors {
                left: _radiusLeftIcon.right
                top: parent.top
                topMargin: 8
                bottom: parent.bottom
                bottomMargin: -4

                leftMargin: 17
            }

            width: parent.width - _radiusLeftIcon.width
            text: "0"
            color: pressed ? "#d6d6d6" : "white"



            fontHeight: 0.4


            onClicked:{


                    statemachine.selectText="radius"
                    statemachine.submitEvent("THISVALUE."+text)



            }


        }


    }


    Control.ButtonDefault {
        id: _updateButton

        y: 720
        visible: true
        enabled: _barcode.editText != "" && _radius.text != ""
        width: 150 * _window.dp
        height: 28 * _window.dp
        class_name: "assertive"
        fontSize: 16 * _window.dp
        text: "修 改"
        anchors.horizontalCenterOffset: 0

        z: 3
        anchors {
            top: _radiusRect.bottom
            topMargin: 15 * _window.dp
            horizontalCenter: parent.horizontalCenter
        }
        //       onClicked: mainpage.show(1)
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
            id: _updateButtonMouseArea
            anchors.rightMargin: 1
            anchors.bottomMargin: -745
            anchors.leftMargin: -1
            anchors.topMargin: 745
            anchors.fill: parent
            onPressed: mouse.accepted = false
            cursorShape: Qt.PointingHandCursor
        }
    }
    Control.ButtonDefault {
        id: _logoutButton

        y: 720
        visible: true

        width: 150 * _window.dp
        height: 28 * _window.dp
        class_name: "assertive"
        fontSize: 16 * _window.dp
        text: "登 出"
        anchors.horizontalCenterOffset: 0

        z: 3
        anchors {
            top: _updateButton.bottom
            topMargin: 15 * _window.dp
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            qrCodeReader.active=false
            mainpage.show(0)
        }
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
            id: _logoutButtonMouseArea
            anchors.rightMargin: 1
            anchors.bottomMargin: -745
            anchors.leftMargin: -1
            anchors.topMargin: 745
            anchors.fill: parent
            onPressed: mouse.accepted = false
            cursorShape: Qt.PointingHandCursor
        }
    }


    Component.onCompleted:  {
        if(visible)
        {
            qrCodeReader.active = true
        }


    }







}
