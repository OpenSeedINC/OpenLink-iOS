import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item {
    id: rectangle
    width: 400
    height: 700

    Rectangle {
        color: "#ffffff"
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.width: 1
        clip: false
        width: 380
        height: 350
        visible: true

        Text {
            id: title
            x: 177
            text: "Secure Your Account"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 22
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Rectangle {
            id: shadow
            x: 10
            y: 10
            width: 376
            height: 345
            color: "#801e282e"
            radius: 10
            enabled: false
            z: -1
        }

        TextField {
            id: password
            x: 20
            y: 154
            width: 341
            height: 38
            text: ""
            font.underline: false
            horizontalAlignment: Text.AlignHCenter
            placeholderText: "Password/Pin"
        }

        Button {
            id: setpassword
            x: 108
            y: 264
            width: 165
            height: 40
            text: "Set"

            contentItem: Text {
                text: setpassword.text
                font: setpassword.font
                opacity: enabled ? 1.0 : 0.3
                color: setpassword.down ? "#99d7fb" : "#007fd8"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                //implicitWidth: 100
                //implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: setpassword.down ? "#99d7fb" : "#007fd8"
                border.width: 1
                radius: 8
            }
        }
    }
}
