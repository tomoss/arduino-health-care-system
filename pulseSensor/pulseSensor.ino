#include <SoftwareSerial.h>
SoftwareSerial s(10,11);

#define USE_ARDUINO_INTERRUPTS true    // Set-up low-level interrupts for most acurate BPM math.
#include <PulseSensorPlayground.h>     // Includes the PulseSensorPlayground Library.   

//  Variables
const int PulseWire = 0; 
const int TempWire = 1;// PulseSensor PURPLE WIRE connected to ANALOG PIN 0
const int LedWire = 7;
const int ButtonWire = 5;
const int LED13 = 13;          // The on-board Arduino LED, close to PIN 13.
boolean ButtonState = false;
int Threshold = 550;           // Determine which Signal to "count as a beat" and which to ignore.
                               // Use the "Gettting Started Project" to fine-tune Threshold Value beyond default setting.
                               // Otherwise leave the default "550" value. 
float vmed = 0;
float ve = 0; 
                               
PulseSensorPlayground pulseSensor;  // Creates an instance of the PulseSensorPlayground object called "pulseSensor"


void setup() {   

  Serial.begin(9600);          // For Serial Monitor
  s.begin(9600);

  pinMode(LedWire,OUTPUT);
  
  

  // Configure the PulseSensor object, by assigning our variables to it. 
  pulseSensor.analogInput(PulseWire);   
  pulseSensor.blinkOnPulse(LED13);       //auto-magically blink Arduino's LED with heartbeat.
  pulseSensor.setThreshold(Threshold);   

  // Double-check the "pulseSensor" object was created and "began" seeing a signal. 
   if (pulseSensor.begin()) {
    Serial.println("We created a pulseSensor Object !");  //This prints one time at Arduino power-up,  or on Arduino reset.  
  }
  
 delay(2000);
  
}



void loop() {

  int beats =0;
  int hearthRate=0;

  vmed = 0;
  ve=0;

  
  
 for (int j = 0; j < 10; j++)  { 
      //getting the voltage reading from the temperature sensor
      int reading = analogRead(TempWire);  
      
      // converting that reading to voltage, for 3.3v arduino use 3.3
      float voltage = reading * 5.0;
      voltage /= 1024.0; 
      
      vmed = vmed + voltage;
      delay(200);
 }
  ve = vmed/10;

  unsigned long starttime = millis(); //timp de inceput pentru masuratoare 
  unsigned long endtime = starttime;
  while ((endtime - starttime) <=15000) // repeta 15 secunde 
  {
    if (pulseSensor.sawStartOfBeat()) {            // verificam aparitia pulsului 
   Serial.println("♥  A HeartBeat Happened ! ");
   beats++;}
   endtime = millis();
   
  
   int val = digitalRead(ButtonWire);
   
//   Serial.println(val);
   if(val == HIGH){
    //Serial.println("wtf");
     ButtonState = true;
     digitalWrite(LedWire,HIGH);
   }

  }
  
  //Serial.print("Beats per minute:");
  //Serial.println(beats*4); //print bataile / minut
  hearthRate = beats*4;
  float temperatureC = ve * 100 ;
  Serial.println("P "+String(hearthRate)+" T "+String(temperatureC)+" "+String(ButtonState));

  if(s.available()>0)
  {
      s.print(String(hearthRate)+";"+String(temperatureC)+";"+ButtonState);
      ButtonState = false;
      digitalWrite(LedWire,LOW);
      
  }
   delay(20); 
        
}

                


  
