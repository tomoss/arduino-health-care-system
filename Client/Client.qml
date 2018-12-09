import QtQuick 2.0
import QtWebSockets 1.0
import QtQuick.Controls 1.4

Rectangle {
    width: 480
    height: 360
    visible: false

    property string states: ""
    property string serverIP: "192.168.100.10"
    property string serverPort: "81"

//    function setServer(ip,port){
//        serverIP = ip;
//        serverPort = port;
//    }//function for changing the client's URL


    function sendState(stateName) {
        if (socket.status === WebSocket.Open){
            socket.sendTextMessage(stateName)
            console.log("trimis "+stateName)
        }
    }//function for the Client to send the state from the HMI


    WebSocket {
        id: socket
        url: "ws://" + serverIP + ":" + serverPort

        onTextMessageReceived: {
            active: true
            states = message;

            console.log(message);
            mainW.setText(message);



        }//end onTextMessageReceived

        onStatusChanged:
            if (socket.status === WebSocket.Error) {
                console.log("Error")

            }  else if (socket.status === WebSocket.Closed) {
                console.log("Closed")

            }  else if (socket.status === WebSocket.Open) {
                console.log("Open")
            }



        active: false
    }//end WebSocket

    Timer {
        interval: 2000; running: true; repeat: true



        onTriggered: {
            if(socket.status == WebSocket.Closed || socket.status == WebSocket.Error)
            {
                socket.active = false;
                socket.active = true;
                console.log(socket.status)

            }//end if
        }//end onTriggered
    }//end Timer
}//end Rectangle


