import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Page {
    id:page
    title:"Secure Account"
    width:parent.width
    height: parent.height
    property string accountname: ""

    Image {
        source:"qrc:/img/left-arrow.svg"
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 10
        height:32
        width:32
        MouseArea {
            anchors.fill: parent
            onClicked: swipeView.setCurrentIndex(3)
        }
    }

    Text {
        text: "Secure Account"
        width:parent.width * 0.8
        wrapMode: Text.WordWrap
        font.pixelSize: 48
        horizontalAlignment: Text.AlignHCenter
        color:"#50aff5"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: window.height * 0.2
    }
    TextField {
        id:secure
        anchors.centerIn: parent
        width:parent.width * 0.8
        height:40
        echoMode:TextInput.Password
        placeholderText: "passphrase"
        background: Rectangle {
            anchors.fill: parent
            anchors.leftMargin:-parent.width * 0.05
            anchors.rightMargin: -parent.width * 0.05
            anchors.bottomMargin: parent.height * 0.05
            opacity: 0.1
            radius: height / 2
            color:"grey"
        }
    }

    Button {
        id: button
        width:parent.width * 0.9
        height:secure.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.3
        text: "Set Passphrase"
        onClicked: {
            swipeView.setCurrentIndex(5)
            swipeView.currentItem.username = accountname
            swipeView.currentItem.passphrase = secure.text

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
