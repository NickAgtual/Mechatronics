
#define POT1 A0 //servo potentiometer pin 
#define POT2 A1 //input potentiometer pin 
#define DIRA 7  //Direction pin  
#define DIRB 8  //Direction pin 
#define ENABLE 9 //Enable pin 

float error=0;            //Define error variable 
float previous_error=0;   //Define previous error for derivative 
float integral=0;         //Define integral variable 
float derivative=0;       //Define derivative variable 
float proportional=0;               
float dt=0; 
float tic=0; 
float toc=0; 
float Kd=15;   //Derivative Constant 
float Kp=0;   //Proportional Constant 
float Ki=0.0;   //Integral Constant 
float PWM=0; 

void setup() {
  
  pinMode(DIRA, OUTPUT); 
  pinMode(DIRB, OUTPUT); 
  pinMode(ENABLE, OUTPUT); 
  pinMode(POT1, INPUT); 
  pinMode(POT2, INPUT); 
  Serial.begin(9600); 
  TCCR1B = TCCR1B & B11111000 | B00000001; // Changes the PWM to 31kHz

}

void loop() {
  
previous_error=error; 
  int position_servo = analogRead(POT1); 
  int position_input = analogRead(POT2); 
  error=position_input-position_servo;      //compute position error 
  integral=integral+Ki*error*dt;            // compute integral 
  derivative=(error-previous_error)*Kd/dt;  // compute derivative 
  proportional=Kp*error;                    // compute proportional  
  PWM=proportional+derivative+integral;     // input to plant computed from PID controller 
  dt=(tic-toc)/1000.0;                       //time in seconds     
  toc=tic; 
  tic=millis(); 
  if (PWM>255)                              // limit PWM output 
    PWM=255; 
  if (PWM<-255) 
    PWM=-255; 
  if (PWM>0){                               // Set motor direction to motor controller 
    digitalWrite(DIRA,1); 
    digitalWrite(DIRB,0); 
    analogWrite(ENABLE,PWM); 
  } 
  else{ 
    digitalWrite(DIRA,0); 
    digitalWrite(DIRB,1); 
    analogWrite(ENABLE,-PWM); 
  }                                         // Print relevant data 
  Serial.print(error); 
  Serial.print(" "); 
  Serial.print(previous_error); 
  Serial.print(" "); 
  Serial.print(integral); 
  Serial.print(" "); 
  Serial.print(derivative); 
  Serial.print(" "); 
  Serial.print(PWM); 
  Serial.print(" "); 
  Serial.print(dt); 
  Serial.print(" "); 
  Serial.print(position_servo); 
  Serial.print(" "); 
  Serial.println(position_input); 

}
