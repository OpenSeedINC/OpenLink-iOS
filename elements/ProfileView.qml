import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12 as Sql
import "../OpenSeed.js" as OpenSeed
import "../main.js" as Scripts
import "../"
Page {
    id:profileView
    title:"Profile View"
    width:parent.width
    height:parent.height
    property string name:"Profile"
    property string accountname: ""

    property string aname: ""
    property string aimage: ""
    property string aemail: ""
    property string aphone: ""
    property string aprofession: ""
    property string acompany: ""
    property string aabout: ""
    property string abanner:""
    property var askills
    property var ainterests
    property var raw_array


    clip:true
    state:"hide"
    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: profileView
                x:-parent.width
            }
        },

        State {
            name: "show"
            PropertyChanges {
                target: profileView
                x:0
            }
        }
    ]

    transitions: [
        Transition {
            from: "hide"
            to: "show"
            reversible: true

            NumberAnimation {
                target: profileView
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    ]

    onAccountnameChanged: {
        OpenSeed.profile(accountname)
    }


    Image {
        anchors.fill:parent
        source: "qrc:/img/bg-splash-blue.png"
        fillMode: Image.PreserveAspectCrop
        z:-1
        opacity:0.3
    }

    Image {
        id: banner
        source: abanner
        anchors.top: parent.top
        width:parent.width
        fillMode: Image.PreserveAspectCrop
        height:parent.height * 0.4


    }

    Image {
        source:"qrc:/img/left-arrow.svg"
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 10
        height:32
        width:32
        opacity: 0.5
        MouseArea {
            anchors.fill: parent
            onClicked: {
               link_profile.state = "hide"
            }
        }
    }


  Flickable {

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -10
        width:parent.width
        height:parent.height * 0.9

        contentHeight: mainInfo.height
        contentWidth: width
        //clip:true

   Item {
       height:profileView.height + mainInfo.height + 100
       width:profileView.width
       anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id:topbar
            anchors.fill: parent

            visible: false
            radius: 25
             }

        DropShadow {
            source:topbar
            anchors.fill: topbar
            radius: 5
            verticalOffset: -1
        }

        CirclePic {
            id:idPic
            anchors.left: parent.left
            anchors.leftMargin: width * 0.25
            anchors.top:topbar.top
            anchors.topMargin:-height * 0.25
            fixpic: aimage
            width:96
            height:96
        }
        Text {
         anchors.left: parent.left
            anchors.leftMargin:idPic.width * 1.5
         anchors.top:topbar.top
         text:aname
         horizontalAlignment: Text.AlignLeft
            color:"#50aff5"
            font.pixelSize: 20
            font.bold: true

        Text {
            id:profession
            anchors.left: parent.left
            anchors.top:parent.bottom
            text: aprofession
            font.pixelSize: 12
            opacity: 0.4
            horizontalAlignment: Text.AlignLeft
        }
        Column {
            anchors.left: parent.left
            anchors.top:profession.bottom
            Text {
                anchors.left: parent.left
                text: aphone
                font.pixelSize: 12
                //opacity: 0.4
                horizontalAlignment: Text.AlignLeft
            }
            Text {
                anchors.left: parent.left
                text: aemail
                font.pixelSize: 12
                //opacity: 0.4
                horizontalAlignment: Text.AlignLeft
            }
        }

    }

    Rectangle {
        id:contactInfoArea
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:idPic.bottom
        anchors.topMargin: idPic.height * 0.15
        height: 1
        color:"grey"
        opacity: 0.4
    }


        Column {
            id:mainInfo
            spacing:20
            anchors.top:contactInfoArea.bottom
            anchors.topMargin: 5
            width:profileView.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id:aboutBox
                color:"#bbddff"
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.9
                height:aboutText.height * 1.8
                clip:true
                visible: false
                Text {
                    id:aboutText
                    text:aabout
                    width:parent.width * 0.85
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    anchors.centerIn: parent
                    //font.pixelSize:12
                    onTextChanged: if(text.length > 5) {aboutBox.visible = true} else {aboutBox.visible = false}

                }

            }

            Row {
                 width:parent.width * 0.9
                 anchors.horizontalCenter: parent.horizontalCenter

                 Column {
                     width:parent.width * 0.5
                     spacing: 5
                     Text {
                         text:"Skills"
                         font.bold: true
                         color:"#50aff5"
                         font.pixelSize: 16
                     }

                     Item {
                         height:10
                         width:parent.width
                     }


                     Repeater {
                         model:askills

                         delegate: Text {
                             text:"#"+askills[index].trim()
                             font.pixelSize:12
                         }
                     }

                 }
                 Item {
                     height:20
                     width:parent.width * 0.1
                 }

                 Column {
                     width:parent.width * 0.5
                     spacing: 5
                     Text {
                         text:"Interests"
                         font.bold: true
                         color:"#50aff5"
                         font.pixelSize: 16
                     }

                     Item {
                         height:10
                         width:parent.width
                     }

                     Repeater {
                         model:ainterests

                         delegate: Text {
                             text:"#"+ainterests[index].trim()
                             font.pixelSize:12
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
}




