import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page

    width: 600
    height: 500

    /************************************************************************************************/
    /*************************************** PROPERTIES *********************************************/
    /************************************************************************************************/

    property string color1: "#0F7BC6"
    property string color2: "#222E50"
    property string color3: "#0F7BC6"
    property string color4: "#ffcc33"
    property string color5: "#ffb347"

    property bool   conCheck: false //checks the connection to the server

    /************************************************************************************************/
    /*************************************** FUNCTIONS **********************************************/
    /************************************************************************************************/

    function conStatus(status) { //function for checking the connection status
        conCheck = status;
    }//end function conStatus

    function setStatus(status){
        header2_text.text = status;
    }

    function setTemp(temp){
        var res = temp.slice(0, 4);
        temp_text.text = res;
    }

    function setPulse(pulse){
        pulse_text.text = pulse;
    }

    function setMessage(message){
         header2_text.text = message;
    }

    function setAlert(message){
        bell_image.visible = true;
        message_text.text = message;
    }


    /************************************************************************************************/
    /*************************************** DESIGN *************************************************/
    /************************************************************************************************/

    Rectangle{ // background rectangle
        id: background_rect

        width: page.width
        height: page.height
        //color: color2

        gradient: Gradient {
            GradientStop { position: 0.0; color: color4 }
            GradientStop { position: 1.0; color: color5 }
        }//end gradient fresh turboscent



        Rectangle{

            id: rect_header1_background
            width: background_rect.width
            height: background_rect.height * 0.125
            anchors.top: background_rect.top
            color: "transparent"

                Text { //top screen Text
                    id: text_header1

                    text: qsTr("HEALTHCARE APP")
                    color: color2

                    font.pixelSize: Qt.application.font.pixelSize * 1.7
                    font.bold: true
                    leftPadding: 10
                    rightPadding: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }//end text_header1

        } // end rect_header1_background

        Rectangle{

            id: rect_body1_background
            width: background_rect.width
            height: background_rect.height * 0.375
            anchors.top: rect_header1_background.bottom
            color:"transparent"

            Row{
                id: body1_row
                topPadding:   parent.height * 0.01
                leftPadding:  parent.width * 0.05
                bottomPadding:   parent.height * 0.01
                spacing: parent.width * 0.10

                Rectangle{
                    id:rect_temp
                    color:color2
                    radius: 10
                    width: rect_body1_background.width * 0.40
                    height: rect_body1_background.height * 0.90

                    Image { //WiFi Image
                        id: temp_image

                        source: "qrc:/images/thermometer.png"
                        smooth: true

                        height: rect_temp.width < rect_temp.height ? rect_temp.width * 0.50 : rect_temp.height * 0.50
                        width: rect_temp.width < rect_temp.height ? rect_temp.width * 0.50 : rect_temp.height * 0.50

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.verticalCenter

                        sourceSize.width: 200
                        sourceSize.height: 200
                    }//end header1_image

                    Text { //top screen Text
                        id: temp_text

                        text: qsTr("00.0")
                        color: "white"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: temp_image.bottom

                        fontSizeMode: Text.HorizontalFit; minimumPixelSize: 10; font.pixelSize: 72

                    }//end text_header1
                }//end rect_temp

                Rectangle{
                    id:rect_pulse
                    color:color2
                    radius: 10
                    width: rect_body1_background.width * 0.40
                    height: rect_body1_background.height * 0.90

                    Image { //WiFi Image
                        id: pulse_image

                        source: "qrc:/images/cardiogram.png"
                        smooth: true

                        height: rect_pulse.width < rect_pulse.height ? rect_pulse.width * 0.50 : rect_pulse.height * 0.50
                        width: rect_pulse.width < rect_pulse.height ? rect_pulse.width * 0.50 : rect_pulse.height * 0.50

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.verticalCenter

                        sourceSize.width: 200
                        sourceSize.height: 200
                    }//end header1_image

                    Text { //top screen Text
                        id: pulse_text

                        text: qsTr("000")
                        color: "white"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: pulse_image.bottom

                        fontSizeMode: Text.HorizontalFit; minimumPixelSize: 10; font.pixelSize: 72

                    }//end text_header1

                }
            }



        } //end rect_body1_background

        Rectangle{

            id: rect_header2_background
            width: background_rect.width
            height: background_rect.height * 0.125
            anchors.top: rect_body1_background.bottom
            color: "transparent"

            Rectangle{
                id: header2_rect
                color: color2
                radius: 5
                width:  parent.width   * 0.90
                height: parent.height  * 0.90

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: header2_text
                    color:color4
                    font.bold: true
                    text: qsTr("No data.")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    fontSizeMode: Text.HorizontalFit
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                }
            }






        }//end rect_header2_background

        Rectangle{

            id: rect_body2_background
            width: background_rect.width
            height: background_rect.height * 0.375
            anchors.top: rect_header2_background.bottom
            color: "transparent"

            Rectangle{
                id:left_rect
                width: parent.width * 0.05
                height: parent.height * 0.90
                color: "transparent"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
            }

            Rectangle{
                id:messageRect
                width: parent.width/2
                height: parent.height * 0.90
                color: color1
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: left_rect.right
                radius: 10
                border.color: color2
                border.width: 3

                Image { //WiFi Image
                    id: bell_image

                    source: "qrc:/images/bell.png"
                    smooth: true

                    visible: false

                    height: parent.height/3
                    width: parent.height/3

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    sourceSize.width: 200
                    sourceSize.height: 200
                }//end header1_image

                Text{
                    id: message_text
                    color:color4
                    font.bold: true
                    text: qsTr("NO ALERT.")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    fontSizeMode: Text.HorizontalFit
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                }

            }

            Rectangle{
                id:center_rect
                width: parent.width * 0.05
                height: parent.height * 0.90
                color: "transparent"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: messageRect.right
            }

            Button{
                id: responseButton
                text: "SEND\nRESPONSE"
                font.pixelSize: Qt.application.font.pixelSize * 1.3
                font.bold: true

                contentItem: Text {
                    text: responseButton.text
                    font: responseButton.font
                    opacity: enabled ? 1.0 : 0.3
                    color: responseButton.down ? color2 : color4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                onClicked: {
                    message_text.text = "RESPONSE SENT !"
                    bell_image.visible = true;
                }



                width: parent.width * 0.35 < parent.height * 0.90 ? parent.width * 0.35 : parent.height * 0.90
                height: parent.width * 0.35 < parent.height * 0.90 ? parent.width * 0.35 : parent.height * 0.90
                background: Rectangle{
                    color: color3
                    border.color: color2
                    border.width: 3
                    radius: width/2

                }
                anchors.left: center_rect.right
                anchors.verticalCenter: parent.verticalCenter

            }

            Rectangle{
                id:right_rect
                width: parent.width * 0.05
                height: parent.height * 0.90
                color: "transparent"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.left: responseButton.right
            }



        } //end rect_body2_background



    } //end background rectangle

}// end Page
