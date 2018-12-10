#include <SoftwareSerial.h>
SoftwareSerial s(10,11);

int sensorPin = 0; 

float vmed = 0;
float ve = 0;  


void setup()
{
  Serial.begin(9600);  //Start the serial connection with the computer
   s.begin(9600);
}
 
void loop()                     // run over and over again
{
 vmed = 0;
 ve=0;
  
 for (int j = 0; j < 10; j++)  {
  
 //getting the voltage reading from the temperature sensor
 int reading = analogRead(sensorPin);  
    
 // converting that reading to voltage, for 3.3v arduino use 3.3
 float voltage = reading * 5.0;
 voltage /= 1024.0; 
 
 vmed = vmed + voltage;
 delay(200);
 
 }
 ve = vmed/10;
 
 // print out the voltage
 Serial.print(ve); Serial.println(" volts");
 
 // now print out the temperature
 float temperatureC = ve * 100 ;  //converting from 10 mv per degree 
                                               //to degrees (voltage) times 100)
 Serial.print(temperatureC); Serial.println(" degrees C");
 if(s.available()>0){
  s.print(String(temperatureC),2);
 }

 Serial.println("----------------");
 delay(1000);                                     //waiting a second
}
