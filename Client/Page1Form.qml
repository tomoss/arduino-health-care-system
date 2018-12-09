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

    property bool   conCheck: false //checks the connection to the server

    /************************************************************************************************/
    /*************************************** FUNCTIONS **********************************************/
    /************************************************************************************************/

    function conStatus(status) { //function for checking the connection status
        conCheck = status;
    }//end function conStatus

    /************************************************************************************************/
    /*************************************** DESIGN *************************************************/
    /************************************************************************************************/

    Rectangle{ // background rectangle
        id: background_rect

        width: page.width
        height: page.height

        color: "#ecf0f1"

        Column{
            id: principal_column

            /******** HEADER ********/

            Row{
                id: header1_row
                topPadding:   page.height * 0.01
                leftPadding:  page.width * 0.05
                rightPadding: page.width * 0.05
                bottomPadding:   page.height * 0.01

                Rectangle{
                    id: header1_rect
                    color: "#2c3e50"
                    radius: 5
                    width:  background_rect.width   * 0.90
                    height: background_rect.height  * 0.08

                    Text { //top screen Text
                        id: header1_text

                        text: qsTr("HEALTHCARE SYSTEM")
                        color: "white"

                        font.pixelSize: Qt.application.font.pixelSize * 1.2
                        leftPadding: 10

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }//end header1_text

                    Image { //WiFi Image
                        id: header1_image

                        source: conCheck ? "qrc:/images/wifiON.png" : "qrc:/images/wifiOFF.png"
                        smooth: true

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        height: parent.height * 0.95
                        width: parent.height * 0.95


                        sourceSize.width: 200
                        sourceSize.height: 200
                    }//end header1_image



                } //end header1_rect


            } //end header1_row

        } // end principal_column

    } //end background rectangle

}// end Page
