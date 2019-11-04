import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.12

import "OpenSeed.js" as OpenSeed

Item {
    height: window.height / 7
    width: parent.width
    property string profileName: name
    property string profileImg: img
    property bool loaded: false
    property var status: 0
    property int chat_status: 0
    property string last_seen: ""
    property int linked: 0
    //property int index: 0
    opacity: if (openseed == false) {
                 0.6
             } else {
                 1.0
             }
    clip: true

    Timer {
        id: update_check
        interval: 500
        running: true
        repeat: false
        onTriggered: {
            OpenSeed.updates(window.userid, accountname,
                             "request_status", username)
            OpenSeed.updates(window.userid, accountname, "status", 0)
        }
    }

    onStatusChanged: {
        var stat = JSON.parse(status)
        last_seen = stat["date"]
        switch (stat["data"]["chat"]) {
        case "Online":
            chat_status = 1
            break
        case "Offline":
            chat_status = 0
            break
        case "Busy":
            chat_status = 2
            break
        case "away":
            chat_status = 3
            break
        default:
            chat_status - 0
            break
        }
        update_check.interval = 1000 * 2
        update_check.repeat = true
    }

    Rectangle {
        anchors.fill: parent
        color: index % 2 ? "white" : "#fafafa"
        //color:white
        //opacity: 0.1
        //border.width: 1
    }

    Row {
        id: row1
        anchors.fill: parent
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: -25
        anchors.leftMargin: 25

        spacing: width / 40


        /* Image {
            width: parent.height
            height: parent.height
            source: profileImg
        } */
        CirclePic {
            fixpic: profileImg
            width: parent.height * 0.6
            height: parent.height * 0.6
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            height: parent.height * 0.6
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - parent.height - window.width * 0.15
            spacing: 1
            Text {
                text: profileName
                font.bold: true
                color: "#50aff5"
            }
            Item {
                height: 4
                width: parent.width
            }
            Text {
                text: about
                font.bold: false
                wrapMode: Text.WordWrap
                width: parent.width * 0.9
                elide: Text.ElideRight
                clip: true
                opacity: 0.5
            }
            Text {
                text: company
                font.bold: false
                wrapMode: Text.WordWrap
                width: parent.width * 0.9
                elide: Text.ElideRight
                clip: true
                opacity: 0.5
            }
        }

        Image {
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height * 0.3
            width: parent.height * 0.3
            source: "qrc:/img/icon-chat.svg"

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: {
                    switch (chat_status) {
                    case 0:
                        "lightgrey"
                        break
                    case 1:
                        "green"
                        break
                    case 2:
                        "red"
                        break
                    case 3:
                        "yellow"
                        break
                    default:
                        "lightgrey"
                        break
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (linked == 0) {
                        request.aimage = profileImg
                        request.accountname = accountname
                        request.aname = name
                        request.state = "show"
                    } else if (linked == 1) {
                        notify.themessage ="Waiting on Response."
                        notify.visible = true
                    } else if (linked == 2) {
                        print("Opening chat")
                        chat.visible = true
                        chat.state = "show"
                        chat.user = accountname
                       // stackView.push("elements/ConversationList.qml")
                       // stackView.currentItem.update_chats = true
                    }
                }
            }
        }
    }
    Text {
        opacity: 0.5
        text: if (openseed == false) {
                  "Not Connected to OpenSeed"
              } else {
                  last_seen
              }
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05
        anchors.right: parent.right
        anchors.rightMargin: 5
        font.pixelSize: 8
    }

    MouseArea {
        width: parent.width * 0.8
        height: parent.height
        onClicked: {
            link_profile.state = "show"
            link_profile.aname = name
            link_profile.aimage = profileImg
            link_profile.accountname = accountname
        }
    }
}
