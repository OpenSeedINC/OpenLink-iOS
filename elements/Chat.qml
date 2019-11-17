import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import "../"
import "../OpenSeed.js" as OpenSeed
import "../main.js" as Scripts


Page {
    id:chatWindow
    title:"Chat"
    property string chatroom: ""
    property string user: ""

    property string aimage: ""
    property string aname: ""
    property string abanner: ""
    property string aemail: ""
    property string aphone: ""
    property string aabout: ""
    property string aprofession: ""
    property string acompany: ""
    property var askills
    property var ainterests

    property int last: 0
    property int offset: 1
    property string ekey: ""


    Keys.onHangupPressed: {
        Qt.inputMethod.hide()
    }

    state:"hide"
    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: chatWindow
                x:-(parent.width + 10)
            }
        },

        State {
            name: "show"
            PropertyChanges {
                target: chatWindow
                x:0
            }
        }
    ]

    transitions: [
        Transition {
            from: "hide"
            to: "show"
            reversible: true

            NumberAnimation {
                target: chatWindow
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    ]

    Timer {
        id:update_chat
        interval: 500
        running:false
        repeat:true
        onTriggered: {
            OpenSeed.updates(username,user,"chat",last)
            interval = 1000 * offset
        }

    }

    onUserChanged: {
        last = 0
        chatList.currentIndex = 0
        chatlog.clear()
        OpenSeed.profile(user)
        Scripts.load_chat(user)
        ekey = OpenSeed.load_key(username,user)
        if(ekey == "") {
             print("No key Found, Checking")
             OpenSeed.check_chat(username,user)
        }
    }

    onEkeyChanged: {
        if(ekey != "") {
            update_chat.start()
        } else {
            print("No key Found, Checking")
            OpenSeed.check_chat(username,user)
        }
    }

    onStateChanged: {
        if (state == "show") {
            chatList.currentIndex = 0
        }
    }

    onAimageChanged: {
        chatroom_pic.visible = true
    }

    Image {
        source: "qrc:/img/bg-login.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.1
        visible: false
    }

    ListView {
        id:chatList
        width: parent.width
        anchors.top:title_bar.bottom
        anchors.bottom:chat_entry.top
        verticalLayoutDirection:ListView.BottomToTop
        currentIndex: 0

        highlightFollowsCurrentItem: true
        add: Transition {
            NumberAnimation { properties: "x,y"; duration: 200 }
        }
        clip:true
        spacing: 20
        delegate: ChatBox {

        }

        model: ListModel {
            id: chatlog

        }

    }


    Item {
        id:title_bar
        width:parent.width
        height:parent.height  * 0.08
        //anchors.top:parent.top
        y:Qt.inputMethod.visible ? parent.height * 0.27:0
        x:0

        Rectangle {
            id:tbg
            anchors.fill: parent
            visible: false
        }

        DropShadow {
            source:tbg
            anchors.fill: tbg
            radius: 5
        }

        Image {
            source:"qrc:/img/left-arrow.svg"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:parent.left
            anchors.margins: 10
            height:parent.height * 0.6
            width:parent.height * 0.6
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    chatWindow.state = "hide"
                    Qt.inputMethod.hide()
                }

            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height:parent.height
            spacing: 5

            CirclePic {
                id:chatroom_pic
                anchors.verticalCenter: parent.verticalCenter
                height:parent.height * 0.6
                width:parent.height * 0.6
                fixpic: aimage
                visible: false
            }

        Text {
            id: title
            anchors.verticalCenter: parent.verticalCenter
            font.bold:true
            font.pixelSize: parent.height * 0.4
            text: aname
        }

        }

    }


    Item {
        id:chat_entry
        width:parent.width
        height:parent.height * 0.03 + entry.height
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 20

        Rectangle {
            id:bg
            anchors.fill: parent
            visible: false
        }

        DropShadow {
            source:bg
            anchors.fill: bg
            radius: 5
            verticalOffset: -3
            color: "#d5a0a0a0"

        }

        TextField {
            id:entry
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.9
            wrapMode: Text.WordWrap
            placeholderText:"Say Something"
            background: Rectangle {
                anchors.fill: parent
                opacity: 0.8
                radius: height / 2
                color:"white"
                border.width: 0
                border.color: "darkgrey"
            }
            onFocusChanged: {
                if (focus == true) {
                    update_chat.interval = 400
                }
            }



            Keys.onReturnPressed: { 
                    OpenSeed.send_chat(username,user,entry.displayText)
                         entry.text = ""
                         Qt.inputMethod.hide()
                    update_chat.interval = 400

                }
            }
        }
    }

