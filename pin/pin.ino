#include <SoftwareSerial.h>
SoftwareSerial s(10,11);

const int led =2;
String data;
void setup(){
 Serial.begin(9600);
 s.begin(115200);
 pinMode(led,OUTPUT);
 
 delay(2000);
 
}
void loop()
{
if(s.available()>0)
  {
   data=s.readString();
   
   if(data.equals("ON")){
      Serial.println(data);
      s.print(String("bec aprins"));
      digitalWrite(led, HIGH);
    } else
    if(data.equals("OFF")){
      Serial.println(data);
      s.print(String("bec stins"));
      digitalWrite(led, LOW);

    } else 
    Serial.println(String("error: ")+data);
    
   
  }

}
