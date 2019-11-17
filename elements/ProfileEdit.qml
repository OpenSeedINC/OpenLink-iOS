import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12 as Sql
import "../OpenSeed.js" as OpenSeed
import "../main.js" as Scripts
import "../"

Page {
    id: profileView
    title: "Profile View"
    width: parent.width
    height: parent.height
    property string name: "Profile"
    property string accountname: ""
    property string profile_Name: ""
    property string profile_Image: ""
    property string profile_Email: ""
    property string profile_Phone: ""
    property string profile_Profession: ""
    property string profile_Company: ""
    property string profile_About: ""
    property string profile_Banner: ""
    property var profile_Skills
    property var profile_Interests

    onAccountnameChanged: {
        OpenSeed.user_profile(accountname)
    }

    Image {
        id: banner
        source: profile_Banner
        anchors.top: parent.top
        width: parent.width
        fillMode: Image.PreserveAspectCrop
        height: parent.height * 0.4

        Image {
            anchors.fill: parent
            source: "qrc:/img/bg-splash-blue.png"
            fillMode: Image.PreserveAspectCrop
            z: -1
        }
    }

    Flickable {

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -10
        width: parent.width
        height: parent.height * 0.9

        contentHeight: mainInfo.height
        contentWidth: width

        //clip:true
        Item {
            height: profileView.height + mainInfo.height + 100
            width: profileView.width
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id:topbar
                anchors.fill: parent

                visible: false
                radius: 25
                 }

            DropShadow {
                source: topbar
                anchors.fill: topbar
                radius: 5
                verticalOffset: -1
            }

            Image {
                source: "qrc:/img/edit-symbolic.svg"
                anchors.top: topbar.top
                anchors.right: topbar.right
                anchors.margins: 10
                height: 20
                width: 20
                opacity: 0.7
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        profileEForm.visible = true
                    }
                }

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color: "grey"
                }
            }

            CirclePic {
                id: idPic
                anchors.left: parent.left
                anchors.leftMargin: width * 0.25
                anchors.top: topbar.top
                anchors.topMargin: -height * 0.25
                fixpic: profile_Image
                width: 96
                height: 96
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: idPic.width * 1.5
                anchors.top: topbar.top
                text: profile_Name
                horizontalAlignment: Text.AlignLeft
                color: "#50aff5"
                font.pixelSize: 20
                font.bold: true

                Text {
                    id: profession
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    text: profile_Profession
                    font.pixelSize: 12
                    opacity: 0.4
                    horizontalAlignment: Text.AlignLeft
                }
                Column {
                    anchors.left: parent.left
                    anchors.top: profession.bottom
                    Text {
                        anchors.left: parent.left
                        text: profile_Phone
                        font.pixelSize: 12
                        //opacity: 0.4
                        horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        anchors.left: parent.left
                        text: profile_Email
                        font.pixelSize: 12
                        //opacity: 0.4
                        horizontalAlignment: Text.AlignLeft
                    }
                }
            }

            Rectangle {
                id:contactInfoArea
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: idPic.bottom
                anchors.topMargin: idPic.height * 0.15
                height: 1
                color: "grey"
                opacity: 0.4
            }
            Column {
                id: mainInfo
                spacing: 20
                anchors.top:contactInfoArea.bottom
                anchors.topMargin: 5
                width: profileView.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: aboutBox
                    color: "#bbddff"
                    radius: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.9
                    height: aboutText.height * 1.8
                    clip: true
                    Text {
                        id: aboutText
                        text: profile_About
                        width: parent.width * 0.85
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        anchors.centerIn: parent

                    }
                }

                Row {
                    width: parent.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        width: parent.width * 0.5
                        spacing: 5
                        Text {
                            text: "Skills"
                            font.bold: true
                            color: "#50aff5"
                            font.pixelSize: 16
                        }

                        Item {
                            height: 10
                            width: parent.width
                        }

                        Repeater {
                            model: profile_Skills

                            delegate: Text {
                                text: "#" + profile_Skills[index].trim()
                                font.pixelSize: 12
                            }
                        }
                    }
                    Item {
                        height: 10
                        width: parent.width * 0.1
                    }

                    Column {
                        width: parent.width * 0.5
                        spacing: 5
                        Text {
                            text: "Interests"
                            font.bold: true
                            color: "#50aff5"
                            font.pixelSize: 16
                        }

                        Item {
                            height: 10
                            width: parent.width
                        }

                        Repeater {
                            model: profile_Interests

                            delegate: Text {
                                text: "#" + profile_Interests[index].trim()
                                font.pixelSize: 12
                            }
                        }
                    }
                }

                Item {
                    id: badges
                    width: parent.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: badgesColumn.height + 20
                    visible: badgeList.count > 0 ? true : false

                    Column {
                        id: badgesColumn
                        anchors.centerIn: parent
                        width: parent.width
                        spacing: 10

                        Text {
                            text: "Badges"
                            font.bold: true
                            color: "#50aff5"
                            font.pixelSize: 16
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.98
                            height: 1
                            color: "grey"
                            opacity: 0.5
                        }

                        GridView {
                            id: badgeGrid
                            width: parent.width * 0.98
                            cellWidth: 80
                            cellHeight: 80
                            height: contentHeight

                            delegate: Badge {
                                width: badgeGrid.cellWidth
                                height: badgeGrid.cellHeight
                            }

                            model: badgeList
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.98
                            height: 1
                            color: "grey"
                            opacity: 0.5
                        }
                    }
                }

                Item {
                    id: achievements
                    width: parent.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: achColumn.height + 20
                    visible: achievementsList.count > 0 ? true : false


                    /*Rectangle {
                   anchors.fill: parent
                   radius:10
                   color:"#ededdd"
                   opacity: 0.5
               } */
                    Column {
                        id: achColumn
                        anchors.centerIn: parent
                        width: parent.width
                        spacing: 10

                        Text {
                            text: "Achievements"
                            font.bold: true
                            color: "#50aff5"
                            font.pixelSize: 16
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.98
                            height: 1
                            color: "grey"
                            opacity: 0.5
                        }

                        GridView {
                            id: achGrid
                            width: parent.width * 0.98
                            cellWidth: 64
                            cellHeight: 96
                            height: contentHeight

                            delegate: Badge {
                                width: achGrid.cellWidth
                                height: achGrid.cellHeight
                            }

                            model: achievementsList
                        }
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.98
                            height: 1
                            color: "grey"
                            opacity: 0.5
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: badgeList
    }

    ListModel {
        id: achievementsList
    }

    ProfileEditForm {
        id: profileEForm
        visible: false
    }
}
