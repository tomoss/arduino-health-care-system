#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <WebSocketsServer.h>
#include <Hash.h>
#include <SoftwareSerial.h>

SoftwareSerial s(D6,D5);
String data;
int ledPin = D7;
 
const char* ssid = "HUAWEI-yE9u";
const char* password = "2Arct44w";
//const char* ssid = "Nokia";
//const char* password = "qwerty1234";

WebSocketsServer webSocket = WebSocketsServer(81);
//ESP8266WebServer server(80);

void setup() {
  Serial.begin(9600);
  s.begin(9600);
  WiFi.setAutoReconnect(true);
  WiFi.begin(ssid, password);
  Serial.println("");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
   }
    
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(ssid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
      
    //server.begin();
    
    
    webSocket.begin();
    webSocket.onEvent(webSocketEvent);
    
    pinMode(ledPin, OUTPUT);    
}

void loop() {
  
      if (WiFi.status() == WL_CONNECTED) {
          digitalWrite(ledPin, HIGH);        
      } else {
          digitalWrite(ledPin, LOW);
      }
      
    webSocket.loop();
    //server.handleClient();

    if (s.available()>0)
    {
      data=s.readString();
      
      webSocket.broadcastTXT(data); 
      Serial.println(data);  
    }
    

}

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length){
   Serial.printf("[%u] get Message: %s\r\n", num, payload);
//   switch(type) {
//        case WStype_DISCONNECTED: 
//            Serial.println("client disconnected");     
//            break;
//        case WStype_CONNECTED: 
//            {
//              IPAddress ip = webSocket.remoteIP(num);
//              Serial.printf("[%u] Connected from %d.%d.%d.%d url: %s\r\n", num, ip[0], ip[1], ip[2], ip[3], payload);    
//            }
//            break;
//        case WStype_TEXT:
//            {
//              for(int i = 0; i < length; i++) {
//              Serial.print((char) payload[i]);
//        
//              }
//              s.print(String((char *)payload));
//              Serial.println();    
//           }
//         case WStype_BIN:
//            {
//              hexdump(payload, length);
//            }
//            // echo data back to browser
//            webSocket.sendBIN(num, payload, length);
//            Serial.printf("wtf");
//            break;
//   }

  
   if (type == WStype_TEXT){
    Serial.printf("[%u] get Message: %s\r\n", num, payload);
    for(int i = 0; i < length; i++) {
      Serial.print((char) payload[i]);
        
    }
    s.print(String((char *)payload));
    Serial.println();     
   }
}
