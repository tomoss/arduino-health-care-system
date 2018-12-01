#include <SoftwareSerial.h>
SoftwareSerial s(D6,D5);
int data;
void setup() {
  pinMode(D8,OUTPUT);
  s.begin(9600);
  Serial.begin(9600);
}
 
void loop() {
  s.write("s");
  if (s.available()>0)
  {
    data=s.read();
    Serial.println(data);
  }
  digitalWrite(D8,LOW);
 
 
}
