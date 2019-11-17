import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtPositioning 5.12

import QtQuick.LocalStorage 2.12 as Sql
import "OpenSeed.js" as OpenSeed
import "main.js" as Scripts
import "elements"

import IO 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 700
    title: "OpenLink"
    property int contacts: 0
    property var connections: []
    property var collected: []
    property bool connections_done: false

    property string devId: ""
    property string devPub:""
    property string appId: ""

    property string userid
    property string username
    property var db: Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0",
                                                       "Local UserInfo", 1)

    property bool ready: false

    //Profile //
    property string profile_Name: ""
    property string profile_Image: ""
    property string profile_Email: ""
    property string profile_Phone: ""
    property string profile_Profession: ""
    property string profile_Company: ""
    property string profile_steemName: ""
    property string profile_Banner: ""
    property string profile_About: ""
    property var profile_Skills
    property var profile_Interests

    property string chat_status: "Online"


    //GPS//
    property bool location_service:true
    property double lat:0.000
    property double log:0.000
    property string currentcords: "0.000:0.000"
    property int offset:10


    //Conversations
    property int rooms: 0
    property var converstationArray: []


    property int closeit: 0

    onClosing: {

       /* if (swapopt.state === "Active") {
            swapopt.state = "InActive"
            close.accepted = false
        } else if (achievePage.state === "Active") {
            achievePage.state = "InActive"
            close.accepted = false
        } else if (settingsPage.state === "Active") {
            settingsPage.state = "InActive"
            if (themenu.state !== "Active") {
                topBar.state = "person"
            } else {
                topBar.state = "standard"
            }

            close.accepted = false
        } else if (eventEdit.state === "Active") {
            eventEdit.state = "InActive"
            topBar.state = "events"
            close.accepted = false
        } else if (eventsPage.state === "Active") {
            eventsPage.state = "InActive"
            topBar.state = "standard"
            close.accepted = false
        } else if (notes.state === "Active") {

            if (notes.editing === true) {
                notes.editing = false
                close.accepted = false
            } else {
                notes.state = "InActive"
                topBar.state = "person"
                topBar.visible = true
                close.accepted = false
            }
        } else if (mainScreen.state === "Active") {
            mainScreen.state = "InActive"
            topBar.state = "standard"
            close.accepted = false
        } else if (messageContactsPage.state === "Active") {
            messageContactsPage.state = "InActive"
            topBar.state = "chat"
            close.accepted = false
        } else if (messagePage.state === "Active") {
            if (messagePage.showroom === true) {
                messagePage.showroom = false
            } else {
                messagePage.state = "InActive"
                topBar.state = "standard"
            }
            close.accepted = false
        } else if (requestPage.state === "Active") {
            requestPage.state = "InActive"
            topBar.state = "standard"
            close.accepted = false
        } else if (eventContactsPage.state === "Active") {
            eventContactsPage.state = "InActive"
            topBar.state = "events"
            close.accepted = false
        } else if (themenu.state === "Active") {
            themenu.state = "InActive"
            close.accepted = false
        } else */

        if (closeit == 1) {
            close.accepted = true
        } else {
            closeit = closeit + 1
            close.accepted = false
            notify.visible = true
            notify.themessage = "Tap again to exit"
            exitTimer.start()
        }
    }

    Timer {
        id:exitTimer
        running:false
        repeat:false
        interval: 3000
        onTriggered: {
            closeit = 0
        }
    }




    Timer {
        id: startup
        running: true
        interval: 200
        repeat: false
        onTriggered: {
            Scripts.create_db()
            Scripts.load_user()
        }
    }


    onReadyChanged: {
        OpenSeed.user_profile(username)
        OpenSeed.updates(userid, username, "set_status",
                         '{"location":"0:1","chat":"' + chat_status + '"}')
        foot.state = "show"
        stackView.push("HomeForm.qml")
        startup.repeat = false
        updater.running = true
    }

    Timer {
        id: updater
        running: false
        interval: 1000
        repeat: true
        onTriggered: {
            //print("Checking for updates")
            OpenSeed.updates(userid, username, "requests", 0)
            OpenSeed.updates(userid, username, "set_status",
                             '{"location":"'+currentcords+'","chat":"' + chat_status + '"}')
            OpenSeed.get_around(currentcords)
            if (interval != 10000) {
            interval = interval * offset
            }
            OpenSeed.retrieve_conversations(username)
            OpenSeed.updates()
        }
    }


    Timer {
        id: gpsupdate
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            gpsupdate.interval = offset
            if (userid != "" && profile_Name != "") {
                if (positionSource.supportedPositioningMethods
                        === PositionSource.NoPositioningMethods) {
                    //positionSource.nmeaSource = "nmealog.txt"
                    /*sourceText.text = "(filesource): " + printableMethod(
                                positionSource.supportedPositioningMethods) */
                }

                positionSource.update()
            }

            gpsupdate.interval = 20000
        }
    }


    PositionSource {
        id: positionSource
        onPositionChanged: {

            lat = positionSource.position.coordinate.latitude
            log = positionSource.position.coordinate.longitude
            lat = lat.toFixed(3)
            log = log.toFixed(3)
            currentcords = lat + ":" + log

        }
     }


    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        visible: false
        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: "Page 1"
                width: parent.width
                onClicked: {

                    drawer.close()
                }
            }
            ItemDelegate {
                text: "Page 2"
                width: parent.width
                onClicked: {

                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.qml"
        anchors.fill: parent
        visible: true
        onCurrentItemChanged: {
            if (currentItem.name === "Home") {
                s0.visible = true
            } else {
                s0.visible = false
            }
            if (currentItem.name === "addressBook") {
                s1.visible = true
            } else {
                s1.visible = false
            }
            if (currentItem.name === "Chat") {
                s2.visible = true
            } else {
                s2.visible = false
            }
            if (currentItem.name === "Profile") {
                s3.visible = true
            } else {
                s3.visible = false
            }
        }
    }

    Rectangle {
        id: foot

        height: window.height / 8

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: -20
        z: 1
        color: "black"
        radius: 10

        state: "hide"

        states: [
            State {
                name: "hide"
                PropertyChanges {
                    target: foot
                    anchors.bottomMargin: -window.height / 8
                }
            },
            State {
                name: "show"
                PropertyChanges {
                    target: foot
                    anchors.bottomMargin: -20
                }
            }
        ]

        transitions: [
            Transition {
                from: "hide"
                to: "show"
                reversible: true
                NumberAnimation {
                    target: foot
                    property: "anchors.bottomMargin"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        MouseArea {
            anchors.fill: parent
        }

        Row {
            height: parent.contentHeight
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 50

            Image {
                id: b0
                source: "qrc:/img/icon-home.svg"
                anchors.verticalCenter: parent.verticalCenter
                height: 32
                width: 32

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("HomeForm.qml")
                        chat.state = "hide"
                        link_profile.state = "hide"
                    }
                }

                ColorOverlay {
                    id: s0
                    source: b0
                    anchors.fill: b0
                    color: "#50aff5"
                    visible: false
                }
            }

            Image {
                id: b1
                source: "qrc:/img/icon-contacts-white.svg"
                anchors.verticalCenter: parent.verticalCenter
                height: 32
                width: 32
                antialiasing: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("AddressBook.qml")
                        chat.state = "hide"
                        link_profile.state = "hide"
                        stackView.currentItem.loadcontacts = true
                        stackView.currentItem.display_contacts = true
                    }
                }
                ColorOverlay {
                    id: s1
                    source: b1
                    anchors.fill: b1
                    color: "#50aff5"
                    visible: false
                }
            }

            Image {
                id: b2
                source: "qrc:/img/icon-chat-group.svg"
                anchors.verticalCenter: parent.verticalCenter
                height: 32
                width: 32
                antialiasing: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("elements/ConversationList.qml")
                        stackView.currentItem.update_chats = true
                        chat.state = "hide"
                        link_profile.state = "hide"
                    }
                }

                ColorOverlay {
                    id: s2
                    source: b2
                    anchors.fill: b2
                    color: "#50aff5"
                    visible: false
                }
            }

            Image {
                id: b3
                source: "qrc:/img/icon-cog.svg"
                anchors.verticalCenter: parent.verticalCenter
                height: 32
                width: 32
                antialiasing: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("elements/ProfileEdit.qml")
                        stackView.currentItem.profile_Name = profile_Name
                        stackView.currentItem.profile_Image = profile_Image
                        stackView.currentItem.profile_Email = profile_Email
                        stackView.currentItem.profile_Phone = profile_Phone
                        stackView.currentItem.profile_Profession = profile_Profession
                        stackView.currentItem.profile_Company = profile_Company
                        stackView.currentItem.profile_About = profile_About
                        stackView.currentItem.profile_Banner = profile_Banner
                        stackView.currentItem.profile_Skills = profile_Skills
                        stackView.currentItem.profile_Interests = profile_Interests
                        chat.state = "hide"
                        link_profile.state = "hide"

                    }
                }

                ColorOverlay {
                    id: s3
                    source: b3
                    anchors.fill: b3
                    color: "#50aff5"
                    visible: false
                }
            }
        }
    }

    Rectangle {
        id: mask
        radius: width / 2
        width: parent.width * 0.94
        height: parent.width * 0.94
        visible: false
    }

    Request {
        id: request
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ProfileView {
        id: link_profile
        width: parent.width
        height: parent.height
    }

    Chat {
        id: chat
        state: "hide"
        anchors.top: parent.top
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: foot.height * 0.6
    }

    Notifications {
        id:notify
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.25
        width:parent.width * 0.98
        visible: false
        pos:1

    }

    ListModel {
        id:gps_collected
    }

    ListModel {
         id: conversations
    }
}
