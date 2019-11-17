import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12 as Sql
import "../OpenSeed.js" as OpenSeed
import "../main.js" as Scripts
import "../"

Page {
    id: proEditForm
    property string name: "editform"
    width: parent.width
    height: parent.height

    TabBar {
        id: tabs
        anchors.top: parent.top
        width: parent.width
        height: parent.height * 0.1

        background: Rectangle {
            color: "white"
        }

        TabButton {
            text: "Profile"
            font.pixelSize: 18
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            contentItem: Text {
                text: parent.text
                font: parent.font

                opacity: enabled ? 1.0 : 0.3
                color: "#50aff5"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {

                opacity: enabled ? 1 : 0.3
                color: "white"
            }

            Rectangle {
                visible: if (tabs.currentIndex === 0) {
                             true
                         } else {
                             false
                         }
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.75
                color: "#50aff5"
                //radius:height  /2
                height: 5
            }
        }
        TabButton {
            text: "Settings"
            font.pixelSize: 18
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            contentItem: Text {
                text: parent.text
                font: parent.font
                opacity: enabled ? 1.0 : 0.3
                color: "#50aff5"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                opacity: enabled ? 1 : 0.3
                color: "white"
            }

            Rectangle {
                visible: if (tabs.currentIndex === 1) {
                             true
                         } else {
                             false
                         }
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.75
                color: "#50aff5"
                //radius:height  /2
                height: 5
            }
        }
    }

    SwipeView {
        id: profile
        interactive: false
        currentIndex: tabs.currentIndex
        anchors.top: tabs.bottom
        width: parent.width
        height: parent.height - tabs.height - foot.height / 2

        Page {
            clip: true

            Flickable {
                width: parent.width
                height: parent.height
                contentHeight: profile_column.height + 100

                Column {
                    id: profile_column
                    width: parent.width
                    Page {
                        id: general
                        width: proEditForm.width
                        height: generalColumn.height

                        Column {
                            id: generalColumn
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            spacing: 10

                            Item {
                                width: parent.width
                                height: 5
                            }

                            Text {
                                width: parent.width * 0.9
                                text: "Contact Info"
                                font.pixelSize: 20
                                color: "#50aff5"
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.98
                                height: 1
                                color: "grey"
                                opacity: 0.4
                            }

                            TextField {
                                id: fullname
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                text: profile_Name
                                placeholderText: "Full Name"
                                // horizontalAlignment: Text.AlignHCenter
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: height / 2
                                    color: "grey"
                                }
                            }

                            TextField {
                                id: email
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                text: profile_Email
                                placeholderText: "Email Account"
                                // horizontalAlignment: Text.AlignHCenter
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: height / 2
                                    color: "grey"
                                }
                            }

                            TextField {
                                id: phone
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                text: profile_Phone
                                placeholderText: "Phone #"
                                // horizontalAlignment: Text.AlignHCenter
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: height / 2
                                    color: "grey"
                                }
                            }

                            TextField {
                                id: profession
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                text: profile_Profession
                                placeholderText: "Profession"
                                // horizontalAlignment: Text.AlignHCenter
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: height / 2
                                    color: "grey"
                                }
                            }

                            TextField {
                                id: companyname
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                text: profile_Company
                                placeholderText: "Company"
                                // horizontalAlignment: Text.AlignHCenter
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: height / 2
                                    color: "grey"
                                }
                            }

                            Item {
                                width: parent.width
                                height: 10
                            }
                        }
                    }

                    Page {
                        id: about
                        width: proEditForm.width
                        height: aboutColumn.height

                        Column {
                            id: aboutColumn
                            anchors.centerIn: parent
                            width: parent.width * 0.9
                            spacing: 10
                            Text {
                                width: parent.width * 0.9
                                text: "About"
                                font.pixelSize: 20
                                color: "#50aff5"
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.98
                                height: 1
                                color: "grey"
                                opacity: 0.4
                            }

                            TextArea {
                                id: aboutEntry
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                height: 200
                                text: profile_About
                                wrapMode: Text.WordWrap
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: 20
                                    color: "grey"
                                }
                            }
                            Item {
                                width: parent.width
                                height: 20
                            }
                        }
                    }

                    Page {
                        id: skills
                        width: proEditForm.width
                        height: skillsColumn.height

                        Column {
                            id: skillsColumn
                            anchors.centerIn: parent
                            width: parent.width * 0.9
                            spacing: 10

                            Text {
                                width: parent.width * 0.9
                                text: "Skills"
                                font.pixelSize: 20
                                color: "#50aff5"
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.98
                                height: 1
                                color: "grey"
                                opacity: 0.4
                            }

                            TextField {
                                id: skillsEntry
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                text: profile_Skills.toString()
                                placeholderText: "Writing,Coding,Digital Art,Design"
                                wrapMode: Text.WordWrap
                                // horizontalAlignment: Text.AlignHCenter
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: height / 2
                                    color: "grey"
                                }
                            }

                            Item {
                                width: parent.width
                                height: 20
                            }
                        }
                    }

                    Page {
                        id: interests
                        width: proEditForm.width
                        height: interestsColumn.height

                        Column {
                            id: interestsColumn
                            anchors.centerIn: parent
                            width: parent.width * 0.9
                            spacing: 10
                            Text {
                                width: parent.width * 0.9
                                text: "Interests"
                                font.pixelSize: 20
                                color: "#50aff5"
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.98
                                height: 1
                                color: "grey"
                                opacity: 0.4
                            }

                            TextField {
                                id: interestsEntry
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.9
                                wrapMode: Text.WordWrap
                                text: profile_Interests.toString()
                                placeholderText: "Hiking,Biking,Photography"
                                // horizontalAlignment: Text.AlignHCenter
                                background: Rectangle {
                                    anchors.fill: parent
                                    opacity: 0.1
                                    radius: height / 2
                                    color: "grey"
                                }
                            }

                            Item {
                                width: parent.width
                                height: 20
                            }
                        }
                    }

                    Page {
                        id: commit
                        width: proEditForm.width
                        height: commitColumn.height

                        Column {
                            id: commitColumn
                            width: parent.width
                            spacing: 10

                            Item {
                                width: parent.width
                                height: 40
                            }
                            Button {
                                id: finish
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.8
                                //height: 81
                                text: "Submit"
                                enabled: true
                                highlighted: false
                                flat: false

                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    opacity: enabled ? 1.0 : 0.3
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                background: Rectangle {
                                    opacity: enabled ? 1 : 0.3
                                    radius: height / 2
                                    color: "#50aff5"
                                }

                                onClicked: {
                                    var data1 = '{"name":"' + fullname.text + '","email":"'
                                            + email.text + '","phone":"' + phone.text
                                            + '","profession":"' + profession.text
                                            + '","company":"' + companyname.text + '"}'
                                    var data2 = '{"about":"' + aboutEntry.text + '"}'
                                    var data3 = '{"skills":"' + skillsEntry.text.replace(
                                                /, /g, ",") + '","interests":"'
                                            + interestsEntry.text.replace(
                                                /, /g, ",") + '"}'
                                    var data4 = '{}'
                                    OpenSeed.send_profile(userid, data1, data2,
                                                          data3, data4, "", 1)
                                    proEditForm.visible = false

                                    profile_Name = fullname.text
                                    profile_Email= email.text
                                    profile_Phone = phone.text
                                    profile_Profession = profession.text
                                    profile_Company = companyname.text
                                    profile_About = aboutEntry.text
                                    profile_Skills = skillsEntry.text.replace(
                                                /, /g, ",").split(",")
                                    profile_Interests = interestsEntry.text.replace(
                                                /, /g, ",").split(",")
                                }
                            }

                            Button {
                                id: cancel
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.8
                                //height: 81
                                text: "Cancel"
                                enabled: true
                                highlighted: false
                                flat: false

                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    opacity: enabled ? 1.0 : 0.3
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    elide: Text.ElideRight
                                }

                                background: Rectangle {
                                    opacity: enabled ? 1 : 0.3
                                    radius: height / 2
                                    color: "#50aff5"
                                }

                                onClicked: {
                                    proEditForm.visible = false
                                }
                            }
                        }
                    }
                }
            }
        }

        Page {
            clip: true

            Flickable {
                width: parent.width * 0.9
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height
                contentHeight: settings_column.height + 100

                Column {
                    id: settings_column
                    width: parent.width
                    spacing: 15
                    Page {
                        id: status
                        width: parent.width
                        height: statusColumn.height
                        Column {
                            id: statusColumn
                            width: parent.width
                            spacing: 5

                            Item {
                                width: parent.width
                                height: 10
                            }

                            Text {
                                width: parent.width * 0.9
                                text: "General"
                                font.pixelSize: 20
                                color: "#50aff5"
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.98
                                height: 1
                                color: "grey"
                                opacity: 0.4
                            }

                            Column {
                                width: parent.width
                                Text {
                                    text: "Change Status"
                                    anchors.left: parent.left
                                }
                                Row {
                                    id: opts
                                    anchors.right: parent.right
                                    RadioButton {
                                        id: online
                                        text: "Online"
                                        checked: chat_status == "Online" ? true : false
                                        onCheckedChanged: {
                                            if (checked == true) {
                                                chat_status = "Online"
                                                OpenSeed.updates(
                                                            userid, username,
                                                            "set_status",
                                                            '{"location":"0:1","chat":"'
                                                            + chat_status + '"}')
                                            }
                                        }
                                    }
                                    RadioButton {
                                        id: busy
                                        text: "Busy"
                                        checked: chat_status == "Busy" ? true : false
                                        onCheckedChanged: {
                                            if (checked == true) {
                                                chat_status = "Busy"
                                                OpenSeed.updates(
                                                            userid, username,
                                                            "set_status",
                                                            '{"location":"0:1","chat":"'
                                                            + chat_status + '"}')
                                            }
                                        }
                                    }
                                    RadioButton {
                                        id: offline
                                        text: "Offline"
                                        checked: chat_status == "Offline" ? true : false
                                        onCheckedChanged: {
                                            if (checked == true) {
                                                chat_status = "Offline"
                                                OpenSeed.updates(
                                                            userid, username,
                                                            "set_status",
                                                            '{"location":"0:1","chat":"'
                                                            + chat_status + '"}')
                                            }
                                        }
                                    }
                                }
                            }

                            Item {
                                width: parent.width
                                height: notifications.height

                                Text {
                                    text: "Receive Notifications:"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    opacity: notifications.enabled ? 1.0 : 0.3
                                }

                                Switch {
                                    id: notifications
                                    enabled: false
                                    position: 0
                                    anchors.right: parent.right
                                }
                            }

                            Item {
                                width: parent.width
                                height: 20
                            }

                            Text {
                                width: parent.width * 0.9
                                text: "Social"
                                font.pixelSize: 20
                                color: "#50aff5"
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.98
                                height: 1
                                color: "grey"
                                opacity: 0.4
                            }

                            Item {
                                width: parent.width
                                height: location.height
                                Text {
                                    text: "Use Location Services"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                }
                                Switch {
                                    id: location
                                    position: 1
                                    anchors.right: parent.right
                                }
                            }

                            Item {
                                width: parent.width
                                height: requests.height
                                Text {
                                    text: "Auto Accept Requests:"
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: requests.enabled ? 1.0 : 0.3
                                }

                                Switch {
                                    id: requests
                                    enabled: false
                                    position: 0
                                    anchors.right: parent.right
                                }
                            }

                            Text {
                                text: "Auto Accept Price:"
                                anchors.left: parent.left
                                opacity: request_limit.enabled ? 1.0 : 0.3
                            }

                            Slider {
                                id: request_limit
                                width: parent.width * 0.8
                                value: 0.5
                                from: 0.0
                                to: 100.0
                                enabled: false

                                Text {
                                    anchors.left: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: parent.value
                                    opacity: request_limit.enabled ? 1.0 : 0.3
                                }
                            }

                            Item {
                                width: parent.width
                                height: 20
                            }

                            Text {
                                width: parent.width * 0.9
                                text: "Account Link"
                                font.pixelSize: 20
                                color: "#50aff5"
                            }

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.98
                                height: 1
                                color: "grey"
                                opacity: 0.4
                            }

                            Text {
                                width: parent.width * 0.9
                                wrapMode: Text.WordWrap
                                text: "Linking external accounts will allow Openlink to intergrate with those services."
                            }

                            Item {
                                width: parent.width
                                height: steemLink.height
                                Text {
                                    text: "Link Steem Account:"
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: steemLink.enabled ? 1.0 : 0.3
                                }

                                Switch {
                                    id: steemLink
                                    enabled: false
                                    position: 0
                                    anchors.right: parent.right
                                }
                            }

                            Item {
                                width: parent.width
                                height: githubLink.height
                                Text {
                                    text: "Link Github Account:"
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: githubLink.enabled ? 1.0 : 0.3
                                }

                                Switch {
                                    id: githubLink
                                    enabled: false
                                    position: 0
                                    anchors.right: parent.right
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
