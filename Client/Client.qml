import QtQuick 2.0
import QtWebSockets 1.0
import QtQuick.Controls 1.4

Rectangle {
    width: 480
    height: 360
    visible: false

    property string serverIP: "192.168.100.10"
    property string serverPORT: "81"

    function setServer(ip,port){
        serverIP = ip;
        serverPORT = port;
    }//function for changing the client's URL


    function sendMessage(message) {
        if (socket.status === WebSocket.Open){
            socket.sendTextMessage(message)
            console.log("message sent: "+message)
        }
    }//function for the Client to send the state from the HMI


    WebSocket {
        id: socket
        url: "ws://" + serverIP + ":" + serverPORT

        onTextMessageReceived: {
            active: true

            console.log("message received: "+message);

            var result = message.split(';');
            var pulse = result[0];
            var temp = result[1];
            var alert = result[2];

            mainPage.setTemp(temp);
            mainPage.setPulse(pulse);
            mainPage.setInfo(temp,pulse)


            if(alert === "1"){
                mainPage.setAlert();
            }


        }//end onTextMessageReceived

        onStatusChanged:
            if (socket.status === WebSocket.Error) {
                console.log("Error")
                mainPage.conStatus(false);
            }  else if (socket.status === WebSocket.Closed) {
                console.log("Closed")
                 mainPage.conStatus(false);
            }  else if (socket.status === WebSocket.Open) {
                console.log("Open")
                mainPage.conStatus(true);
            }  else if (socket.status === WebSocket.Connecting) {
                console.log("Connecting...")
                 mainPage.conStatus(false);
            }  else if (socket.status === WebSocket.Closing) {
                console.log("Closing")
                 mainPage.conStatus(false);
            }



        active: false
    }//end WebSocket

    Timer {
        interval: 2000; running: true; repeat: true



        onTriggered: {

            if(socket.status == WebSocket.Closed || socket.status == WebSocket.Error )
            {
                socket.active = false;
                socket.active = true;
                console.log("Reconnecting...")
            }

        }//end onTriggered



    }//end Timer


}//end Rectangle


