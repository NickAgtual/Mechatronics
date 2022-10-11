// Defining integer variables
int thermistor = 0; 
int fan = 6; 
int coil = 3; 
int button = 12; 
 
// Defining constants for the thermister as floats
float RThermistor = 100000; 
float Resistor = 100000; 
float Bvalue = 3950; 
float RTempRated = 25; 
 
// Defining temperature set-point (deg C)
float tempset = 85; 

// A flag is defined to record when the pushbutton has been pressed: 
bool flag=0; 

// The default PWMs for the fan and coil are defined so that the fan starts on at 40% PWM and the coil is 
// off: 
int fanPWM = 100;  
int coilPWM = 0; 
 
// The constants for recording the time between iterations are defined: 
int dt; 
int tic; 
int toc; 

void setup() {

  // Defining inputs and outputs
  pinMode(thermistor,INPUT); 
  pinMode(button,INPUT); 
  pinMode(fan, OUTPUT); 
  pinMode(coil, OUTPUT); 
  Serial.begin(9600);

}

void loop() { 
  
analogWrite(fan,fanPWM); //Turn on fan 

int buttonreading = digitalRead(button); //Read from button
 
float Farenheit = readTemperature(thermistor); //Store temperature value 

delay(10); // 10ms delay 
  
if (buttonreading == 1){ //Check if button is pressed 
      flag = abs(flag-1); //If pressed change the flag to the opposite value 
      delay(500); //Delay to negate contact bounce 
}     
 
if (flag==1){ //If flag is 1 turn on circuit (the lines below this will  
        //be modified in subsequent circuits  
     
// If setpoint is less than measured set coil to full power 
if (Farenheit<tempset)  
      coilPWM=255; 
       
else 
      coilPWM=0; //If setpoint is greater than measured set coil to 0 
  } 
  
  else 
  
 { 
        coilPWM=0;      //If flag is 0, set coil to zero 
 } 
 
analogWrite(coil,coilPWM); //Write PWM value to coil 
 
tic = millis();    //Record current time 
dt  = tic - toc;   //Compute time between iterations 
toc = tic;         //Store current time to previous time 

//Print out all variables 
Serial.print("FanPWM "); 
Serial.print(fanPWM); 
Serial.print(" CoilPWM "); 
Serial.print(coilPWM); 
Serial.print(" dt "); 
Serial.print(dt); 
Serial.print(" Temp "); 
Serial.println(Farenheit);  
} 

 
 
//Finally, we will define our temperature measuring function 
double readTemperature(int thermistor) //Function for reading from thermistor 
{ 
float reading = analogRead(thermistor); //Read analog input from  
                                          //thermistor 
 
float frac = reading/(1023 - reading); //Compute fractional voltage 
 
float Rval = Resistor * frac;   //Compute resistance from  
//thermistor 
 
float celsius = Rval/RThermistor;  //Remaining lines compute  
// temperature in Celsius 
 
celsius = log(celsius); 
celsius /= Bvalue; 
celsius += 1.0/(RTempRated+273.15); 
celsius = 1.0/celsius; 
celsius -= 273.15; 
return celsius*9.0/5.0 + 32.0;   //Return Fahrenheit  
} 
