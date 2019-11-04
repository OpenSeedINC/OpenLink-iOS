import QtQuick 2.12
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "circlepic.js" as Scripts

Item {
    id: card_avatar_backing
    property string whichPic: ""
    property string where: ""
    property string thesource: ""
    property string fixpic: "qrc:/img/avatar-default-symbolic.svg"

    //clip: true
    Component.onCompleted: {
        Scripts.returnImage(whichPic, where, thesource)
    }

    onWhichPicChanged: {
        Scripts.returnImage(whichPic, where, thesource)
    }

    onWhereChanged: {
        Scripts.returnImage(whichPic, where, thesource)
    }

    Rectangle {
        id: background
        anchors.fill: parent
        anchors.margins: 1
        radius: width / 2
        visible: false
    }

    DropShadow {
        anchors.fill: background
        source: background
        radius: 5
        verticalOffset: 5
        color: "#55000000"
    }

    Image {
        id: cardsava
        anchors.fill: parent
        anchors.margins: 0
        visible: false
        source: if (fixpic === 'undefined' || fixpic.length < 4) {
                    "qrc:/img/avatar-default-symbolic.svg"
                } else {
                    fixpic
                }
        fillMode: Image.PreserveAspectCrop
    }

    OpacityMask {
        anchors.fill: cardsava
        source: cardsava
        maskSource: mask
    }
}
