#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <WebSocketsServer.h>
#include <Hash.h>
#include <SoftwareSerial.h>

SoftwareSerial s(D6,D5);
String data;
int ledPin = D4;
 
const char* ssid = "HUAWEI-yE9u";
const char* password = "2Arct44w";

WebSocketsServer webSocket = WebSocketsServer(81);
ESP8266WebServer server(80);

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
      
    server.begin();
    
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
    server.handleClient();

    if (s.available()>0)
    {
      data=s.readString();
      webSocket.broadcastTXT(data);    
    }
    

}

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length){
   if (type == WStype_TEXT){
    for(int i = 0; i < length; i++) {
      Serial.print((char) payload[i]);  
    }
    Serial.println();
    
    s.print(String((char *)payload));
   }
}
