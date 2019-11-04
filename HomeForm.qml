import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12 as Sql
import "OpenSeed.js" as OpenSeed
import "main.js" as Scripts

Page {
    width: parent.width
    height: parent.height

    title: "Home"
    property int contacts: 0
    property string name: "Home"


    TabBar {
        id:tabs
        anchors.top: parent.top
        width:parent.width
        height:parent.height * 0.1

        background: Rectangle {
                 color: "white"
             }

        TabButton {
            text:"COLLECTED"
            font.pixelSize: 18
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top:parent.top
            anchors.bottom:parent.bottom
            contentItem: Text {
                text: parent.text
                font: parent.font

                opacity: enabled ? 1.0 : 0.3
                color:"#50aff5"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {

                opacity: enabled ? 1 : 0.3
                color:"white"
            }

            Rectangle {
                visible: if (tabs.currentIndex === 0) { true } else { false }
                anchors.bottom:parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.75
                color:"#50aff5"
                //radius:height  /2
                height:5
            }



        }
        TabButton {
            text:"SEARCH"
            font.pixelSize: 18
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top:parent.top
            anchors.bottom:parent.bottom

            contentItem: Text {
                text: parent.text
                font: parent.font
                opacity: enabled ? 1.0 : 0.3
                color:"#50aff5"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                opacity: enabled ? 1 : 0.3
                color:"white"
            }

            Rectangle {
                visible: if (tabs.currentIndex === 1) { true } else { false }
                anchors.bottom:parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.75
                color:"#50aff5"
                //radius:height  /2
                height:5
            }
        }
    }

    SwipeView {
        interactive: false
        currentIndex: tabs.currentIndex
        anchors.top:tabs.bottom
        width:parent.width
        height:parent.height - foot.height

        Page {
            id:collect
            property var collected_list: []

            state:"active"
            states: [
                State {
                    name: "active"

                    PropertyChanges {
                        target: collectList
                        opacity: 1
                    }
                },
                State {
                    name: "rest"

                    PropertyChanges {
                        target: collectList
                        opacity: 0.0
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "rest"
                    to: "active"
                    reversible: true


                    NumberAnimation {
                        target: collectList
                        property: "opacity"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }


                }
            ]



            Image {
                id: icon
                //fillMode: Image.PreserveAspectFit
                width: window.width * 0.6
                height:window.width * 0.6
                source: "qrc:/img/icon-home.svg"
                anchors.centerIn: parent
                opacity:0.05

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color:"grey"
                }
            }

            ListView {
                id: collectList

                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                clip:true
                opacity: 1

                delegate: Contact{

                }
                model: gps_collected
            }


        }

        Page {
            id:search
            property var search_results: []
            state:"rest"
            states: [
                State {
                    name: "active"

                    PropertyChanges {
                        target: searchList
                        opacity: 1
                    }
                },
                State {
                    name: "rest"

                    PropertyChanges {
                        target: searchList
                        opacity: 0.0
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "rest"
                    to: "active"
                    reversible: true


                    NumberAnimation {
                        target: searchList
                        property: "opacity"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }


                }
            ]

            Image {
                id: icon1

                width: window.width * 0.6
                height: window.width * 0.6
                source: "qrc:/img/edit-find-symbolic.svg"
                anchors.centerIn: parent
                opacity:0.05

                ColorOverlay {
                    anchors.fill: parent
                    source: parent
                    color:"grey"
                }
            }

            ListView {
                id: searchList
                anchors.topMargin: 68
                anchors.bottomMargin: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                clip:true
                opacity: 0.0
                delegate: Contact{

                }
                model: searched

            }

            TextField {
                id:thesearch
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -parent.height * 0.44
                width:parent.width * 0.9
                height:40
                placeholderText: "Search"
                background: Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin:-parent.width * 0.05
                    anchors.rightMargin: -parent.width * 0.05
                    opacity: 0.1
                    radius: height / 2
                    color:"grey"
                }


                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    width:parent.height * 0.7
                    height:parent.height * 0.7
                    source: "qrc:/img/edit-find-symbolic.svg"
                    opacity: 0.5
                    fillMode: Image.PreserveAspectFit
                    ColorOverlay {
                        source:parent
                        anchors.fill: parent
                        color:"#aaaaaa"
                    }
                }

                onTextChanged: {
                    if (thesearch.text == "") {
                        search.state = "rest"
                    }
                }

                onDisplayTextChanged: {
                    print(displayText)
                }

                Keys.onReturnPressed: {
                    search.state = "active"
                    OpenSeed.openseed_search(thesearch.displayText.trim())
                }
            }

        }

    }

    ListModel {
        id:searched

    }

}
