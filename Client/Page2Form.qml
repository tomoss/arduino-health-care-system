import QtQuick 2.9
import QtQuick.Controls 2.1


Page {
    id: page

    width: 600
    height: 400600

    /************************************************************************************************/
    /*************************************** PROPERTIES *********************************************/
    /************************************************************************************************/

    property string color1: "#0F7BC6"
    property string color2: "#222E50"
    property string color3: "#0F7BC6"
    property string color4: "#ffcc33"
    property string color5: "#ffb347"

    property string serverIP: ""
    property string serverPORT: ""

    Rectangle{ // background rectangle
        id: background_rect

        width: page.width
        height: page.height

        gradient: Gradient {
            GradientStop { position: 0.0; color: color4 }
            GradientStop { position: 1.0; color: color5 }
        }//end gradient fresh turboscent

        TextField {
            id: ip_textfield

            height: parent.height * 0.1
            width: page.height / page.width < 1.5 ? page.width * 0.3 : page.width * 0.6

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 50
            anchors.top: parent.top

            text: client.serverIP
            color: "#000000"
            inputMask: "000.000.000.000;_"

            font.pixelSize: Qt.application.font.pixelSize * 1.4
            font.bold: true

            background:
                Rectangle {//Rectangle for the TextField's background
                radius: 10
                border.color: "black"
                width: page.height / page.width < 1.5 ? page.width * 0.3 : page.width * 0.6
            }//end background Rectangle

            onTextChanged: {
                serverIP = ip_textfield.text

            }//end onTextChanged
        }//end ip_textfield

        TextField {
            id: port_textfield

            height: parent.height * 0.1
            width: page.height / page.width < 1.5 ? page.width * 0.3 : page.width * 0.6

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 50
            anchors.top: ip_textfield.bottom

            inputMask: client.serverPORT
            text: "3700"

            font.pixelSize: Qt.application.font.pixelSize * 1.4
            font.bold: true

            background:
                Rectangle { //Rectangle for the TextField's background
                radius: 10
                border.color: "black"
                width: page.height / page.width < 1.5 ? page.width * 0.3 : page.width * 0.6
            }//end background Rectangle

            onTextChanged: {
                serverPORT = port_textfield.text

            }//end onTextChanged
        }//end port_textfield




    } //end background rectangle

}
