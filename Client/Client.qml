import QtQuick 2.0
import QtWebSockets 1.0
import QtQuick.Controls 1.4

Rectangle {
    width: 480
    height: 360
    visible: false

    property string states: ""
    property string serverIP: "192.168.43.76"
    property string serverPort: "81"

    function setServer(ip,port){
        serverIP = ip;
        serverPort = port;
    }//function for changing the client's URL


    function sendMessage(message) {
        if (socket.status === WebSocket.Open){
            socket.sendTextMessage(message)
            console.log("message sent: "+message)
        }
    }//function for the Client to send the state from the HMI


    WebSocket {
        id: socket
        url: "ws://" + serverIP + ":" + serverPort

        onTextMessageReceived: {
            active: true

            console.log("message received: "+message);

            var result = message.split(';');
            var pulse = parseFloat(result[0]);
            var temp = parseFloat(result[1]);

            mainPage.setTemp(result[1]);
            mainPage.setPulse(result[0]);

            if(temp < 37.2 && pulse <  100){
                mainPage.setMessage("Temperature and pulse are normal.")
            }
            else if(temp >= 37.2 && pulse < 100){
                mainPage.setMessage("Temperature is high !")
            }
            else if(temp < 37.2 && pulse > 100){
                mainPage.setMessage("Heart rate is high !")
            } else{
                mainPage.setMessage("Temperature and pulse are high !")
            }

            if(result[2] === true){
                mainPage.setAlert("ALERT !!");
            }


        }//end onTextMessageReceived

        onStatusChanged:
            if (socket.status === WebSocket.Error) {
                console.log("Error")
            }  else if (socket.status === WebSocket.Closed) {
                console.log("Closed")
            }  else if (socket.status === WebSocket.Open) {
                console.log("Open")
            }  else if (socket.status === WebSocket.Connecting) {
                console.log("Connecting...")
            }  else if (socket.status === WebSocket.Closing) {
                console.log("Closing")
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
//            if (socket.status === WebSocket.Error) {
//                console.log("Error")

//            }  else if (socket.status === WebSocket.Closed) {
//                console.log("Closed")

//            }  else if (socket.status === WebSocket.Open) {
//                console.log("Open")
//            }  else if (socket.status === WebSocket.Connecting) {
//                console.log("Connecting")
//            }  else if (socket.status === WebSocket.Closing) {
//                console.log("Closing")
//            } else {
//                console.log("wtf")
//            }

        }//end onTriggered



    }//end Timer


}//end Rectangle


