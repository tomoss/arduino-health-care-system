////Arduino code
//#include <SoftwareSerial.h>
//SoftwareSerial s(10,11);
// 
//void setup() {
//s.begin(9600);
//}
// 
//void loop() {
//  int data=50;
//  if(s.available()>0)
//  {
//   s.write(data);
//  }
//  delay(5000);
//}

//Arduino code
#include <SoftwareSerial.h>
SoftwareSerial s(10,11);
String data;
void setup() {
  s.begin(9600);
  Serial.begin(9600);
}
 
void loop() {
  String data2="bla";
  if (s.available()>0)
  {
    data=s.readString();
    Serial.println(data);
    s.print(data2);
  }

}
