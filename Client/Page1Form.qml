import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page

    width: 600
    height: 1200

    /************************************************************************************************/
    /*************************************** PROPERTIES *********************************************/
    /************************************************************************************************/

    property string color1: "#0F7BC6"
    property string color2: "#222E50"
    property string color3: "#0F7BC6"
    property string color4: "#ffcc33"
    property string color5: "#ffb347"

    property bool   conCheck: false //checks the connection to the server
    property bool   pulseAlert: false
    property bool   tempAlert: false

    /************************************************************************************************/
    /*************************************** FUNCTIONS **********************************************/
    /************************************************************************************************/

    function conStatus(status) { //function for checking the connection status
        conCheck = status;
    }//end function conStatus


    function setTemp(temp){
        var res = temp.slice(0, 4);
        temp_text.text = res;
    }

    function setPulse(pulse){
        pulse_text.text = pulse;
    }

    function setInfo(t,p){

        var pulse = parseFloat(p);
        var temp = parseFloat(t);

        if(temp < 36.1 && pulse < 60){
            info_text.text = "Temperature and pulse are low!"
            pulseAlert = true;
            tempAlert = true;
        }
        if (temp < 36.1 && pulse > 60 && pulse < 100){
            info_text.text = "Temperature is low!"
            pulseAlert = false;
            tempAlert = true;
        }
        if (temp < 36.1 && pulse > 100){
            info_text.text = "Temperature is low and pulse is high!"
            pulseAlert = true;
            tempAlert = true;
        }
        if (temp > 36.1 && temp < 37.2 && pulse < 60){
            info_text.text = "Pulse is low!"
        }
        if (temp > 36.1 && temp < 37.2 && pulse > 60 && pulse < 100){
            info_text.text = ""
            pulseAlert = false;
            tempAlert = false;
        }
        if (temp > 36.1 && temp < 37.2 && pulse > 100){
            info_text.text = "Pulse is high!"
            pulseAlert = true;
            tempAlert = false;
        }
        if(temp > 37.2 && pulse < 60){
            info_text.text = "Temperature is high and pulse is low!"
            pulseAlert = true;
            tempAlert = true;
        }
        if(temp > 37.2 && pulse > 60 && pulse < 100){
            info_text.text = "Temperature is high!"
            pulseAlert = false;
            tempAlert = true;
        }
        if(temp > 37.2 && pulse > 100){
            info_text.text = "Temperature and pulse are high!"
            pulseAlert = true;
            tempAlert = true;
        }

    }

    function setAlert(){
        alert1_image.visible = true;
        alert2_image.visible = true;
        alert_text.visible = true;
    }



    /************************************************************************************************/
    /*************************************** DESIGN *************************************************/
    /************************************************************************************************/

    Rectangle{ // background rectangle
        id: background_rect

        width: page.width
        height: page.height

        gradient: Gradient {
            GradientStop { position: 0.0; color: color4 }
            GradientStop { position: 1.0; color: color5 }
        }//end gradient fresh turboscent

/*************************************** DESIGN *************************************************/
        Rectangle{
            id: header
            width: parent.width
            height: parent.height * 0.15
            color: "transparent"

            Text {
                id: header_text

                text: qsTr("HEALTHCARE APP")
                color: color2

                font.pixelSize: Qt.application.font.pixelSize * 1.7
                font.bold: true

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: wifi_image.bottom
            }//end header_text

            Image { //WiFi Image
                id: wifi_image

                source: conCheck == true ? "qrc:/images/wifi.png" : "qrc:/images/wifi-off.png"
                smooth: true

                width: parent.height * 0.30
                height: parent.height * 0.30

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10

                sourceSize.width: 200
                sourceSize.height: 200
            }//end wifi_image

        } //end header
/*************************************** DESIGN *************************************************/
        Rectangle{
            id: body1
            width: parent.width
            height: parent.height * 0.45
            color: "transparent"
            anchors.top: header.bottom

            Rectangle{
                id: temp_rect
                color: color2
                width: parent.width * 0.40
                height: parent.height * 0.90
                radius: 10

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: parent.width * 0.07

                Image {
                    id: temp_image

                    source: "qrc:/images/thermometer.png"
                    smooth: true

                    height: parent.height * 0.30 < parent.width ? parent.height * 0.30 : parent.width
                    width: parent.height * 0.30 < parent.width ? parent.height * 0.30 : parent.width

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    sourceSize.width: 200
                    sourceSize.height: 200
                }//end temp_image

                Rectangle{
                    id: temp_rect2
                    color: color1

                    height: parent.height * 0.30
                    width: parent.width * 0.95

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: temp_image.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Text {
                        id: temp_text
                        text: qsTr("00.0")
                        color: "white"
                        font.bold: true
                        anchors.centerIn: parent
                        font.pixelSize: Qt.application.font.pixelSize * parent.width * 0.03
                    }

                } // end temp_rect2

                Rectangle{
                    id: temp_rect3
                    color: "transparent"

                    anchors.top: temp_rect2.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    Image {
                        id: indicator_temp

                        source: tempAlert ? "qrc:/images/warning.png" : "qrc:/images/success.png"
                        smooth: true

                        height: parent.height < parent.width ? parent.height * 0.55 : parent.width * 0.55
                        width: parent.height  < parent.width ? parent.height * 0.55 : parent.width * 0.55

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: 200
                        sourceSize.height: 200
                    }//end indicator_temp
                }//end temp_rect3






            } //end temp_rect
/*************************************** DESIGN *************************************************/
            Rectangle{
                id: pulse_rect
                color: color2
                width: parent.width * 0.40
                height: parent.height * 0.90
                radius: 10

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.07

                Image {
                    id: pulse_image

                    source: "qrc:/images/cardiogram.png"
                    smooth: true

                    height: parent.height * 0.30 < parent.width ? parent.height * 0.30 : parent.width
                    width: parent.height * 0.30 < parent.width ? parent.height * 0.30 : parent.width

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    sourceSize.width: 200
                    sourceSize.height: 200
                }//end pulse_image

                Rectangle{
                    id: pulse_rect2
                    color: color1

                    height: parent.height * 0.30
                    width: parent.width * 0.95

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: pulse_image.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Text {
                        id: pulse_text
                        text: qsTr("000")
                        color: "white"
                        font.bold: true
                        anchors.centerIn: parent
                        font.pixelSize: Qt.application.font.pixelSize * parent.width * 0.03
                    }

                } //end pulse_rect2

                Rectangle{
                    id: pulse_rect3
                    color: "transparent"

                    anchors.top: pulse_rect2.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    Image {
                        id: indicator_pulse

                        source: pulseAlert ? "qrc:/images/warning.png" : "qrc:/images/success.png"
                        smooth: true

                        height: parent.height < parent.width ? parent.height * 0.55 : parent.width * 0.55
                        width: parent.height  < parent.width ? parent.height * 0.55 : parent.width * 0.55

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        sourceSize.width: 200
                        sourceSize.height: 200
                    }//end indicator_temp
                }//end temp_rect3


            } //end pulse_rect


        } // end body1
/*************************************** DESIGN *************************************************/
        Rectangle{
            id: info_rect
            width: parent.width * 0.865
            height: parent.height * 0.04
            radius: 10
            color: color2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: body1.bottom


            Text {
                id: info_text
                color: "white"
                text: qsTr("No data.")
                anchors.centerIn: parent
                //font.pixelSize: Qt.application.font.pixelSize * 1.9
                //width: parent.width
            }
        } // end info_rect
/*************************************** DESIGN *************************************************/
        Rectangle{
            id: alert_rect
            width: parent.width
            height: parent.height * 0.10

            anchors.top: info_rect.bottom
            color: "transparent"

            Text {
                id: alert_text
                text: qsTr("Patient needs your help !")
                anchors.centerIn: parent
                color: color2
                font.bold: true
                visible: false
            }

            Image {
                id: alert1_image

                source: "qrc:/images/bell.png"
                smooth: true
                visible: false

                height: parent.height < parent.width ? parent.height * 0.55 : parent.width * 0.55
                width: parent.height  < parent.width ? parent.height * 0.55 : parent.width * 0.55

                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                sourceSize.width: 200
                sourceSize.height: 200
            }//end alert1_image

            Image {
                id: alert2_image

                source: "qrc:/images/bell.png"
                smooth: true
                visible: false

                height: parent.height < parent.width ? parent.height * 0.55 : parent.width * 0.55
                width: parent.height  < parent.width ? parent.height * 0.55 : parent.width * 0.55

                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                sourceSize.width: 200
                sourceSize.height: 200
            }//end alert2_image



        }
/*************************************** DESIGN *************************************************/
        Rectangle{
            id: response_rect

            width: parent.width
            height: parent.height * 0.26
            color: "transparent"

            anchors.top: alert_rect.bottom

            Button{
                id: response_button
                text: "SEND\nRESPONSE"
                font.pixelSize: Qt.application.font.pixelSize * 1.3
                font.bold: true

                anchors.centerIn: parent

                width: parent.width < parent.height ? parent.width * 0.90 : parent.height * 0.90
                height: parent.width < parent.height ? parent.width * 0.90 : parent.height * 0.90

                background: Rectangle{
                    color: color3
                    border.color: color2
                    border.width: 3
                    radius: width/2

                }

                contentItem: Text {
                    text: response_button.text
                    font: response_button.font
                    opacity: enabled ? 1.0 : 0.3
                    color: response_button.down ? color2 : color4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                onClicked: {
                   client.sendMessage("response");
                   alert1_image.visible = false;
                   alert2_image.visible = false;
                   alert_text.visible = false;

                }

            } //end response_button
        } //end response_rect


    } //end background rectangle

}// end Page
