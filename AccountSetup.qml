import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import "OpenSeed.js" as OpenSeed
import "main.js" as Scripts

Page {
    id: page
    title: ""

    width: parent.width
    height: parent.height

    property var profileCreated: 0
    property string username: ""
    property string passphrase: ""
    property string email: ""
    property var data1: ""

    property string theid: ""

    onTheidChanged: {
        data1 = '{"name":"' + fullname.text + '","email":"' + email.text
                + '","phone":"' + phone.text + '","profession":"'
                + profession.text + '","company":"' + companyname.text + '"}'
        profileCreated = OpenSeed.send_profile(theid, data1, "", "", "", "", "")
    }

    onProfileCreatedChanged: swipeView.setCurrentIndex(6)

    Image {
        source: "qrc:/img/left-arrow.svg"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        height: 32
        width: 32
        MouseArea {
            anchors.fill: parent
            onClicked: swipeView.setCurrentIndex(4)
        }
    }

    Text {
        id: title
        x: 64
        y: 52
        text: "Create Profile"
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 40
        color: "#50aff5"
    }

    Button {
        id: create
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        height:40
        anchors.bottomMargin: parent.height * 0.2
        text: "Create Profile"

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
    }

    Connections {
        target: create
        onClicked: {
            if (userid == "") {
                OpenSeed.create_user(username, email.text, passphrase, username)
            } else if (fullname.text != '' && email.text != '') {

                data1 = '{"name":"' + fullname.text + '","email":"' + email.text
                        + '","phone":"' + phone.text + '","profession":"'
                        + profession.text + '","company":"' + companyname.text + '"}'
                profileCreated = OpenSeed.send_profile(userid, data1, "", "",
                                                       "", "", "")
            }
        }
    }

    Column {
        width: parent.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height * 0.05
        spacing: 20

        TextField {
            id: fullname
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.9
            text: ""
            placeholderText: "Full Name"
            horizontalAlignment: Text.AlignHCenter
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
            text: ""
            placeholderText: "Email Account"
            horizontalAlignment: Text.AlignHCenter
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
            text: ""
            placeholderText: "Phone # (Optional)"
            horizontalAlignment: Text.AlignHCenter
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
            text: ""
            placeholderText: "Profession (Optional)"
            horizontalAlignment: Text.AlignHCenter
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
            text: ""
            placeholderText: "Company (Optional)"
            horizontalAlignment: Text.AlignHCenter
            background: Rectangle {
                anchors.fill: parent
                opacity: 0.1
                radius: height / 2
                color: "grey"
            }
        }
    }
    PasswordRequestForm {
        id: passwordRequestForm
        x: 0
        y: 0
        anchors.fill: parent
        anchors.rightMargin: -1
        anchors.leftMargin: 1
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        visible: false
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
