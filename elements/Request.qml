import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12 as Sql
import "../OpenSeed.js" as OpenSeed
import "../main.js" as Scripts
import "../"

Item {
    id:requestWindow
    width:parent.width * 0.98
    height:parent.height * 0.98
    clip:true
    property string accountname: ""
    property string aname: ""
    property string aimage: ""
    property string aemail: ""
    property string aphone: ""
    property string aprofession: ""
    property string acompany: ""
    property string aabout: ""
    property string abanner: ""
    property var ainterests: []
    property var askills: []

    property bool send: true

    property string new_requests:""
    property var therequests: []
    property int requests: 0
    property int sorted: 0

    property string username: window.username

    onAccountnameChanged: {
        OpenSeed.profile(accountname)
    }

    onNew_requestsChanged: {

        therequests = new_requests.split("['")[1].split("']")[0].split("', '")
        requests = therequests.length
    }

    onRequestsChanged: {
        send =false
        var parsed = JSON.parse(therequests[sorted])
        accountname = parsed["from"]
        requestWindow.state = "show"
    }

    onSortedChanged: {
        send = false
        if(sorted < requests) {
            var parsed = JSON.parse(therequests[sorted])
            accountname = parsed["from"]
            requestWindow.state = "show"
        } else {
            requestWindow.state = "hide"
        }
    }

    state:"hide"
    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: requestWindow
                y:parent.height
            }
        },

        State {
            name: "show"
            PropertyChanges {
                target: requestWindow
                y:0
            }
        }
    ]

    transitions: [
        Transition {
            from: "hide"
            to: "show"
            reversible: true

            NumberAnimation {
                target: requestWindow
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    ]

    Rectangle {
        id:topbar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        width:parent.width * 0.98
        height:parent.height * 0.8
        visible: false
        radius: 10

        Image {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.8
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/img/bg-login.png"
            //width:parent.width
            anchors.left:parent.left
            anchors.bottomMargin: -parent.height * 0.6
            opacity: 0.5
        }

    }

    DropShadow {
        source:topbar
        anchors.fill: topbar
        radius: 5
        verticalOffset: -1
    }

    CirclePic {
        id:idPic
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:topbar.top
        anchors.topMargin:-height * 0.25
        fixpic: aimage
        width:128
        height:128

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.bottom
            anchors.topMargin: 10
            text:aname
            color:"#50aff5"
            font.pixelSize: 20
            font.bold: true

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top:parent.bottom
                text: aprofession
                opacity: 0.4
            }
        }

    }
    Column {
        width:topbar.width * 0.8
        height:topbar.height - idPic.height
        anchors.top:idPic.bottom
        anchors.topMargin: idPic.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:if(send == true) {"Forge a link with user?"} else {"Wants to forge a link with you!"}
                wrapMode: Text.WordWrap
                color:"#50aff5"
                font.pixelSize: 24
            }

            Item {
                id:spacer
                width:parent.width
                height:parent.height * 0.1
            }

            Button {
                 id:requestButton
                   anchors.horizontalCenter: parent.horizontalCenter
                    text:if(send == true) {"Send"} else { "Accept" }
                    width:parent.width
                    height:window.height * 0.05
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
                        if(send == true) {
                            OpenSeed.send_request(username,accountname,1)
                            requestWindow.state = "hide"
                        } else {
                            OpenSeed.send_request(accountname,username,2)
                            sorted = sorted + 1

                        }

                    }
              }

            Button {
                 id:cancel
                   anchors.horizontalCenter: parent.horizontalCenter
                    text: if(send == true) {"Cancel"} else {"Reject"}
                    width:parent.width
                    height:window.height * 0.05
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
                        if(send == false) {
                            OpenSeed.send_request(accountname,username,3)
                            sorted = sorted + 1
                        } else {
                        requestWindow.state = "hide"
                        }
                    }
              }
           }


}
