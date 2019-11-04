import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "elements"
import "main.js" as Scripts
import "OpenSeed.js" as OpenSeed

Page {
    title: "Address Book"
    width: parent.width
    height: parent.height
    property bool loadcontacts: false
    property bool display_contacts: false
    property var connection_list: []
    property string name: "addressBook"
    clip: true

    ListView {
        id: listView
        anchors.topMargin: 68
        anchors.bottomMargin: 50
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        add: Transition {
            NumberAnimation { properties: "x,y"; duration: 100 }
        }
        delegate: Contact {}
        model: addressBook
    }

    onLoadcontactsChanged: {
        OpenSeed.get_openseed_connections(username)
    }

    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: title.height * 1.6

        Rectangle {
            height: 1
            color: "grey"
            anchors.bottom: parent.bottom
            width: parent.width
        }

        TextField {
            height: window.height * 0.03
            font.pixelSize: 8
            verticalAlignment: Text.AlignVCenter
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -height * 0.5
            placeholderText: "Search"
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                radius: height / 2
                border.color: "grey"
            }

            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                width: parent.height * 0.8
                height: parent.height * 0.8
                source: "qrc:/img/edit-find-symbolic.svg"

                ColorOverlay {
                    source: parent
                    anchors.fill: parent
                    color: "#eeeeee"
                }
            }
        }

        Text {
            id: title
            text: "LINKS"
            height: 48
            font.pixelSize: 48
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -parent.width * 0.3
            color: "#50aff5"
        }

        Text {
            id: links
            text: contacts
            height: 32
            font.pixelSize: 32
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.1
            opacity: 0.5

            Text {
                anchors.top: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Connections"
            }
        }
    }

    ListModel {
        id: addressBook
    }
}
