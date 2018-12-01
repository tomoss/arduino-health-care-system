//Arduino code
#include <SoftwareSerial.h>
SoftwareSerial s(10,11);
 
void setup() {
s.begin(9600);
}
 
void loop() {
  int data=50;
  if(s.available()>0)
  {
   s.write(data);
  }
}
