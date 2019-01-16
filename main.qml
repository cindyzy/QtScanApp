import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import ActionController 1.0
Window {
    id: _window
    visible: true

    title: qsTr("秉信")
    width: 800
    height: 1200


    property real dp: 3
    Rectangle {
        id:mainpage
        anchors.fill: parent

        Login {
            id :login
             visible: true
        }

        Index {
            id:index
            visible: false
        }
        function show(page){
            if(page==0)
            {
                login.visible=true
                index.visible=false
            }else if(page==1)
            {
                login.visible=false
                index.visible=true
            }
        }
    }
    ActionController{
        id: _action

//        onEpcArrived: {
//            console.info("epc:",epc)
//        }

        onToastMessage: {
            _toast.show(msg)
        }
//        onShowResultMessage:{
//            _resultPopup.show()
//        }
//        onGetConnectState:{
//             _devText.text=(deviceControl.isOpen? "设备已连接:\n" : "设备未连接" ) + deviceControl.deviceInfo+"\n网络状态：\n"+(netstate?"  在线":"  离线")

////             console.log("list[ " +0 + " ] objectName = " + list[0].objectName)
//        }
    }

    Popup{
        id: _toast

        z: 1000

        x: (parent.width - width)/2
        y: parent.height * 0.8
        width: parent.width * 0.8
        height:100

        background: null

        enter: Transition {
          NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
        }

        exit: Transition {
              NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
          }

        //visible: false

//        anchors{
//            horizontalCenter: parent.horizontalCenter
//            bottom: parent.bottom
//            bottomMargin: parent.height * 0.2
//        }

        Item{
            anchors.fill: parent
            Rectangle{
                anchors.fill: parent
                radius: 6
                color: "#1C1C1C"
                opacity: 0.6
            }

            Text{
                id: _toastText
                anchors.centerIn: parent
                width: parent.width* 0.8
                height: contentHeight
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }

            Timer{
                id: _timer

                interval: 1500
                onTriggered: {_toast.close()}
            }
        }

        //property alias text: _toastText.text

        function show(text){
            _toastText.text = text
            _toast.open()
            _timer.restart()

        }
    }

   }
