import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page

    width: 600
    height: 500



    /************************************************************************************************/
    /*************************************** PROPERTIES *********************************************/
    /************************************************************************************************/

    property string color1: "#011A27"
    property string color2: "#063852"
    property string color3: "#F0810F"
    property string color4: "#E6DF44"


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


    /************************************************************************************************/
    /*************************************** DESIGN *************************************************/
    /************************************************************************************************/

    Rectangle{ // background rectangle
        id: background_rect

        width: page.width
        height: page.height
        color: color2



        Rectangle{

            id: rect_header1_background
            width: background_rect.width
            height: background_rect.height * 0.125
            anchors.top: background_rect.top
            color:color2

                Text { //top screen Text
                    id: text_header1

                    text: qsTr("HEALTHCARE APP")
                    color: "white"

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
            color:color2

            Row{
                id: body1_row
                topPadding:   parent.height * 0.01
                leftPadding:  parent.width * 0.05
                bottomPadding:   parent.height * 0.01
                spacing: parent.width * 0.10

                Rectangle{
                    id:rect_temp
                    color:color1
                    radius: 10
                    width: rect_body1_background.width * 0.40
                    height: rect_body1_background.height * 0.90

                    Image { //WiFi Image
                        id: temp_image

                        source: "qrc:/images/temp.png"
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
                    color:color1
                    radius: 10
                    width: rect_body1_background.width * 0.40
                    height: rect_body1_background.height * 0.90

                    Image { //WiFi Image
                        id: pulse_image

                        source: "qrc:/images/pulse.png"
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
            color: color2

            Rectangle{
                id: header2_rect
                color: color3
                radius: 5
                width:  parent.width   * 0.90
                height: parent.height  * 0.90

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: header2_text
                    color:color1
                    font.bold: true
                    text: qsTr("Temperature and pulse are normal.")
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
            color: color4



        } //end rect_body2_background



    } //end background rectangle

}// end Page
