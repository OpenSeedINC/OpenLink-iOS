import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12 as Sql
import "OpenSeed.js" as OpenSeed
import "main.js" as Scripts


Page {
    id:loginSteem
    title:"SteemLogin"
    height:parent.height
    width:parent.width
    clip:true

    Image {
        source:"qrc:/img/left-arrow.svg"
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 10
        height:32
        width:32
        MouseArea {
            anchors.fill: parent
            onClicked: {
                swipeView.setCurrentIndex(0)
            }
        }
    }

    Text {
        id: thetitle
        text: "Hello!"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.15
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 56
        color:"#50aff5"
    }

    Column {
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.75
    Text {
        text:"Enter Steem Account -or- Create a New Account*"
        font.pixelSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        width:parent.width
        color:"#50aff5"
    }

    TextField {
        id:steemAccount
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.9
        height: 45
        verticalAlignment: Text.AlignVCenter
        placeholderText: "openseed"
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

    Button {
        id:steemlogin
        anchors.horizontalCenter: parent.horizontalCenter
        text:"Look up"
        width:parent.width * 0.5
        height:steemAccount.height

        contentItem: Text {
            text: steemlogin.text
            font: steemlogin.font
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
        onClicked: {if(steemAccount.text != "") {
                           swipeView.incrementCurrentIndex()
                           swipeView.currentItem.accountname = steemAccount.text.toLowerCase()
                    }
                }
    }

    }

    Text {
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 100
        text:"* Steem accounts will be created for active users of OpenLink."
        font.pixelSize: 10
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        width:parent.width
        color:"#50aff5"
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/img/bg-login.png"
        //width:parent.width
        anchors.left:parent.left
        anchors.bottomMargin: -parent.height * 0.6
    }

}
