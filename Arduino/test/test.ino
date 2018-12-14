#include <SoftwareSerial.h>
SoftwareSerial s(10,11); //pins for serial communication

#define USE_ARDUINO_INTERRUPTS true    // Set-up low-level interrupts for most acurate BPM math.
#include <PulseSensorPlayground.h>     // Includes the PulseSensorPlayground Library.   

//  Variables
const int PulsePin = 0; // PulseSensor  connected to ANALOG PIN 0
const int TempPin = 1;  // LM35Sensor  connected to ANALOG PIN 1
const int PulseLedPin  = 13;
const int ButtonLedPin = 5;
const int ButtonPin = 2;          
boolean ButtonState = false;
int Threshold = 550;           // Determine which Signal to "count as a beat" and which to ignore.
                               // Use the "Gettting Started Project" to fine-tune Threshold Value beyond default setting.
                               // Otherwise leave the default "550" value. 
float vmed = 0;
float ve = 0;
int beats =0;
int heartRate=0; 
float temperatureC = 0;

int k = 0;
                               
PulseSensorPlayground pulseSensor;  // Creates an instance of the PulseSensorPlayground object called "pulseSensor"


void setup() {   

  Serial.begin(9600);          // For Serial Monitor
  s.begin(9600);

  pinMode(PulseLedPin,OUTPUT);
  pinMode(ButtonLedPin,OUTPUT);
  pinMode(ButtonPin,INPUT);
  

  // Configure the PulseSensor object, by assigning our variables to it. 
  pulseSensor.analogInput(PulsePin);   
  pulseSensor.blinkOnPulse(PulseLedPin);       //auto-magically blink Arduino's LED with heartbeat.
  pulseSensor.setThreshold(Threshold);   

  // Double-check the "pulseSensor" object was created and "began" seeing a signal. 
   if (pulseSensor.begin()) {
    Serial.println("We created a pulseSensor Object !");  //This prints one time at Arduino power-up,  or on Arduino reset.  
  }


  int vmed = 0;
  int ve=0;
  
 delay(2000);
  
}



void loop() {
  
 vmed = 0;
 ve=0;
 k=0; 

 ButtonState = digitalRead(ButtonPin);

 if(ButtonState == HIGH){
   digitalWrite(ButtonLedPin, HIGH);
 } else {
   digitalWrite(ButtonLedPin, LOW);
 }
 
  
// for (int j = 0; j < 10; j++)  { 
//      //getting the voltage reading from the temperature sensor
//      int reading = analogRead(TempPin);  
//      
//      // converting that reading to voltage, for 3.3v arduino use 3.3
//      float voltage = reading * 5.0;
//      voltage /= 1024.0; 
//      
//      vmed = vmed + voltage;
//      delay(200);
// }
//  ve = vmed/10;

  unsigned long starttime = millis(); //timp de inceput pentru masuratoare 
  unsigned long endtime = starttime;
  while ((endtime - starttime) <=15000) // repeta 15 secunde 
  {
    if (pulseSensor.sawStartOfBeat()) {            // verificam aparitia pulsului 
   Serial.println("♥  A HeartBeat Happened ! ");
   beats++;}

   int reading = analogRead(TempPin); 
   float voltage = reading * 5.0;
   voltage /= 1024.0;
   vmed = vmed + voltage;
   k++;
  
   
   endtime = millis();

   

   
 }
 
 heartRate = beats*4;
 Serial.println(heartRate); // print batai / minut
 beats = 0;

 ve = vmed/k;
 temperatureC = ve * 100 ;
 Serial.println("Pulse: "+String(heartRate)+" Temp: "+String(temperatureC)+" Button: "+String(ButtonState));

 if(s.available()>0)
 {
      s.print(String(heartRate)+";"+String(temperatureC)+";"+ButtonState);
      ButtonState = false;
      
 }
  delay(20); 
        
}

                


  
