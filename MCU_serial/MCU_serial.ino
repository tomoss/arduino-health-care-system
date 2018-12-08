//#include <SoftwareSerial.h>
//SoftwareSerial s(D6,D5);
//int data;
//void setup() {
//  s.begin(9600);
//  Serial.begin(9600);
//}
// 
//void loop() {
//  s.write("s");
//  if (s.available()>0)
//  {
//    data=s.read();
//    Serial.println(data);
//  }
//
//}

#include <SoftwareSerial.h>
SoftwareSerial s(D6,D5);
String data2;
void setup() {
s.begin(9600);
Serial.begin(9600);
}
 
void loop() {
  String data="alb";
  if(s.available()>0)
  {
    data2=s.readString();
    Serial.println("why");
    Serial.println(data2);
    s.print(data);
  }
  delay(2000);
} 
