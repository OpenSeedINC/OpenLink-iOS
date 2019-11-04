import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.12 as Sql
import "OpenSeed.js" as OpenSeed
import "main.js" as Scripts


Page {
    title:"OpenSeed Login"
    height:parent.height
    width:parent.width
    clip:true
    Image {
        source:"qrc:/img/bg-login.png"
        anchors.bottom:parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        anchors.bottomMargin: height * -0.5
    }

    Image {
        source:"qrc:/img/left-arrow.svg"
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 10
        height:32
        width:32
        MouseArea {
            anchors.fill: parent
            onClicked: swipeView.setCurrentIndex(0)
        }
    }

    Text {
        id: thetitle
        text: "Welcome Back!"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.15
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 48
        color:"#50aff5"
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.35
        height:contentHeight
        width:parent.width * 0.85
        spacing: 20
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Login using your OpenSeed Account"
            font.pixelSize: 10
        }
        TextField {
            id:username
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.9
            height:40
            placeholderText: "username"
            font.capitalization: Font.AllLowercase
            background: Rectangle {
                anchors.fill: parent
                anchors.leftMargin:-parent.width * 0.05
                anchors.rightMargin: -parent.width * 0.05
                opacity: 0.1
                radius: height / 2
                color:"grey"
            }
        }

        TextField {
            id:passphrase
            width:parent.width * 0.9
            height:40
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "PassPhrase"
            echoMode: TextInput.Password
            background: Rectangle {
                anchors.fill: parent
                anchors.leftMargin:-parent.width * 0.05
                anchors.rightMargin: -parent.width * 0.05

                opacity: 0.1
                radius: height / 2
                color:"grey"
            }
        }

        Item {
            width:parent.width
            height:window.height * 0.05
        }

        Button {
            id: button
            width:parent.width
            height:passphrase.height
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Login"
            onClicked: {
                OpenSeed.oseed_auth(username.text.toLowerCase(),passphrase.text)
            }
            contentItem: Text {
                text: button.text
                font: button.font
                opacity: enabled ? 1.0 : 0.3
                color:"white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                opacity: enabled ? 1 : 0.3
                radius: height / 2
                color:"#50aff5"
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
