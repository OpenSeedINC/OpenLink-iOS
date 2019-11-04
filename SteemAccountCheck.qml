import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12 as Sql
import "OpenSeed.js" as OpenSeed
import "main.js" as Scripts

Page {
    id:idcheck
    title: "Steem Account Check"
    width:parent.width
    height:parent.height
    property string accountname: ""
    property string name:""
    property string discript:""
    property string pimg: ""
    property var inuse: 0

    onAccountnameChanged: {
        var info = OpenSeed.get_steem_profile(accountname)
        var parsed = JSON.parse(info)
        pimg = ""
        name = ""
        discript = ""
        inuse = 0
        if (parsed["profile"] !== undefined) {
             name = accountname
             if (parsed["profile"]["name"]) {
                 name = parsed["profile"]["name"]
             } else {
                 name = parsed["account"]
             }
             pimg = parsed["profile"]["profile_image"]
             discript = parsed["profile"]["about"]
          }
        OpenSeed.check_Steem(accountname)
    }

    onInuseChanged: {
        if(inuse == 1)  {
            used.text = "In Use"
        }else{
            used.text = ""
        }
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
            onClicked: swipeView.setCurrentIndex(2)
        }
    }

    Column {
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.1
        width:parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20

    CirclePic {
        id:img
        fixpic:pimg
        width:parent.width * 0.5
        height:parent.width * 0.5
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: used
            anchors.bottom:parent.bottom
            anchors.right: parent.right

        }
    }

    Text {
        id:thename
        text:name
        font.bold: true
        font.pixelSize: 18
        width:parent.width * 0.85
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
    }
    Text {
        id:discription
        text:discript
        width:parent.width * 0.85
        wrapMode: Text.WordWrap
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
    }

    Button {
        id:confirm
        text:"Confirm"
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.86
        height:40
        enabled: if(inuse == 1) {false} else {true}
        contentItem: Text {
            text: parent.text
            font: parent.font
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
        onClicked: {
           idcheck.visible = false
           swipeView.setCurrentIndex(4)
           swipeView.currentItem.accountname = accountname
        }
    }

    Button {
        id:cancel
        text:"Cancel"
        width:parent.width * 0.86
        height:40
        anchors.horizontalCenter: parent.horizontalCenter
        contentItem: Text {
            text: parent.text
            font: parent.font
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

        onClicked: {
            swipeView.setCurrentIndex(0)
        }
    }


    }
}
