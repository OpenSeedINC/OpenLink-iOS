import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import "../"
import "../OpenSeed.js" as OpenSeed
import "../main.js" as Scripts

Item {
    property string account1: a1
    property string account2: a2
    property string account1Img: ""
    property string account2Img: ""

    property string aname: ""
    property string aemail: ""
    property string aphone: ""
    property string acompany: ""
    property string aprofession: ""
    property string aimage: ""
    property string aabout: ""
    property string abanner: ""

    property var askills
    property var ainterests

            width: parent.width
            height: conversecontent.height * 1.8
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true

            onAccount1Changed: {
                if (account1 != username) {
                    OpenSeed.profile(account1)
                    account1Img = aimage
                } else {
                   account1Img = window.profile_Image
                }
            }

            onAccount2Changed: {
                if (account2 != username) {
                    OpenSeed.profile(account2)
                    account2Img = aimage
                } else {
                   account2Img = window.profile_Image
                }
            }

            onAimageChanged: {
                if (account1 != username) {
                    account1Img = aimage
                } else {
                    account2Img = aimage
                }
            }

            Rectangle {

                width: parent.width
                height: parent.height
                color: index % 2 ? "white" : "#fafafa"

               /* Rectangle {
                    anchors.bottom:parent.bottom
                    width:parent.width
                    height:1
                    color:"grey"
                    opacity: 0.5
                } */
            }
            Column {
                id: conversecontent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:60
                Row {
                    width: parent.width
                    spacing: 10
                    height:parent.height
                    Item {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.height
                        height: parent.height * 0.8
                        clip:true

                        CirclePic {
                            width:parent.height * 0.9
                            height:parent.height * 0.9
                            fixpic: account1Img
                        }
                        CirclePic {
                            x:parent.height * 0.25
                            width:parent.height * 0.9
                            height:parent.height * 0.9
                            fixpic: account2Img
                        }
                    }

                    Column {
                        width: parent.width * 0.70
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: speaker
                            width: parent.width * 0.98
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignLeft
                            color:"#50aff5"
                            font.bold: true
                            font.pixelSize: 20
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.98
                            height: 1
                            color: "grey"
                        }

                        Text {
                            text: message
                            font.pixelSize: 12
                            width: parent.width * 0.98
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.LeftRight
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {

                        print("Opening chat")
                        chat.visible = true
                        chat.state = "show"
                        chat.user = accountname

                }
            }
        }
