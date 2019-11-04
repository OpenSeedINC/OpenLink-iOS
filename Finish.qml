import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "OpenSeed.js" as OpenSeed
import "main.js" as Scripts

Page {
    id: page
    title: "Finish"
    width: parent.width
    height: parent.height

    Text {
        text: "Finished"
        font.pixelSize: 54
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        color: "#50aff5"
    }

    Column {
        width: parent.width * 0.95
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height * 0.1

        Text {
            text: "You're all set to use Openlink! Feel free to fill out any additional information about yourself by editing your profile within the app!"
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.9
        }
    }

    Button {
        id: finish
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height * 0.18
        width: parent.width * 0.8
        //height: 81
        text: "Finish"
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
            //OpenSeed.oseed_auth(username)
            setupFinished = true
        }
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "qrc:/img/bg-login.png"
        width: parent.width
        anchors.bottomMargin: -parent.height * 0.1
    }
}
