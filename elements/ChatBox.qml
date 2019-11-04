import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "../"
import "../OpenSeed.js" as OpenSeed
import "../main.js" as Scripts

Item {
    id:chatbox
    //property bool local: false
    property string secret: OpenSeed.simp_decrypt(ekey,message)

    height:if(mesg.height * 2 > 130) {mesg.height * 2} else {130}
    anchors.horizontalCenter: parent.horizontalCenter
    width:parent.width * 0.9


    Rectangle {
        id:bg
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: if(local == true) {0.95 * parent.width - width} else {width  - (parent.width * 0.95)}

        color:if(local == true) {"#50aff5"} else {"white"}
        radius: 8
        width:parent.width * 0.85
        height:parent.height * 0.70
        visible: false
    }

    DropShadow {
        anchors.fill: bg
        source:bg
        verticalOffset: 3
        horizontalOffset: if(local == true) {-3} else {3}
        radius: 5
        color:"#99000000"
    }

    Text {
        anchors.top:bg.bottom
        anchors.horizontalCenter: bg.horizontalCenter
        anchors.topMargin: 5
        text:if(local == true) {window.profile_Name} else {aname}
        opacity: 0.4
        //color:if(local == false) {"#50aff5"} else {"white"}
    }
    Item {
        width:bg.width * 0.80
        anchors.horizontalCenter: bg.horizontalCenter
        anchors.verticalCenter: bg.verticalCenter
        height:mesg.height
        clip:true
    Text {
        id:mesg
        text:secret
        width:parent.width
        verticalAlignment: Text.AlignTop
        wrapMode: Text.WordWrap
        color:if(local == false) {"#50aff5"} else {"white"}
        Image {
            anchors.centerIn: parent
            source:{
                var formats = ["gif","jpeg","jpg","png"]
                for(var num in formats) {
                if(secret.search(formats[num]) !== -1) {
                    secret
                    break
                    }
                }
            }
            width:parent.width
            fillMode: Image.PreserveAspectFit
            visible: {
                var formats = ["gif","jpeg","jpg","png"]
                for(var num in formats) {
                    if(secret.search(formats[num]) !== -1) {
                         true
                        parent.height = height
                        break
                     } else {
                         false
                     }
                }
            }

          }

        }
    }

    CirclePic {
        width:48
        height:48
        anchors.bottom:bg.bottom
        anchors.bottomMargin: -height * 0.80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: if(local == true) {parent.width * 0.45} else {-parent.width * 0.45}
        fixpic:if(local == true) {window.profile_Image} else {aimage}
    }
}
