import QtQuick 2.9
import QtQuick.Controls 2.2


ApplicationWindow {
    id:mainWindow
    visible: true
    width: 650
    height: 850
    title: qsTr("HEALTHCARE APP")

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    SwipeView {
        id: swipeView

        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Component.onCompleted: {
            contentItem.interactive = false
        }

        Page1Form {
            id: mainPage
        }

        Page2Form {
            id: settings
        }
    }//end SwipeView

    Client{
        id:client
    }

    footer:
        TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            id: tabButton1

            text: qsTr("MONITOR")
            onClicked: {
                //client.setServer(settings.front_ip,settings.front_port)
            }//end onClicked
        }//end TabButton1

        TabButton {
            id: tabButton2

            text:  qsTr("SETTINGS")
            onClicked: {
                //client.setServer(settings.rear_ip,settings.rear_port)
            }//end onClicked
        }//endTabButton2
    }//end TabBar



}
