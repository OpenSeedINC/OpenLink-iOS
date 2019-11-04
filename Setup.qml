import QtQuick 2.0
import QtQuick.Controls 2.3

Page {
    id: setup
    title: "Setup"
    property bool setupFinished: false


    width:parent.width
    height:parent.height

    onSetupFinishedChanged: {
        setup.visible = false
        ready = true
    }

    SwipeView {
        id: swipeView
        interactive: false
        anchors.fill: parent
        currentIndex: 0

        Welcome {
            id: welcome
        }

        Login {
            id:login
        }

        SteemLogin {
            id:steem
        }

        SteemAccountCheck {
            id:steemAccountCheck
        }

        SecureAccount {
            id:secureAccount
        }

        AccountSetup {
            id: aSetup
        }

        Finish {
            id:finished
        }


    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:800;width:400}D{i:1;anchors_height:200;anchors_width:200;anchors_x:220;anchors_y:147}
}
##^##*/
