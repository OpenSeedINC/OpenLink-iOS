import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Page {
    id: welcomeForm
    width: window.width
    height: window.height

    title: "Home"

    Image {
        id:back_splash
        source: "qrc:/img/bg-splash-blue.png"
        anchors.top:parent.top
        width:parent.width
        height:parent.height
        fillMode: Image.PreserveAspectCrop
        anchors.topMargin: -parent.height * 0.3


        Image {
            id: logo
            source:"qrc:/img/logo2.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width:parent.width * 0.7
            fillMode: Image.PreserveAspectFit
            antialiasing: true
        }

        Image {
            id:sublogo
            source:"qrc:/img/morse-code.png"
            anchors.top:logo.bottom
            anchors.right:logo.right
            height:7
            fillMode: Image.PreserveAspectFit
            antialiasing: true
        }
    }




    Button {
        id: join
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height * 0.2
        //width: 180
        //height: 81
        text: "Register"
        enabled: true
        highlighted: false
        flat: false

        contentItem: Text {
            text: join.text
            font: join.font
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
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:join.bottom
        anchors.topMargin: 20
        text:"Already have a OpenSeed Account? "
        font.pixelSize: 12

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.bottom
            anchors.topMargin: 10
            //anchors.left: parent.right
            text:"Login"
            color:"green"
            font.pixelSize: 12
            MouseArea {
                anchors.fill: parent
                onClicked: swipeView.setCurrentIndex(1)
            }
        }
    }

    Connections {
        target: join
        onClicked: swipeView.setCurrentIndex(2)
    }
}

/*##^##
Designer {
    D{i:7;anchors_x:0;anchors_y:0}D{i:9;anchors_x:0;anchors_y:0}
}
##^##*/

