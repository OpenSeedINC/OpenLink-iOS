import QtQuick 2.12
import QtGraphicalEffects 1.0
import "../"

Item {
    //property string badge_id: ""
   // property string badgeImg: ""
   // property string badgeDate: ""
   // property string badgeTitle: ""

    Image {
        id:theBadge
        width:parent.width * 0.75
        height:parent.height* 0.75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        fillMode: Image.PreserveAspectFit
        source:badgeImg
    }

    ColorOverlay {
        source:theBadge
        anchors.fill: theBadge
        color: {
            switch(badgeLevel) {
                case 2: "silver";break;
                case 1: "gold";break;
                case 3: "bronze";break;
                }
        }
        opacity: 0.3
        visible: badgeLevel == 0 ? false : true
    }


   Text {
        anchors.top:theBadge.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        text:badgeTitle
        font.pixelSize: 10
        opacity: 0.4
    }
}
